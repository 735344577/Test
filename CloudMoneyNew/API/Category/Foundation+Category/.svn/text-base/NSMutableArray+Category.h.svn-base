//
//  NSMutableArray+Category.h
//  CloudMoneyNew
//
//  Created by nice on 15/9/22.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Category)

- (void)addNormalObject:(id)anObject;

- (id)objectAtIndex:(NSUInteger)objectIndex kindOfClass:(Class)aClass;

@end


@interface NSDictionary(ValuePath)
- (NSInteger)intValue:(NSString *)path;
- (long)longValue:(NSString *)path;
- (float)floatValue:(NSString *)path;
- (NSString *)strValue:(NSString *)path;

- (NSInteger)intValue:(NSString *)path default:(NSInteger)defValue;
- (float)floatValue:(NSString *)path default:(float)defValue;
- (NSString *)strValue:(NSString *)path default:(NSString *)defValue;
- (NSArray *) arrayValue :(NSString *) path;
@end