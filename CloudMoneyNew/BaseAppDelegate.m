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
#import "CMPush.h"
#import "CMDeviceInfo.h"


#define umengAppKey   @"546170a1fd98c5fa1500461f"
#define app_download_url @"https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=950919128&mt=8"

@interface BaseAppDelegate ()

@end



@implementation BaseAppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self IQKeyboardManager];
    
    //推送
    [CMPush startPush:launchOptions];
    [self umengTrack];
    [UMSocialData setAppKey:umengAppKey];
    
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
- (void)umengTrack {
    [MobClick setCrashReportEnabled:YES]; // 如果不需要捕捉异常，注释掉此行
    //    [MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    
    [MobClick startWithAppkey:umengAppKey reportPolicy:(ReportPolicy) REALTIME channelId:[CMDeviceInfo appChannel]];
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    
    
    [MobClick updateOnlineConfig];  //在线参数配置
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
    
//    Class cls = NSClassFromString(@"UMANUtil");
//    SEL deviceIDSelector = @selector(openUDIDString);
//    NSString *deviceID = nil;
//    if(cls && [cls respondsToSelector:deviceIDSelector]){
//        deviceID = [cls performSelector:deviceIDSelector];
//    }
//    NSLog(@"{\"oid\": \"%@\"}", deviceID);
    
}

- (void)onlineConfigCallBack:(NSNotification *)note {
    
    NSLog(@"online config has fininshed and note = %@", note.userInfo);
}


#pragma mark  友盟推送
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [CMPush CMApplication:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [[CMPush sharedInstance] CMApplication:application didReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [CMPush CMApplication:application didFailToRegisterForRemoteNotificationsWithError:error];
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
