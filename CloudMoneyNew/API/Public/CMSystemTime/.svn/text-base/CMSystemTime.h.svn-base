//
//  CMSystemTime.h
//  CloudMoneyNew
//
//  Created by nice on 15/9/28.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import <Foundation/Foundation.h>

#define limitTime   24

@interface CMSystemTime : NSObject
{
    
}

@property (nonatomic, assign) NSTimeInterval timeDistance;

@property (nonatomic, copy) NSString * timeText;
//获取单例
+ (instancetype)shareManager;   /**获取单例*/
//开始更新系统时间
- (void)startUpdateTime:(NSTimeInterval)time;   /**开始更新系统时间*/
//开始倒计时
- (void)startCountDown:(NSString *)time;  /**开始倒计时*/



@end
