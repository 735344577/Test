//
//  UIButton+Category.h
//  admin
//
//  Created by haitao on 15/9/21.
//  Copyright © 2015年 haitao. All rights reserved.
//

#import <UIKit/UIKit.h>

//注：两个手指同时点击两个button会连续跳转两个页面，
//这样显然是不合理的，解决方法仅一行代码
//[button setExclusiveTouch:YES];

@interface UIButton (Category)

/**
 *  @brief 倒计时
 *
 *  @param timeLine 倒计时时常
 *  @param subTitle subTitle description
 */
- (void)startWithTime:(NSInteger)timeLine countDownTitle:(NSString *)subTitle;

@end
