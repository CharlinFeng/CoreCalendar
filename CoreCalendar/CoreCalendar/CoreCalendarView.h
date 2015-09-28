//
//  CoreCalendarView.h
//  CoreCalendar
//
//  Created by 冯成林 on 15/9/28.
//  Copyright © 2015年 冯成林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreCalendarType.h"

@interface CoreCalendarView : UIView

/** 菜单高度 */
@property (nonatomic,assign) CGFloat meauH;


+(instancetype)calendarViewWithCalendarType:(CoreCalendarType)calendarType;

@end
