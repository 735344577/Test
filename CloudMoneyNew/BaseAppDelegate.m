//
//  BaseAppDelegate.m
//  CloudMoneyNew
//
//  Created by harry on 15/9/21.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import "BaseAppDelegate.h"
#import "ThirdParty.h"
#import "PublicDefine.h"
#import "CMDeviceInfo.h"

@interface BaseAppDelegate ()

@end



@implementation BaseAppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self IQKeyboardManager];
    
    //推送
    return YES;
    
}



- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark umeng

- (void)onlineConfigCallBack:(NSNotification *)note {
    
    NSLog(@"online config has fininshed and note = %@", note.userInfo);
}

#pragma -mark 键盘处理
- (void)IQKeyboardManager
{
    //键盘自动处理
    IQKeyboardManager * manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
}

#pragma -mark app 更新检测
- (void)checkAppUpdate
{
    NSDictionary * infoDict = [[NSBundle mainBundle] infoDictionary];
}



@end
