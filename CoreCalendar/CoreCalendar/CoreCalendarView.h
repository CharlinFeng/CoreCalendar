//
//  CoreCalendarView.h
//  CoreCalendar
//
//  Created by 冯成林 on 15/9/28.
//  Copyright © 2015年 冯成林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreCalendarType.h"
#import "CoreCalendarProtocol.h"



@interface CoreCalendarView : UIView

/** 菜单高度 */
@property (nonatomic,assign) CGFloat meauH;

@property (nonatomic,strong) NSArray<id<CoreCalendarProtocol>> *timestampsIn;

@property (nonatomic,strong) NSArray<NSString *> *timestampsOut;

@property (nonatomic,assign) NSDate *leftDate,*rightDate;



+(instancetype)calendarViewWithCalendarType:(CoreCalendarType)calendarType;


-(NSDate *)dateFromNowWithMonths:(NSInteger)months;


@end
