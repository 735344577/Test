//
//  CMUpdate.m
//  CloudMoneyNew
//
//  Created by nice on 15/9/23.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import "CMUpdate.h"
#import "BaseRequest.h"

@interface CMUpdate ()

@end

@implementation CMUpdate
+ (instancetype)shareManager
{
    static CMUpdate * update = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        update = [[self alloc] init];
    });
    return update;
}

- (void)checkVersionUpdate
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:@"checkVersion" forKey:@"action"];
    
    NSString * url = @"";
    [[BaseRequest shareManager] getSessionWithUrl:url parameters:nil isMask:YES describle:@"应用更新检测" success:^(id responseJSON) {
        NSString * dataStr = [responseJSON objectForKey:@"data"];
        NSArray * array = [dataStr componentsSeparatedByString:@"|"];
        if (array != nil && array.count > 1) {
            NSString *beforeConfigV = [[NSUserDefaults standardUserDefaults]objectForKey:@"configVersion"];
            NSString *ConfigV = [array objectAtIndex:1];
            
            if ([beforeConfigV isEqualToString:ConfigV])
            {
                [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"configVersionBool"];
            }
            else
            {
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"configVersionBool"];
                [[NSUserDefaults standardUserDefaults]setObject:ConfigV forKey:@"configVersion"];
            }
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        
    } failed:^(NSString *error) {
        
    }];
}
@end
