//
//  CoreCalendarDayView.h
//  CoreCalendar
//
//  Created by 冯成林 on 15/9/29.
//  Copyright © 2015年 冯成林. All rights reserved.
//

#import "JTCalendarDayView.h"
#import "CoreCalendarProtocol.h"

@interface CoreCalendarDayView : JTCalendarDayView

@property (nonatomic,strong) id<CoreCalendarProtocol> dayModel;

@end
