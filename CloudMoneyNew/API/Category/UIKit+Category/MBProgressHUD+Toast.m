//
//  MBProgressHUD+Toast.m
//  CloudMoneyNew
//
//  Created by nice on 16/8/25.
//  Copyright © 2016年 dfyg. All rights reserved.
//

#import "MBProgressHUD+Toast.h"

@implementation MBProgressHUD (Toast)

+ (MBProgressHUD *)showToastToView:(UIView *)view
                          withText:(NSString *)text {
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [hud showToastWithText:text];
    return hud;
}

+ (MBProgressHUD *)showToastMessage:(NSString *)message {
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[Status currentViewController].view animated:YES];
    [hud showToastWithText:message];
    return hud;
}

+ (MBProgressHUD *)showToastMessage:(NSString *)message
                         afterBlock:(dispatch_block_t)block {
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[Status currentViewController].view animated:YES];
    [hud showMessage:message action:block];
    return hud;
}

- (void)showMessage:(NSString *)message
             action:(dispatch_block_t)action {
    [self show:NO];
    [self setMode:MBProgressHUDModeText];
    self.userInteractionEnabled = NO;
    self.detailsLabelText = message;
    self.detailsLabelFont = [UIFont boldSystemFontOfSize:16.0];
    dispatch_time_t time3s = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC));
    dispatch_after(time3s, dispatch_get_global_queue(0, 0), ^{
        if (action) {
            dispatch_async(dispatch_get_main_queue(), ^{
                action();
            });
        }
    });
    [self hide:YES afterDelay:2.0];
}

- (void)showToastWithText:(NSString *)text {
    [self showMessage:text action:nil];
}

@end
