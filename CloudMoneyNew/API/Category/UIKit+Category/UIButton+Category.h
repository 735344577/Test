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
+ (UIButton*)buttonwithType:(UIButtonType)type Frame:(CGRect)frame TitileName:(NSString *)name backgroundIamge:(NSString *)imagename;



/**
 添加图片 和  文本框  到  button
 */
+ (UIButton *)buttonWithType:(UIButtonType)type buttonFrame:(CGRect)controlframe    labelTitle:(NSString *)titlename backgroundIamge:(NSString *)imagename;


//IOS 1.2版本 改动的地方用方法
/**
 type:  button 类型
 frame: button 位置和大小
 titleName: button 标题
 tiltleColorStr: button 标题字体颜色
 buttonBgColorStr: button  背景色
 */
+ (UIButton *)buttonWithType:(UIButtonType) type buttonFrame:(CGRect)frame buttonTitle:(NSString *)titleName  titleColor:(NSString *)tiltleColorStr  buttonBgColor:(NSString *)buttonBgColorStr;


#pragma mark use Masonry 适配

+ (UIButton *)buttonWithTitle:(NSString *)titleName titleColor:(NSString *)tiltleColorStr buttonBgColor:(NSString *)buttonBgColorStr;


@end
