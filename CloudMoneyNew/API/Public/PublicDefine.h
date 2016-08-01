//
//  PublicDefine.h
//  CloudMoneyNew
//
//  Created by nice on 15/9/22.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#ifndef PublicDefine_h
#define PublicDefine_h

//云钱袋电话
#define Service_PhoneNum               @"400-815-2688"

#define weakity(obj) autoreleasepool{} __weak __typeof(obj) obj##Weak = obj
#define strongity(obj) autoreleasepool{} __strong __typeof(obj) obj = obj##Weak

//获取全屏大小
#define ScreenWidth                        [[UIScreen mainScreen]bounds].size.width
#define ScreenHeight                       [[UIScreen mainScreen]bounds].size.height
/**
 按等比例计算高度时可以使用
 */
#define SCREEN_HEIGHT  ScreenHeight < 568 ? 568 : ScreenHeight

//获取当前view的 x，y，width，height
#define VIEW_X(a)                           a.frame.origin.x
#define VIEW_Y(a)                           a.frame.origin.y
#define VIEW_WIDTH(a)                       a.frame.size.width
#define VIEW_HEIGHT(a)                      a.frame.size.height

//像素转换为尺寸
#define PixelToPlus(a)                      a/3/1.5
#define PixelToNormal(a)                    a/2

//状态栏高度
#define StatusBarHeight                     20
//导航栏高度
#define NavigationBarHeight                 44
//指引栏高度
#define TabBarHeight                        49

#pragma mark pwd

// 密码类型
typedef enum _CMPassWordType
{
    CMPassWordType_NULL = 0,
    CMPassWordType_SetDealPwd,      //设置交易密码
    CMPassWordType_ModifyDealPwd,   //修改交易密码
    CMPassWordType_ResetDealPwd,    //忘记交易密码
    CMPassWordType_MobifyPwd,       //修改登陆密码
    CMPassWordType_ResetPwd         //忘记密码/重置登陆密码
}CMPassWordType;


// 快速注册 修改密码和用户名
typedef enum _CMModifyType
{
    CMModifyType_NULL = 0,
    CMModifyType_setUserNameAndPwd,
    CMModifyType_SetPwdPwd,      //设置登陆密码
    CMModifyType_SetUserName   //修改用户民
    //修改用户名和登陆密码
}CMModifyType;

#endif /* PublicDefine_h */



