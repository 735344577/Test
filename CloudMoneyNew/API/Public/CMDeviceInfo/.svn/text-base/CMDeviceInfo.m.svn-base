//
//  CMDeviceInfo.m
//  CloudMoneyNew
//
//  Created by nice on 15/9/25.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import "CMDeviceInfo.h"
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "Reachability.h"
#import "CMKeychain.h"

NSString * const KEY_DEVICEID = @"cloudy.deviceID";
NSString * const KEY_DEVICEID_DATA = @"cloudy.deviceID.data";

@interface CMDeviceInfo ()

@end

@implementation CMDeviceInfo

//返回平台端名称
+ (NSString *)PlatForm
{
    return @"ios";
}

//返回设备名称
+ (NSString *)deviceName
{
    return [SDiPhoneVersion deviceName];
}

//设备类型取值
+ (DeviceVersion)deviceType
{
    return [SDiPhoneVersion deviceVersion];
}

//设备版本
+ (NSString *)deviceVersion
{
    return [UIDevice currentDevice].systemVersion;
}

//设备尺寸
+ (DeviceSize)deviceSizes
{
    return [SDiPhoneVersion deviceSize];
}

//当前设备的模型
+ (NSString *)deviceModel
{
    return [UIDevice currentDevice].model;
}

//app名称
+ (NSString *)appName
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

//返回app版本
+ (NSString *)appVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

//bunild版本号
+ (NSString *)appBuildVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

//获取设备名称加版本号
+ (NSString *)appInfo
{
    return [NSString stringWithFormat:@"%@ %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"], [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
}

//当前设备的系统名
+ (NSString *)systemName;
{
    return [UIDevice currentDevice].systemName;
}

//渠道
+(NSString *)appChannel
{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"config"];
    NSString *channel = [dic objectForKey:@"channel"];
    
    if (channel == nil || [channel isEqualToString:@""])
    {
        channel = @"AppStore";
    }
    
    return channel;
}



//是否越狱了
+ (BOOL)isJailbroken
{
    BOOL jailbroken = NO;
    NSString * cydiaPath = @"/Applications/Cydia.app";
    NSString * aptPath = @"/private/var/lib/apt/";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath] || [[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        return YES;
    }
    return jailbroken;
}

//是否是wifi
+ (BOOL)IsEnableWifi
{
    return [[Reachability reachabilityForLocalWiFi] isReachableViaWiFi];
}

// 是否3G
+ (BOOL) IsEnable3G
{
    return [[Reachability reachabilityForInternetConnection] isReachableViaWWAN];
}

//是否有网络连接
+ (BOOL)isNetWorkConnect
{
    if ([self IsEnable3G] || [self IsEnableWifi]) {
        return YES;
    }else{
        return NO;
    }
}

//网络类型
+ (NSString *)networkType
{
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    if ([self isNetWorkConnect]) {
        if ([self IsEnableWifi]) {
            return @"WIFI";
        }
        else
        {
            if ([networkInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE])
            {
                return @"4G";
            }
            else if ([networkInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge] || [networkInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS])
            {
                return @"2G";
            }
            else
            {
                return @"3G";
            }
        }

    }else{
        return @"";
    }
}

//网络运营商名称
+ (NSString *)phoneBusiness
{
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    
    //飞行模式，无SIM卡，蜂窝数据范围外均为空
    if (networkInfo.subscriberCellularProvider.isoCountryCode == nil || [networkInfo.subscriberCellularProvider.isoCountryCode isEqualToString:@""])
    {
        return @"";
    }
    
    __block NSString *result = networkInfo.subscriberCellularProvider.carrierName;
    
    // 如果运营商变化将更新运营商输出
    networkInfo.subscriberCellularProviderDidUpdateNotifier = ^(CTCarrier *carrier) {
        result = [carrier description];
    };
    
    
    
    if (result == nil || [result isEqualToString:@""])
    {
        result = @"";
    }
    
    //    NSLog(@"result=%@",result);
    
    return result;
}


//返回deviceToken
+ (NSString *)deviceToken
{
    NSString * deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceID"];
    if (deviceToken.length == 0) {
        return @"deviceToken";
    }
    return deviceToken;
}

//单一供应商标识 设备的UUID
+ (NSString *)identifierForVendor
{
    NSMutableDictionary * device_Dic = (NSMutableDictionary *)[CMKeychain load:KEY_DEVICEID_DATA];
    NSString * deviceID = [device_Dic objectForKey:KEY_DEVICEID];
    if (deviceID.length == 0) {
        NSUUID * uuid = [[UIDevice currentDevice] identifierForVendor];
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setObject:uuid.UUIDString forKey:KEY_DEVICEID];
        [CMKeychain save:KEY_DEVICEID_DATA data:dic];
        return uuid.UUIDString;
    }else{
        return deviceID;
    }
}

//广告标识符
+ (NSString *)identifierForAdverting
{
    return [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
}

//是否是模拟器
+ (BOOL)isSimulator
{
    if ([[self deviceName] isEqualToString:@"Simulator"])
    {
        DLog(@"模拟器");
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
