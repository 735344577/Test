//
//  UILabel+Category.h
//  admin
//
//  Created by haitao on 15/9/21.
//  Copyright © 2015年 haitao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Category)

@end


@interface UILabel (CGRect)
//此方法定宽获取高度
- (CGSize)getSizeWithFont:(UIFont *)font;
//AttributeDict 设置Font color 等
- (CGSize)getSizeWithAttributeDict:(NSDictionary *)dict;

/**
 *  此方法适用于一行的lable 获取最大宽度当宽大于lable宽时使用label原有宽 高度不变
 *
 */
- (CGFloat)sizeToFitWidth;
/**
 *  同上一种方法
 *
 */
- (CGFloat)getWidth;
/**
 *  自动适应文字宽度和高度且居于原label的高度中间 //centerY 不变
 */
- (void)sizeToFitWidthChangeHeight;

@end

@interface UILabel (textValueAnimation)
/**
 *  @brief 数值变化动画
 *
 *  @param key       动画的key   字符串
 *  @param fromValue 起始值
 *  @param toValue   结束值
 *  @param decimal   是否有小数点（小数保留2位）
 */
- (void)animationForkey:(NSString *)key fromValue:(CGFloat)fromValue toValue:(CGFloat)toValue decimal:(BOOL)decimal;

@end

@interface UILabel (Font_Color)
/**
 *  @brief 一个Label上设置多种样式的字体
 *
 *  @param txtArr   文字数组
 *  @param colorArr 文字颜色数组
 *  @param fontArr  文字字体样式数组
 */
- (void)txtArr:(NSArray *)txtArr colorArr:(NSArray *)colorArr fontArr:(NSArray *)fontArr;
@end

/**
 *  @brief 设置Label行间距
 */
@interface UILabel (LineSpace)

- (void)setLineSpace:(NSInteger)lineSpace;

@end
