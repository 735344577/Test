//
//  SDBarView.h
//  CloudMoneyNew
//
//  Created by nice on 2017/2/24.
//  Copyright © 2017年 dfyg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDBarView : UIView

@property (nonatomic, strong) UIColor *progressTintColor;//设置进度颜色
@property (nonatomic, strong) UIColor * trackTintColor;//设置整体颜色
@property (nonatomic, assign) float  progress; //0~1之间的数
@property (nonatomic, assign) float  lineWidth; //进度条的宽度 <= self.frame.size.height


@end
