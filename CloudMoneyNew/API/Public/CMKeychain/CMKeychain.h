//
//  CMKeychain.h
//  CloudMoney
//
//  Created by harry on 15/3/18.
//  Copyright (c) 2015年 Nemo. All rights reserved.
//

#import <Foundation/Foundation.h>

//存储类
@interface CMKeychain : NSObject

//保存方法
+ (void)save:(NSString *)service data:(id)data;
//查询方法
+ (id)load:(NSString *)service;
//删除方法
+ (void)deleteSelf:(NSString *)service;

@end
