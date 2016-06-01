//
//  Status.m
//  CloudMoneyNew
//
//  Created by nice on 16/6/1.
//  Copyright © 2016年 dfyg. All rights reserved.
//

#import "Status.h"

@implementation Status

+ (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


+ (UIViewController *)currentViewController {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        vc = [(UINavigationController *)vc visibleViewController];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        vc = [(UITabBarController *)vc selectedViewController];
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = [(UINavigationController *)vc visibleViewController];
        }
    }
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
    }
    return vc;
}

+ (NSDictionary *)dictionaryFromConfigPlist{
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"Event" ofType:@"plist"];
    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return dic;
}

@end
