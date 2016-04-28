//
//  CMFileManager.h
//  CloudMoney
//
//  Created by harry on 14/10/27.
//  Copyright (c) 2014年 Nemo. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 文件基础管理类
 */
#define PathAppend(strA,strB) [strA stringByAppendingPathComponent:strB]
#define configFile @"config.plist"

@interface CMFileManager : NSObject

#pragma mark 获取沙盒路径

/**
 获取单例
 */
+ (CMFileManager *)sharedInstance;

/**
 获取制定沙盒下得路径
 */
+ (NSString *)AppFilePath:(NSUInteger)path;

/**
 document沙盒路径
 */
+ (NSString *)DocumentPath;

/**
 获取Caches目录路径
 */
+ (NSString *)CachePath;

/**
 获取tmp目录路径
 */
+ (NSString *)tmpPath;

/**
 获取配置文件路径
 */
+ (NSString *)configFilePath;
@end
