//
//  NSString+Category.h
//  admin
//
//  Created by haitao on 15/9/21.
//  Copyright © 2015年 haitao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)
/**
 *  //处理四舍五入的问题
 *
 *  @param price    需要处理的数字
 *  @param position 保留小数点第几位
 *
 *  @return 输出结果
 */
+ (NSString *)notRounding:(float)price afterPoint:(int)position;

//字符串中是否包含莫个字段
- (BOOL)isContainsString:(NSString *)str;
//注：只适配iOS8以上使用 系统的 containsString: 方法

/**
 *  @brief 用str替换字符串中的某一部分
 *
 *  @param changeStr 需要替换的字符串
 *  @param str       替换的字符串
 *  @param range     需要被替换的部分
 *
 *  @return 返回替换后的字符串
 */
- (NSString *)changeStringWithStr:(NSString *)change
                  range:(NSRange)range;
/**
 *  @brief 用*替换字符串中的某一部分
 *
 *  @param changeStr 需要替换的字符串
 *  @param range     需要被替换的部分
 *
 *  @return 返回替换后的字符串
 */
- (NSString *)changeAsteriskStringWithRange:(NSRange)range;
@end
