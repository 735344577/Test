//
//  CMPush.h
//  CloudMoney
//
//  Created by harry on 14/10/31.
//  Copyright (c) 2014年 Nemo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMessage.h"


#pragma mark 宏定义
#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define _IPHONE80_ 80000

#pragma mark 字段以及描述
#define pushTitle            @"云钱袋"
#define CancelToPushTitle    @"取消"
#define makeSureToPushTitle  @"确认"
#define pushTypeKey          @"type"

#define pushType_ProductDetail @"proDetail"
#define pushType_ProductJPList @"jpList"
#define pushType_ProductSBList @"sbList"
#define pushType_spread        @"spread"
#define pushType_MyAccount     @"myAccount"

#pragma mark 通知名
#define pushNotifityName @"push"
#define pushErrorNotiftyName @"pushError"

#pragma mark 功能
//是否开启友盟自定义alert视图 YES代表是 NO代表否，开启自定义alert视图
#define isUmengAlert 0
 
typedef enum _CMPushType
{
    CMPushType_NULL,
    CMPushType_ProductDetail,
    CMPushType_ProductJPList,
    CMPushType_ProductSBList,
    CMPushType_Spread,
    CMPushType_MyAccount
}CMPushType;

//typedef void (^PushFinishBlock)(NSDictionary* dic);

@interface CMPush : NSObject

//单例
+ (CMPush *)sharedInstance;

//打开push推送
+ (void)startPush:(NSDictionary *)launchOptions;

//外部设置是否打开推送
+ (BOOL)isPush;

//开启友盟推送
+ (void)startUmengPush;

//关闭友盟push推送
+ (void)closeUmengPush;

//注册设备消息
+ (void)CMApplication:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

//接收推送消息
- (void)CMApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;

//推送出错
+ (void)CMApplication:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

//获取推送类型
+ (CMPushType)pushType:(NSString *)type;


@end
