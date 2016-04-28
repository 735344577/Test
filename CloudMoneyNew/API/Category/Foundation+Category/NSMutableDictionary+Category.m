//
//  NSMutableDictionary+Category.m
//  CloudMoneyNew
//
//  Created by nice on 15/9/22.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import "NSMutableDictionary+Category.h"

@implementation NSMutableDictionary (Category)
-(void)setSecurityObj:(id)obj forKey:(id)key
{
    if (obj == nil || key ==nil)
    {
        //        NSLog(@"值或键是空的");
        return;
    }
    [self setObject:obj forKey:key];
}

- (void)objectSecuritKey:(id)key
{
    if (key == nil)
    {
        //        NSLog(@"键是空的");
        return;
    }
    [self objectForKey:key];
}

@end
