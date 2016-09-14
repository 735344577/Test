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

/*状态*/
@property (nonatomic, copy) NSString * state;
/*字体颜色*/
@property (nonatomic, strong) UIColor * textColor;
@end
