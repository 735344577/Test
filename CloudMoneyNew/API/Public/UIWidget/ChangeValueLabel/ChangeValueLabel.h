//
//  ChangeValueLabel.h
//  CloudMoneyNew
//
//  Created by nice on 16/7/29.
//  Copyright © 2016年 dfyg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeValueLabel : UILabel

@property (nonatomic, copy) NSString * headerString;
//不带小数点
- (void)animationChangeValueFromValue:(double)fromValue toValue:(double)toValue;
//是否带有小数点， 保留2位小数
- (void)animationChangeValueFromValue:(double)fromValue toValue:(double)toValue decimal:(BOOL)decimal;

@end
