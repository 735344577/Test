//
//  Status.h
//  CloudMoneyNew
//
//  Created by nice on 16/6/1.
//  Copyright © 2016年 dfyg. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  @brief 公共方法
 */
@interface Status : NSObject
/**
 *  @brief 获取RootVC
 *
 *  @return 当前显示的VC
 */
+ (UIViewController *)appRootViewController;


/**
 *  @brief 获取当前所在的VC
 *
 *  @return 当前显示的VC
 */
+ (UIViewController *)currentViewController;
/**
 *  @brief 获取EventPlist文本
 *
 *  @return Event 信息
 */
+ (NSDictionary *)dictionaryFromConfigPlist;


/**
 *  @brief 判断一个 index是否在一个Range中  index <= range.
 *
 *  @param index 需要判断的index
 *  @param range range
 *
 *  @return Bool
 */
+ (BOOL)isContainsIndex:(NSUInteger)index range:(NSRange)range;

@end
