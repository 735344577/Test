//
//  NSMutableArray+Category.m
//  CloudMoneyNew
//
//  Created by nice on 15/9/22.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import "NSMutableArray+Category.h"

@implementation NSMutableArray (Category)
- (void)addNormalObject:(id)anObject
{
    if (anObject == nil) {
        //        NSLog(@"插入数组值为空");
        return;
    }
    [self addObject:anObject];
}

- (id)objectAtIndex:(NSUInteger)objectIndex kindOfClass:(Class)aClass
{
    if (self == nil || self.count <1) {
        return nil;
    }
    if (objectIndex >= self.count) {
        return nil;
    }
    if ([self objectAtIndex:objectIndex] == nil || ![[self objectAtIndex:objectIndex]isKindOfClass:aClass]) {
        return nil;
    }
    return [self objectAtIndex:objectIndex];
}

@end

@implementation NSDictionary(ValuePath)

- (NSInteger)intValue:(NSString*)path {
    return [self intValue:path default:0];
}

- (long)longValue:(NSString*)path
{
    return [self longValue:path default:0];
}

- (float)floatValue:(NSString*)path
{
    return [self floatValue:path default:0.0];
}

- (NSString*)strValue:(NSString*)path {
    return [self strValue:path default:nil];
}

- (NSInteger)intValue:(NSString*)path default:(NSInteger)defValue {
    NSObject* obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSNumber class]])
        return [(NSNumber*)obj intValue];
    else if ([obj isKindOfClass:[NSString class]])
        return [(NSString*)obj intValue];
    else
        return defValue;
}

- (long)longValue:(NSString*)path default:(long)defValue
{
    NSObject* obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSNumber class]])
        return [(NSNumber*)obj longValue];
    else if ([obj isKindOfClass:[NSString class]])
        return (long)[(NSString*)obj longLongValue];
    else
        return defValue;
}

- (float)floatValue:(NSString*)path default:(float)defValue
{
    NSObject* obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSNumber class]])
        return [(NSNumber*)obj floatValue];
    else if ([obj isKindOfClass:[NSString class]])
        return [(NSString*)obj floatValue];
    else
        return defValue;
}

- (NSString*)strValue:(NSString*)path default:(NSString*)defValue {
    NSObject* obj = [self valueForKeyPath:path];
    if ([obj isKindOfClass:[NSNumber class]])
        return [(NSNumber*)obj stringValue];
    else if ([obj isKindOfClass:[NSString class]])
        return (NSString*)obj;
    else
        return defValue;
}

-(NSArray *) arrayValue :(NSString *) path
{
    NSObject* obj = [self valueForKeyPath:path];
    if(obj && [obj isKindOfClass:[NSArray class]])
    {
        return (NSArray *)obj;
    }
    return nil;
}

@end
