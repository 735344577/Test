//
//  NSArray+Category.m
//  admin
//
//  Created by haitao on 15/9/21.
//  Copyright © 2015年 haitao. All rights reserved.
//

#import "NSArray+Category.h"
#import <objc/runtime.h>

@implementation NSArray (Category)
+ (instancetype)getProperties:(Class)cls
{
    unsigned int count;
    objc_property_t * properties = class_copyPropertyList(cls, &count);
    NSMutableArray * mArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char  * cName = property_getName(property);
        NSString * name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [mArray addObject:name];
    }
    free(properties);
    return mArray.copy;
}

+ (instancetype)getIvar:(Class)cls{
    unsigned int count;
    Ivar * ivars = class_copyIvarList(cls, &count);
    NSMutableArray * mArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char * cName = ivar_getName(ivar);
        NSString * name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [mArray addObject:name];
    }
    free(ivars);
    return mArray.copy;
}

+ (instancetype)getMethod:(Class)cls
{
    unsigned int count;
    Method * methods = class_copyMethodList(cls, &count);
    NSMutableArray * mArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        SEL cName = method_getName(method);
        NSString * name = NSStringFromSelector(cName);
        [mArray addObject:name];
    }
    free(methods);
    return mArray.copy;
    
}

@end
