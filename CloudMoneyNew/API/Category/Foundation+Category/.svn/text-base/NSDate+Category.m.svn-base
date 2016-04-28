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
