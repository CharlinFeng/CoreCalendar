//
//  CoreCalendarProtocol.h
//  CoreCalendar
//
//  Created by 冯成林 on 15/9/29.
//  Copyright © 2015年 冯成林. All rights reserved.
//


@protocol CoreCalendarProtocol <NSObject>

@property (nonatomic,copy) NSString *timestamp;

@property (nonatomic,assign) BOOL offEdit;

@end




@protocol CoreCalendarDelegate <NSObject>
@required
-(NSNumber *)coreCalendarLeftMonths;
-(NSNumber *)coreCalendarRightMonths;

@end



