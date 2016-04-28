//
//  CMSystemTime.m
//  CloudMoneyNew
//
//  Created by nice on 15/9/28.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import "CMSystemTime.h"
#import "BaseRequest.h"
@interface CMSystemTime ()

@end

@implementation CMSystemTime

+ (instancetype)shareManager
{
    static CMSystemTime * time = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        time = [[self alloc] init];
    });
    return time;
}

- (void)startUpdateTime:(NSTimeInterval)time
{
    
}

- (void)startCountDown:(NSString *)time
{
    
}


@end
