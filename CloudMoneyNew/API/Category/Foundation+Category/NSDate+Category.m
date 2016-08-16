//
//  NSDate+Category.m
//  admin
//
//  Created by haitao on 15/9/21.
//  Copyright © 2015年 haitao. All rights reserved.
//

#import "NSDate+Category.h"

@implementation NSDate (Category)
- (NSString *)formatDay
{
    return [self formatWith:@"yyyyMMdd"];
}

- (NSString *)formatTime
{
    return [self formatWith:@"yyyyMMddHHmmss"];
}

- (NSString *)formatLogTime
{
    return [self formatWith:@"yyyy MMdd HH:mm:ss"];
}

- (NSString *)formatWith:(NSString *)dateFormat
{
    static NSDateFormatter* formatter = nil;
    if (nil == formatter) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        formatter.dateFormat = @"yyyyMMddHHmmss";
    }
    if (dateFormat && dateFormat.length > 0) {
        formatter.dateFormat = dateFormat;
    }
    
    return [formatter stringFromDate:self];
}

@end


@implementation NSDate (compare)

+ (BOOL)compareCurrentDateIsGreaterThanLastDate24H:(NSDate *)currentDate
                                          lastDate:(NSDate *)lastDate {
    double secondsInMinute = 60 * 60 * 24; //一天
    NSTimeInterval lastTime = [lastDate timeIntervalSince1970];
    NSTimeInterval nowime = [currentDate timeIntervalSince1970];
    NSTimeInterval value = nowime - lastTime;
    NSInteger secondsBetweenDates = value / secondsInMinute;
    if (secondsBetweenDates >= 1)
        return YES;
    else
        return NO;
}

+ (BOOL)isNumberMinLater:(NSInteger)min
             currentDate:(NSDate *)currentDate
                lastDate:(NSDate *)lastDate{
    double secondsInMinute = 60 * min; //min 分钟
    NSTimeInterval lastTime = [lastDate timeIntervalSince1970];
    NSTimeInterval nowime = [currentDate timeIntervalSince1970];
    NSTimeInterval value = nowime - lastTime;
    NSInteger secondsBetweenDates = value / secondsInMinute;
    if (secondsBetweenDates >= 1)
        return YES;
    else
        return NO;
}

+ (BOOL)isNumberHourLater:(NSInteger)hour
              currentDate:(NSDate *)currentDate
                 lastDate:(NSDate *)lastDate{
    double secondsInMinute = 60 * 60 * hour; //h 小时
    NSTimeInterval lastTime = [lastDate timeIntervalSince1970];
    NSTimeInterval nowime = [currentDate timeIntervalSince1970];
    NSTimeInterval value = nowime - lastTime;
    NSInteger secondsBetweenDates = value / secondsInMinute;
    if (secondsBetweenDates >= 1)
        return YES;
    else
        return NO;
}

@end