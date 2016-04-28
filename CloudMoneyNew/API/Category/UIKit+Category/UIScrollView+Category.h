//
//  UIScrollView+Category.h
//  CloudMoneyNew
//
//  Created by nice on 15/12/2.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import <UIKit/UIKit.h>

static float const SpringHeadViewHeight = 200;

@interface UIScrollView (Category)

@end

@interface UIScrollView (SpringHeadView)<UIScrollViewDelegate>

@property (nonatomic, weak) UIView * topView;

- (void)addSpringHeadView:(UIView *)view;

@end