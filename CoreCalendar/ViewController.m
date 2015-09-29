//
//  ViewController.m
//  CoreCalendar
//
//  Created by 冯成林 on 15/9/16.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "ViewController.h"
#import "CoreCalendarView.h"
#import "ServiceModel.h"


@interface ViewController ()<CoreCalendarDelegate>

@property (nonatomic,strong) CoreCalendarView *calendarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    CoreCalendarView *calendarView = [CoreCalendarView calendarViewWithCalendarType:CoreCalendarTypeHorizontal];
    
    self.calendarView=calendarView;
    
    calendarView.delegate = self;
    
    ServiceModel *m1 = [[ServiceModel alloc] init];
    m1.timestamp = @"1444694400";
    m1.offEdit = NO;
    
    ServiceModel *m2 = [[ServiceModel alloc] init];
    m2.timestamp = @"1442275200";
    m2.offEdit = NO;
    
    ServiceModel *m3 = [[ServiceModel alloc] init];
    m3.timestamp = @"1441929600";
    m3.offEdit = YES;
    
    ServiceModel *m4 = [[ServiceModel alloc] init];
    m4.timestamp = @"1443139200";
    m4.offEdit = NO;
    
    ServiceModel *m5 = [[ServiceModel alloc] init];
    m5.timestamp = @"1445385600";
    m5.offEdit = NO;

    calendarView.isDarkEarlierDays = YES;
    
    self.calendarView.timestampsIn = @[m1,m2,m3,m4,m5];

    calendarView.frame = CGRectMake(10, 10, 300, 300);
    
    [self.view addSubview:calendarView];
    
    NSDate *date = [NSDate date];
    
    calendarView.ClickDayBlock =  ^BOOL(NSDate *d){
    
        BOOL res = date.timeIntervalSince1970 - 3600 * 24 <= d.timeIntervalSince1970;
    
        return res;
    };
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSArray *timestamps = self.calendarView.timestampsOut;
    
    
}


-(NSNumber *)coreCalendarLeftMonths{
    return @-1;
}

-(NSNumber *)coreCalendarRightMonths{
    return @2;
}



@end
