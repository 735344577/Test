//
//  CMPush.m
//  CloudMoney
//
//  Created by harry on 14/10/31.
//  Copyright (c) 2014年 Nemo. All rights reserved.
//

#import "CMPush.h"
#define umengAppKey   @"546170a1fd98c5fa1500461f"
static CMPush * sharedInstance = nil;

@interface CMPush ()
{
    NSDictionary *pushUserInfo;
}
@property (nonatomic, strong)NSDictionary *pushUserInfo;

@end

@implementation CMPush
@synthesize pushUserInfo;


+ (CMPush *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            sharedInstance = [[CMPush alloc] init];
        }
    }
    return sharedInstance;
}

+ (BOOL)isPush
{
//    1 << 0  1*2的0次幂  = 1          运算
    
//    UIRemoteNotificationTypeNone    不接收推送消息   0
//    UIRemoteNotificationTypeBadge   接收图标数字     1
//    UIRemoteNotificationTypeSound   接收音频        2
//    UIRemoteNotificationTypeAlert   接收消息文字     4
//    UIRemoteNotificationTypeNewsstandContentAvailability 接收订阅消息     8
    
    BOOL isPush = YES;
    if (SystemVersion(8))
    {
//ios8系统添加了是否允许推送的按钮，所以可以判断
        isPush = [[UIApplication sharedApplication]isRegisteredForRemoteNotifications];
    }
    else
    {
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
     
//ios7系统下必须全部关闭才算关闭整个推送，只要可以接受到任何东西都算接受推送,当type=0的时候，代表关闭推送了
        
//        NSLog(@"type==%lu",type);
        
        if (type == 0)
        {
            isPush = NO;
        }
        else
        {
            isPush = YES;
        }
    }
    
//    NSLog(@"isPush==%d",isPush);
    return isPush;
}

+ (void)AppPushTo:(NSDictionary *)launchOptions
{
    if (launchOptions != NULL && [launchOptions count]>0) {
        NSDictionary* userInfo = [launchOptions valueForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
        if (userInfo)
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:pushNotifityName object:nil userInfo:userInfo];
        }
    }
}

+ (void)startPush:(NSDictionary *)launchOptions
{
    [UMessage startWithAppkey:umengAppKey launchOptions:launchOptions];
    [self startUmengPush];
    [self AppPushTo:launchOptions];
}


+ (void)startUmengPush
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    if(UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        //register remoteNotification types
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
    } else{
        //register remoteNotification types
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert];
    }
#else
    
    //register remoteNotification types
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
    [UMessage setLogEnabled:NO];
}
+ (void)closeUmengPush
{
    [UMessage unregisterForRemoteNotifications];
}

+ (void)CMApplication:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    DLog(@"deviceToken==%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]stringByReplacingOccurrencesOfString: @">" withString: @""]
        stringByReplacingOccurrencesOfString: @" " withString: @""]);
    
    NSString *deviceID = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]stringByReplacingOccurrencesOfString: @">" withString: @""]
                             stringByReplacingOccurrencesOfString: @" " withString: @""];
    [[NSUserDefaults standardUserDefaults]setObject:deviceID forKey:@"deviceID"];
    [UMessage registerDeviceToken:deviceToken];

}

+ (void)CMApplication:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter]postNotificationName:pushErrorNotiftyName object:nil userInfo:error.userInfo];
}

- (void)CMApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if (isUmengAlert == NO)
    {
        //关闭友盟自带的弹出框
        [UMessage setAutoAlert:NO];
    }
    else
    {
        [UMessage setAutoAlert:YES];
    }
    
    [UMessage didReceiveRemoteNotification:userInfo];
   
    if (isUmengAlert == 0) {
        self.pushUserInfo = userInfo;
        
        //定制自定的的弹出框
        if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
        {
            UIAlertView *alertView = nil;
            if ([self pushType] == CMPushType_NULL)
            {
                
                alertView = [[UIAlertView alloc] initWithTitle:pushTitle
                                                       message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]
                                                      delegate:self
                                             cancelButtonTitle:nil
                                             otherButtonTitles:makeSureToPushTitle,nil];
            }
            else
            {
                alertView = [[UIAlertView alloc] initWithTitle:pushTitle
                                                       message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]
                                                      delegate:self
                                             cancelButtonTitle:nil
                                             otherButtonTitles:CancelToPushTitle,makeSureToPushTitle,nil];
                
            }
            
            [alertView show];
        }
        else
        {
            [UMessage sendClickReportForRemoteNotification:self.pushUserInfo];
            [[NSNotificationCenter defaultCenter]postNotificationName:pushNotifityName object:nil userInfo:self.pushUserInfo];
            
        }
 
    }

}

- (CMPushType)pushType
{
    NSString *type=[self.pushUserInfo objectForKey:pushTypeKey];
    if (type == nil || [type isEqualToString:@""]) {
        return CMPushType_NULL;
    }else if ([type isEqualToString:pushType_ProductJPList])
    {
        return CMPushType_ProductJPList;
    }
    else if ([type isEqualToString:pushType_ProductSBList])
    {
        return CMPushType_ProductSBList;
    }
    else if ([type isEqualToString:pushType_ProductDetail])
    {
        return CMPushType_ProductDetail;
        
    }
    else if([type isEqualToString:pushType_spread])
    {
        return CMPushType_Spread;
    }
    else if ([type isEqualToString:pushType_MyAccount])
    {
        return CMPushType_MyAccount;
    }
    return CMPushType_NULL;
}

+ (CMPushType)pushType:(NSString *)type
{
    if (type == nil || [type isEqualToString:@""]) {
        return CMPushType_NULL;
    }else if ([type isEqualToString:pushType_ProductJPList])
    {
        return CMPushType_ProductJPList;
    }
    else if ([type isEqualToString:pushType_ProductSBList])
    {
        return CMPushType_ProductSBList;
    }
    else if ([type isEqualToString:pushType_ProductDetail])
    {
        return CMPushType_ProductDetail;
    }
    else if([type isEqualToString:pushType_spread])
    {
        return CMPushType_Spread;
    }
    else if ([type isEqualToString:pushType_MyAccount])
    {
        return CMPushType_MyAccount;
    }
    return CMPushType_NULL;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [UMessage sendClickReportForRemoteNotification:self.pushUserInfo];
        [[NSNotificationCenter defaultCenter]postNotificationName:pushNotifityName object:nil userInfo:self.pushUserInfo];
    }
}


@end
