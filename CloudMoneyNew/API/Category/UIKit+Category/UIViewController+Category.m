//
//  UIViewController+Category.m
//  CloudMoneyNew
//
//  Created by nice on 16/3/29.
//  Copyright © 2016年 dfyg. All rights reserved.
//

#import "UIViewController+Category.h"

@implementation UIViewController (Category)

+ (instancetype)getViewControllerWithNib{
    return [[self alloc] initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
}

@end
