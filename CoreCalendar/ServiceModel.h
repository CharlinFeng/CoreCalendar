//
//  ServiceModel.h
//  CoreCalendar
//
//  Created by 冯成林 on 15/9/29.
//  Copyright © 2015年 冯成林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreCalendarProtocol.h"

@interface ServiceModel : NSObject<CoreCalendarProtocol>

@property (nonatomic,copy) NSString *timestamp;

@property (nonatomic,assign) BOOL offEdit;

@end
