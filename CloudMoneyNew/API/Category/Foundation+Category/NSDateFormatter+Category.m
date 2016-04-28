//
//  NSDateFormatter+Category.m
//  CloudMoneyNew
//
//  Created by nice on 15/9/29.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import "NSDateFormatter+Category.h"

@implementation NSDateFormatter (Category)

+ (instancetype)shareFormatter
{
    static NSDateFormatter * formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[self alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
    });
    return formatter;
}

@end
