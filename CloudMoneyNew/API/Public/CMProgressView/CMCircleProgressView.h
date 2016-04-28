//
//  CMCircleProgressView.h
//  CloudMoneyNew
//
//  Created by nice on 15/10/8.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  圆形进度条
 */
@interface CMCircleProgressView : UIView

@property(nonatomic, strong) UIColor* progressTintColor;

@property(nonatomic, strong) UIColor* trackTintColor;

@property (nonatomic, assign) float  progress; //0~1之间的数

@property (nonatomic, assign) float  lineWidth;

@end
