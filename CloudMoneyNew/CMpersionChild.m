//
//  CMpersionChild.m
//  CloudMoneyNew
//
//  Created by nice on 2017/4/7.
//  Copyright © 2017年 dfyg. All rights reserved.
//

#import "CMpersionChild.h"

@implementation CMpersionChild
@synthesize lastName = _lastName;
- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"🔴类名与方法名：%s（在第%d行），描述：%@", __PRETTY_FUNCTION__, __LINE__, NSStringFromClass([self class]));
        NSLog(@"🔴类名与方法名：%s（在第%d行），描述：%@", __PRETTY_FUNCTION__, __LINE__, NSStringFromClass([super class]));
    }
    return self;
}

- (void)setLastName:(NSString *)lastName {
    NSLog(@"🔴类名与方法名：%s（在第%d行），描述：%@", __PRETTY_FUNCTION__, __LINE__, @"会调用这个方法,想一下为什么？");
    _lastName = @"xxx";
}

@end
