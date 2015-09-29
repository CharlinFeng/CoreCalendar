//
//  CoreCalendarView+JTCalendarManager.m
//  CoreCalendar
//
//  Created by 冯成林 on 15/9/29.
//  Copyright © 2015年 冯成林. All rights reserved.
//

#import "CoreCalendarView+JTCalendarManager.h"
#import "CoreCalendarDayView.h"
#import "UIView+Anim.h"

static const BOOL showAnothMonthDays = 1;


@interface CoreCalendarView ()<JTCalendarDelegate>

@property (nonatomic,strong) JTCalendarManager *mgr;

@property (nonatomic,strong) JTCalendarMenuView *meauView;

@property (nonatomic,strong) UIScrollView<JTContent> *calendarView;

@property (nonatomic,strong) NSMutableDictionary *eventsByDate;

@property (nonatomic,strong) NSDateFormatter *dateFormatter;

@property (nonatomic,strong) UIButton *todayBtn;

@property (nonatomic,strong) NSMutableArray *datesSelected;

@property (nonatomic,strong) NSDate *todayDate;

@end




@implementation CoreCalendarView (JTCalendarManager)


-(UIView<JTCalendarDay> *)calendarBuildDayView:(JTCalendarManager *)calendar{
    
    CoreCalendarDayView *dayView = [[CoreCalendarDayView alloc] init];
    return dayView;
}

/** 日期视图 */
-(void)calendar:(JTCalendarManager *)calendar prepareDayView:(CoreCalendarDayView *)dayView{

    /** 通用 */
    if([dayView isFromAnotherMonth]){
        
        if (showAnothMonthDays) {
            dayView.textLabel.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        }else{
            dayView.hidden = YES;
        }
    }

    /** 今天 */
    if([self.mgr.dateHelper date:self.todayDate isTheSameDayThan:dayView.date]){


        if([self isInDatesSelected:dayView.date]){
            
            dayView.circleView.backgroundColor = [UIColor redColor];
            dayView.textLabel.textColor = [UIColor whiteColor];
            dayView.dotView.backgroundColor = [UIColor whiteColor];
            
        }else{
            dayView.circleView.hidden = NO;
            dayView.circleView.alpha=1;
            dayView.dotView.hidden = NO;
            dayView.dotView.alpha = 1;
            dayView.circleView.backgroundColor = [UIColor clearColor];
            dayView.dotView.backgroundColor = [UIColor redColor];
            dayView.textLabel.font = [UIFont boldSystemFontOfSize:18];
            dayView.textLabel.textColor = [UIColor blackColor];
        }
    }
    
    /** 选中日期 */
    else if([self isInDatesSelected:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    
    /** 其他月份 */
    else if(![self.mgr.dateHelper date:self.calendarView.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        dayView.dotView.hidden=YES;
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
        dayView.textLabel.font = [UIFont systemFontOfSize:14];
    }
    
    /** 默认日期选中 */
    if(self.timestampsIn==nil || self.timestampsIn.count == 0) return;

    [self.timestampsIn enumerateObjectsUsingBlock:^(id<CoreCalendarProtocol> p, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if([self.mgr.dateHelper date:dayView.date isTheSameDayThan:[NSDate dateWithTimeIntervalSince1970:p.timestamp.integerValue]]){
           
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((0.5) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self clickDate:self.mgr dayView:dayView needScrollToPage:NO isAutoClick:YES];
            });
            
            dayView.dayModel = p;
    
            [(NSMutableArray *)self.timestampsIn removeObject:p];
        }
    }];
    
}

/** 选中日期 */
-(void)calendar:(JTCalendarManager *)calendar didTouchDayView:(CoreCalendarDayView *)dayView{

    [self clickDate:calendar dayView:dayView needScrollToPage:YES isAutoClick:NO];
}


/** 日期点击事件 */
-(void)clickDate:(JTCalendarManager *)calendar dayView:(CoreCalendarDayView *)dayView needScrollToPage:(BOOL)needScrollToPage isAutoClick:(BOOL)isAutoClick{

    if(dayView.dayModel.offEdit && !isAutoClick){
        
        [dayView shake];

        return;
    }
    
    dayView.userInteractionEnabled = NO;
    
    if([self isInDatesSelected:dayView.date]){
        
        [self.datesSelected removeObject:dayView.date];
        
        [self.mgr reload];
        
        dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, -0.1, -0.1);

        dayView.userInteractionEnabled = YES;
        
    }else{
    
        [self.datesSelected addObject:dayView.date];
        
        dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
  
        [UIView transitionWithView:dayView duration:.3 options:0 animations:^{
                            
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            
            [self.mgr reload];
            
            dayView.circleView.transform = CGAffineTransformMakeScale(1, 1);
            
        } completion:^(BOOL finished) {
            
            dayView.userInteractionEnabled = YES;
        }];
    }
    
    if(!needScrollToPage) return;
    
    /** 附近月份日期 */
    if(![self.mgr.dateHelper date:self.calendarView.date isTheSameMonthThan:dayView.date]){
        
        if([self.calendarView.date compare:dayView.date] == NSOrderedAscending){
            
            [self.calendarView loadNextPageWithAnimation];
            
        }else{
            
            [self.calendarView loadPreviousPageWithAnimation];
        }
    }
}



- (BOOL)haveEventForDay:(NSDate *)date{
    
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(self.eventsByDate[key] && [self.eventsByDate[key] count] > 0){
        
        return YES;
    }
    
    return NO;
}


/** 周视图 */
- (UIView<JTCalendarWeekDay> *)calendarBuildWeekDayView:(JTCalendarManager *)calendar{
    
    JTCalendarWeekDayView *view = [[JTCalendarWeekDayView alloc] init];
    
    for(UILabel *label in view.dayViews){
        
        label.textColor = [UIColor blackColor];
        
        label.font = [UIFont systemFontOfSize:15];
    }
    
    return view;
}


/** 头部日期视图 */
- (void)calendar:(JTCalendarManager *)calendar prepareMenuItemView:(UILabel *)menuItemView date:(NSDate *)date
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"YYYY年 MM月";
        
        dateFormatter.locale = self.mgr.dateHelper.calendar.locale;
        dateFormatter.timeZone = self.mgr.dateHelper.calendar.timeZone;
    }
    
    menuItemView.text = [dateFormatter stringFromDate:date];
}

- (void)calendarDidLoadNextPage:(JTCalendarManager *)calendar{
    [self chechIsCurrentMonth:calendar];
}

- (void)calendarDidLoadPreviousPage:(JTCalendarManager *)calendar{
    [self chechIsCurrentMonth:calendar];
}


-(void)chechIsCurrentMonth:(JTCalendarManager *)calendar{
    
    BOOL isCurrentMonth = [calendar.dateHelper date:calendar.date isTheSameMonthThan:self.todayDate];
    
    self.todayBtn.hidden = isCurrentMonth;
}


-(void)toToday{
    
    [self.mgr setDate:self.todayDate];
    
    [self chechIsCurrentMonth:self.mgr];
}

- (BOOL)isInDatesSelected:(NSDate *)date{
    for(NSDate *dateSelected in self.datesSelected){
        
        if([self.mgr.dateHelper date:dateSelected isTheSameDayThan:date]){
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)calendar:(JTCalendarManager *)calendar canDisplayPageWithDate:(NSDate *)date{

    return [self.mgr.dateHelper date:date isEqualOrAfter:self.leftDate andEqualOrBefore:self.rightDate];
}



@end
