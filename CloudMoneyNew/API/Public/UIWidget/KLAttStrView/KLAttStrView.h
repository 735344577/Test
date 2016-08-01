//
//  KLAttStrView.h
//  CloudMoneyNew
//
//  Created by nice on 16/7/29.
//  Copyright © 2016年 dfyg. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  @brief 自定义富文本，可点击
 */
@interface KLAttStrView : UIView

/**
 * @brief 富文本字符串
 */
@property (nonatomic, copy) NSAttributedString * attributedString;

/**
 * @brief 富文本可点击区域调用事件    
          在外部用[Status isContainsIndex:index range:range]判断是否在range的点击区域内
 */
@property (nonatomic, copy) void (^ clickAction)(NSUInteger index);//index为点击的第几个字

- (instancetype)initWithAttributedString:(NSAttributedString *)attrStr;


@end
