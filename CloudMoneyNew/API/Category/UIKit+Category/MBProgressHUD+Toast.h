//
//  MBProgressHUD+Toast.h
//  CloudMoneyNew
//
//  Created by nice on 16/8/25.
//  Copyright © 2016年 dfyg. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Toast)

+ (MBProgressHUD *)showToastToView:(UIView *)view
                          withText:(NSString *)text;

+ (MBProgressHUD *)showToastMessage:(NSString *)message;

+ (MBProgressHUD *)showToastMessage:(NSString *)message
                         afterBlock:(dispatch_block_t)block;

@end
