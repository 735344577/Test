//
//  APIManager.m
//  CloudMoneyNew
//
//  Created by nice on 16/3/23.
//  Copyright © 2016年 dfyg. All rights reserved.
//

#import "APIManager.h"
#import "BaseViewController.h"
@interface APIManager ()<ReformerProtocol>
@property (nonatomic, strong) NSDictionary * rawData;
@end

@implementation APIManager

- (NSDictionary *)fetchDataWithReformer:(id<ReformerProtocol>)reformer
{
    if (reformer == nil) {
        return self.rawData;
    } else {
        return [reformer reformDataWithManager:self];
    }
}

@end
