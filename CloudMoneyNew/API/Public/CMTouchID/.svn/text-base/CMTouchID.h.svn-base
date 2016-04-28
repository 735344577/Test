//
//  CMTouchID.h
//  TouchID
//
//  Created by nice on 15/9/30.
//  Copyright © 2015年 NICE. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    /**验证成功*/
    SUCCESSED,
    /**切换到其他APP，系统取消验证Touch ID*/
    SYSTEM_CANCEL,
    /**用户取消验证Touch ID*/
    USER_CANCEL,
    /**用户选择输入密码*/
    USER_FALLBACK,
    /**机型不支持TouchID验证*/
    NOT_SUPPORT,
    /**认证失败*/
    AUTH_FAILED,
    /**没设置TouchID*/
    NotEnrolled,
    /**开机密码未设置*/
    PasscodeNotSet,
} TOUCHID_TYPE;



@interface CMTouchID : NSObject

//伪单例 （注：单例会导致 程序在后台时touchid 不会重新验证）
+ (instancetype)shareManager;

//是否可以使用TouchID
- (BOOL)canUserTouchID;

//为什么不能使用TouchId 有3种情况 不支持、未设置开机密码、未设置touchID
- (void)canNotUserTouchIDReason:(void(^)(TOUCHID_TYPE type))reason;

//使用TouchId验证
- (void)authenticateUserFinsish:(void(^)(TOUCHID_TYPE type))finish;

@end
