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

@interface UILabel (changeValue)
/**
 *  @brief 数字变化(整数级变化)
 *
 *  @param start 初始值
 *  @param end   结束值
 */
- (void)textChangeFromNum:(NSInteger)start endNum:(NSInteger)end;
/**
 *  @brief 小数级变化--------（保留2位小数）
 *
 *  @param start 开始值
 *  @param end   结束值
 */
- (void)textChangeStartNum:(CGFloat)start endNum:(CGFloat)end;

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
