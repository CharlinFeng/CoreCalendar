//
//  CoreCalendarView.m
//  CoreCalendar
//
//  Created by 冯成林 on 15/9/28.
//  Copyright © 2015年 冯成林. All rights reserved.
//

#import "CoreCalendarView.h"
#import "JTCalendar.h"
#import "CoreCalendarView+JTCalendarManager.h"


@interface CoreCalendarView ()<JTCalendarDelegate>

@property (nonatomic,strong) JTCalendarManager *mgr;

@property (nonatomic,strong) JTCalendarMenuView *meauView;

@property (nonatomic,strong) UIScrollView<JTContent> *calendarView;

@property (nonatomic,assign) CoreCalendarType calendarType;

@property (nonatomic,strong) NSMutableDictionary *eventsByDate;

@property (nonatomic,strong) NSDateFormatter *dateFormatter;

@property (nonatomic,strong) UIButton *todayBtn;

@property (nonatomic,strong) NSMutableArray *datesSelected;

@property (nonatomic,strong) NSDate *todayDate;


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
    self.mgr.date = self.todayDate;
    
    //添加返回今天按钮
    [self addSubview:self.todayBtn];
    
    //设置可查看月度
    [self.mgr.dateHelper addToDate:self.todayDate months:-2];
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    NSAssert(self.delegate != nil, @"[Charlin Feng]: delegate must have value!");
    
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
        _mgr.dateHelper.calendar.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        _mgr.dateHelper.calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
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



-(NSDateFormatter *)dateFormatter{
    
    if(_dateFormatter == nil){
        
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    return _dateFormatter;
}


-(UIButton *)todayBtn{
    
    if (_todayBtn == nil){
        
        _todayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_todayBtn setTitle:@"返回" forState:UIControlStateNormal];
        _todayBtn.backgroundColor = [UIColor whiteColor];
        [_todayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_todayBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        _todayBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _todayBtn.frame = CGRectMake(0, 10, 60, 20);
        [_todayBtn addTarget:self action:@selector(toToday) forControlEvents:UIControlEventTouchUpInside];
        _todayBtn.hidden = YES;
    }
    
    return _todayBtn;
}



-(void)setTimestampsIn:(NSArray *)timestampsIn{
    
    _timestampsIn = [NSMutableArray arrayWithArray:timestampsIn];
    
    [self.mgr reload];
}


-(NSMutableArray *)datesSelected{
    
    if(_datesSelected == nil){
        
        _datesSelected = [NSMutableArray array];
    }
    
    return _datesSelected;
}



-(NSArray *)timestampsOut{
    
    NSMutableArray *timestampsM = [NSMutableArray arrayWithCapacity:self.datesSelected.count];
    
    [self.datesSelected enumerateObjectsUsingBlock:^(NSDate *date, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *t = [NSString stringWithFormat:@"%.0f",[date timeIntervalSince1970]];
        
        [timestampsM addObject:t];
    }];
    
    return [timestampsM copy];
}

-(NSDate *)todayDate{
    
    if(_todayDate == nil){
        
        _todayDate = [NSDate date];
    }
    
    return _todayDate;
}


-(void)setIsDarkEarlierDays:(BOOL)isDarkEarlierDays{
    
    _isDarkEarlierDays = isDarkEarlierDays;
    
    [self.mgr reload];
}



-(NSDate *)dateFromNowWithMonths:(NSInteger)months{
    return [self.mgr.dateHelper addToDate:self.todayDate months:months];
}

@end
