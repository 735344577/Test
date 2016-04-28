//
//  UINavigationBar+Category.m
//  admin
//
//  Created by haitao on 15/9/21.
//  Copyright © 2015年 haitao. All rights reserved.
//

#import "UINavigationBar+Category.h"
#import "UIKit+Category.h"
@implementation UINavigationBar (Category)
- (void)setBackgroundImage:(NSString *)image
{
    [self setBackgroundImage:[UIImage imageNamed:image] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
}

- (void)setNavigationTitleColor:(UIColor *)color font:(UIFont *)font
{
    NSDictionary * attributes = @{NSForegroundColorAttributeName:color, NSFontAttributeName:font};
    [self setTitleTextAttributes:attributes];
}
@end
