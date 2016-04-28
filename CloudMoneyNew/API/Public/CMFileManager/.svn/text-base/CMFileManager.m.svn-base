//
//  CMFileManager.m
//  CloudMoney
//
//  Created by harry on 14/10/27.
//  Copyright (c) 2014年 Nemo. All rights reserved.
//

#import "CMFileManager.h"

static CMFileManager * sharedInstance = nil;

@implementation CMFileManager

//获取单例
+ (CMFileManager *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
            sharedInstance = [[CMFileManager alloc] init];
    }
    return sharedInstance;
}

//获取制定沙盒下得路径
+ (NSString *)AppFilePath:(NSUInteger)path
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(path, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    return docDir;
}

// 获取Documents目录路径
+ (NSString *)DocumentPath
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    return docDir;
}

// 获取Caches目录路径
+ (NSString *)CachePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    return cachesDir;
}

// 获取tmp目录路径
+ (NSString *)tmpPath
{
    
    NSString *tmpDir = NSTemporaryDirectory();
    return tmpDir;
}

#pragma mark config
//获取配置文件路径
+ (NSString *)configFilePath
{
    return PathAppend([self CachePath], configFile);
}

@end
