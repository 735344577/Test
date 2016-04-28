//
//  AppDelegate+Category.h
//  CloudMoneyNew
//
//  Created by nice on 15/11/26.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Category)
//通过runtime动态添加属性
@property (nonatomic, strong) UITabBarController *tabbarController;

/*!
 @brief 全局appDeleaget
 */
+ (AppDelegate *)appDelegate;
/*!
 @method
 @brief 关闭系统键盘
 */
+ (void)closeKeyWindow;
@end
