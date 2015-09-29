//
//  CALayer+Anim.m
//  CoreCalendar
//
//  Created by 冯成林 on 15/9/29.
//  Copyright © 2015年 冯成林. All rights reserved.
//

#import "UIView+Anim.h"

@implementation UIView (Anim)


-(void)shake{
    
    CAKeyframeAnimation *kfa=[CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    
    //值
    CGFloat angle = 2.f;
    
    kfa.values=@[@(angle),@(0),@(-angle*0.9),@(0),@(angle*0.8),@(0),@(-angle*0.7)];
    
    //设置时间
    kfa.duration=0.1f;
    
    //是否重复
    kfa.repeatCount=2.0f;
    
    //是否反转
    kfa.autoreverses=YES;
    
    //完成移除
    kfa.removedOnCompletion=YES;

    [self.layer addAnimation:kfa forKey:@"shake"];
}

@end
