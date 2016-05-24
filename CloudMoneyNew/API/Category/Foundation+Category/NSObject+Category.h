//
//  NSObject+Category.h
//  CloudMoneyNew
//
//  Created by nice on 15/11/11.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Category)

+ (instancetype)loopObject:(NSDictionary *)dic;

+ (instancetype)setValuesForKeysWithDictionary:(NSDictionary *)dict;

- (NSDictionary *)properties_aps;

- (NSDictionary *)dictionaryWithValuesForKeys;

//根据字典生成对应的属性
+ (void)createPropertyWithDict:(NSDictionary *)dict;

- (NSUInteger)obj_retainCount;
/**
 *  @brief 获取RootVC
 *
 *  @return 当前显示的VC
 */
- (UIViewController *)appRootViewController;
/**
 *  @brief 获取当前所在的VC
 *
 *  @return 当前显示的VC
 */
- (UIViewController *)currentViewController;
@end
