//
//  UILabel+Category.h
//  admin
//
//  Created by haitao on 15/9/21.
//  Copyright © 2015年 haitao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Category)
+ (UILabel *)labelwithFrame:(CGRect)frame  TextName:(NSString *)textname  FontSize:(CGFloat)size;

/**
 frame:位置和大小
 textname:标题名称
 size:字体大小
 str:字体颜色值
 */
+ (UILabel *)labelwithFrame:(CGRect)frame TextName:(NSString *)textname FontSize:(CGFloat)size  textColor:(NSString *)str;
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