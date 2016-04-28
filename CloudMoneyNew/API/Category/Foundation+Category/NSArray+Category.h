//
//  NSArray+Category.h
//  admin
//
//  Created by haitao on 15/9/21.
//  Copyright © 2015年 haitao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Category)

+ (instancetype)getProperties:(Class)cls;

+ (instancetype)getIvar:(Class)cls;


+ (instancetype)getMethod:(Class)cls;
@end
