//
//  NSTimer+Category.m
//  admin
//
//  Created by haitao on 15/9/21.
//  Copyright © 2015年 haitao. All rights reserved.
//

#import "NSTimer+Category.h"

@implementation NSTimer (Category)

+ (instancetype)schemeTimerTarget:(id)target selector:(SEL)selector timeInterval:(NSTimeInterval)time
{
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:time target:target selector:selector userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    //加到Modes RunLoop中防止因ScrollView滑动导致runLoop切换 导致计时器不准确
    return timer;
}

@end
