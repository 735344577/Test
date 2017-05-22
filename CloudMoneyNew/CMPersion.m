//
//  CMPersion.m
//  CloudMoneyNew
//
//  Created by nice on 2017/4/7.
//  Copyright © 2017年 dfyg. All rights reserved.
//

#import "CMPersion.h"

@implementation CMPersion

- (instancetype)init {
    self = [super init];
    if (self) {
        _lastName = @"";
    }
    return self;
}

- (void)setLastName:(NSString *)lastName {
    NSLog(@"🔴类名与方法名：%s（在第%d行），描述：%@", __PRETTY_FUNCTION__, __LINE__, @"根本不会调用这个方法");
    _lastName = @"炎黄";
}

- (void)test {
    
}

@end
