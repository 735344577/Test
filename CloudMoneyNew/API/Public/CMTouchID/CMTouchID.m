//
//  CMTouchID.m
//  TouchID
//
//  Created by nice on 15/9/30.
//  Copyright © 2015年 NICE. All rights reserved.
//

#import "CMTouchID.h"

//#ifdef iOS8
#import <LocalAuthentication/LocalAuthentication.h>
//#endif

@interface CMTouchID ()

@property (nonatomic, strong) LAContext * context;

@property (nonatomic, copy  ) NSString * reasonString;

@end

@implementation CMTouchID

+ (instancetype)shareManager
{
    static CMTouchID * touch = nil;
    //    static dispatch_once_t onceToken;
    //    dispatch_once(&onceToken, ^{
    touch = [[self alloc] init];
    //    });
    return touch;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.context = [[LAContext alloc] init];
    }
    return self;
}

- (BOOL)canUserTouchID
{
    NSError * error = nil;
    return [_context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
}

- (void)canNotUserTouchIDReason:(void(^)(TOUCHID_TYPE type))reason{
    NSError * error = nil;
    
    if (![_context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
                //没设置TouchID
                reason(NotEnrolled);
                break;
            case LAErrorPasscodeNotSet:
                //没设置开机密码
                reason(PasscodeNotSet);
                break;
            default:
                //设备或系统版本不支持使用touchid
                reason(NOT_SUPPORT);
                break;
        }
    }
    
}


- (void)authenticateUserFinsish:(void(^)(TOUCHID_TYPE type))finish{
    NSError * error = nil;
    if ([_context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [_context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                 localizedReason:@"通过Home键验证已有手机指纹"
                           reply:^(BOOL success, NSError * _Nullable error) {
                               if (success) {
                                   finish(SUCCESSED);
                               }
                               else
                               {
                                   switch (error.code) {
                                       case LAErrorSystemCancel:
                                           //切换到其他APP，系统取消验证Touch ID
                                           finish(SYSTEM_CANCEL);
                                           break;
                                           
                                       case LAErrorUserCancel:
                                           //用户取消验证Touch ID
                                           finish(USER_CANCEL);
                                           break;
                                           
                                       case LAErrorUserFallback:
                                           //用户选择输入密码，切换主线程处理
                                           finish(USER_FALLBACK);
                                           break;
                                       case LAErrorAuthenticationFailed:
                                           finish(AUTH_FAILED);
                                           break;
                                           
                                       default:
                                           
                                           //其它情况
                                           break;
                                   }
                               }
                           }];
    }else{
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
                
                //没设置TouchID
                finish(NotEnrolled);
                break;
            case LAErrorPasscodeNotSet:
                
                finish(PasscodeNotSet);
                break;
                
            default:
                finish(NOT_SUPPORT);
                break;
        }
        //设备不支持TouchID
        //        finish(NOT_SUPPORT);
    }
}

@end
