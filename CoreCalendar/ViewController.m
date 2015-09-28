//
//  ViewController.m
//  CoreCalendar
//
//  Created by 冯成林 on 15/9/16.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "ViewController.h"
#import "CoreCalendarView.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CoreCalendarView *calendarView = [CoreCalendarView calendarViewWithCalendarType:CoreCalendarTypeHorizontal];
    
    calendarView.frame = CGRectMake(0, 0, 320, 320);
    
    [self.view addSubview:calendarView];
}







@end
