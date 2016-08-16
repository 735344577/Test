//
//  NSDate+Category.h
//  admin
//
//  Created by haitao on 15/9/21.
//  Copyright © 2015年 haitao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Category)

- (NSString *)formatDay;

- (NSString *)formatTime;

- (NSString *)formatLogTime;

@end


@interface NSDate (compare)
/**
 *  @brief 比较当前时间是否距上个时间大于24小时  是否是一天之后
 *
 *  @param currentDate 当前时间
 *  @param lastDate    上一次时间
 *
 *  @return 是  否
 */
+ (BOOL)compareCurrentDateIsGreaterThanLastDate24H:(NSDate *)currentDate
                                          lastDate:(NSDate *)lastDate;
/**
 *  @brief 是否是min分钟之后
 *
 *  @param min         分钟
 *  @param currentDate 当前时间
 *  @param lastDate    上次时间
 *
 *  @return 是否
 */
+ (BOOL)isNumberMinLater:(NSInteger)min
             currentDate:(NSDate *)currentDate
                lastDate:(NSDate *)lastDate;
/**
 *  @brief 是否是hour小时之后
 *
 *  @param hour        小时
 *  @param currentDate 当前时间
 *  @param lastDate    上次时间
 *
 *  @return 是否
 */
+ (BOOL)isNumberHourLater:(NSInteger)hour
              currentDate:(NSDate *)currentDate
                 lastDate:(NSDate *)lastDate;

@end