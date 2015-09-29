//
//  CoreCalendarDayView.m
//  CoreCalendar
//
//  Created by 冯成林 on 15/9/29.
//  Copyright © 2015年 冯成林. All rights reserved.
//

#import "CoreCalendarDayView.h"

@implementation CoreCalendarDayView


-(void)setDayModel:(id<CoreCalendarProtocol>)dayModel{
    
    _dayModel = dayModel;
    
    if(dayModel.offEdit){
        self.circleView.layer.borderWidth = 1.5;
        self.circleView.layer.borderColor = [UIColor yellowColor].CGColor;
    }else{
        self.circleView.layer.borderWidth=0;
        self.circleView.layer.borderColor = [UIColor clearColor].CGColor;
    }
}

@end
