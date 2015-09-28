//
//  CoreCalendarView.m
//  CoreCalendar
//
//  Created by 冯成林 on 15/9/28.
//  Copyright © 2015年 冯成林. All rights reserved.
//

#import "CoreCalendarView.h"
#import "JTCalendar.h"

@interface CoreCalendarView ()<JTCalendarDelegate>

@property (nonatomic,strong) JTCalendarManager *mgr;

@property (nonatomic,strong) JTCalendarMenuView *meauView;

@property (nonatomic,strong) UIScrollView<JTContent> *calendarView;



/** 是否为水平模式 */
@property (nonatomic,assign) CoreCalendarType calendarType;




@end


@implementation CoreCalendarView


+(instancetype)calendarViewWithCalendarType:(CoreCalendarType)calendarType{
    
    CoreCalendarView *cv = [[CoreCalendarView alloc] init];
    
    cv.calendarType = calendarType;
    
    [cv calendarViewPrepare];
    
    return cv;
}





-(void)calendarViewPrepare{
    
    [super awakeFromNib];
    
    /** 添加菜单 */
    [self addSubview:self.meauView];
    
    /** 添加日历主体视图 */
    [self addSubview:self.calendarView];
    
    //设置当前日期
    self.mgr.date = [NSDate date];
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGRect frame = self.bounds;
    
    CGRect meauF = CGRectMake(0, 0, frame.size.width, self.meauH);
    self.meauView.frame = meauF;
    
    CGRect calendarViewF = CGRectMake(0, self.meauH, frame.size.width, frame.size.height - self.meauH);
    self.calendarView.frame = calendarViewF;
}






/** 管理器 */
-(JTCalendarManager *)mgr{
    
    if(_mgr == nil){
        
        _mgr = [[JTCalendarManager alloc] init];
        
        _mgr.menuView = self.meauView;
        _mgr.contentView = self.calendarView;
        _mgr.delegate = self;
    }
    
    return _mgr;
}


/** 菜单 */
-(JTCalendarMenuView *)meauView{
    
    if(_meauView == nil){
        
        _meauView = [[JTCalendarMenuView alloc] init];
    }
    
    return _meauView;
}

/** 菜单主体 */
-(UIScrollView<JTContent> *)calendarView{
   
    if(_calendarView == nil){
        
        if(CoreCalendarTypeHorizontal == self.calendarType){
            _calendarView = [[JTHorizontalCalendarView alloc] init];
        }else{
            _calendarView = [[JTVerticalCalendarView alloc] init];
        }
        
    }
    
    return _calendarView;
}

/** 菜单高度 */
-(CGFloat)meauH{
    
    if(_meauH == 0){
        _meauH = 40;
    }
    
    return _meauH;
}


@end
