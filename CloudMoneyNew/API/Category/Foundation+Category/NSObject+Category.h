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

@end
