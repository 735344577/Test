//
//  BaseRequestDefine.h
//  CloudMoneyNew
//
//  Created by nice on 15/9/21.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#ifndef BaseRequestDefine_h
#define BaseRequestDefine_h
typedef enum _CMRequestState
{
    CMRequestState_NULL,
    CMRequestState_Unkown, // 不知道
    CMRequestState_success,  // 成功 0
    CMRequestState_fail, //失败 1 ---> 服务器失败
    CMRequestState_CertifyFail // -1 认证失败 ---->用户行为
}CMRequestState;

#define resetLoginMessage   @"您的密码错误，请重新登录。"

//请求状态字段名
#define CMStateName     @"state"
//新接口状态值
#define CMStateCode     @"statusCode"
//服务器返回错误信息
#define CMErrorInfo     @"errorInfo"
//请求数据的字段名
#define CMResponseData  @"data"
//versionCode
#define CMVersionCode   @"versionCode"

#endif /* BaseRequestDefine_h */
