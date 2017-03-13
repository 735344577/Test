//
//  SDCiraleLoadingView.h
//  CloudMoneyNew
//
//  Created by nice on 2017/3/9.
//  Copyright © 2017年 dfyg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDCiraleLoadingView : UIView

/**线宽*/
@property (nonatomic, assign) float lineWidth;
/**底部圆环颜色*/
@property (nonatomic, strong) UIColor *bottomColor;
/**loading颜色*/
@property (nonatomic, strong) UIColor *loadingColor;
/**提示文字*/
@property (nonatomic, copy) NSString *text;


+ (instancetype)ciraleView:(NSString *)text;

- (void)startAnimation;

@end
