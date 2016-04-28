//
//  BaseRequest.h
//  CloudMoneyNew
//
//  Created by nice on 15/9/21.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFHTTPRequestOperation;

@interface BaseRequest : NSObject
/**
 *  单例方法
 *
 */
+ (instancetype)shareManager;


#pragma mark 以NSURLSession实现的网络请求
/**
 *  GET请求方法
 *
 *  @param url        url
 *  @param parameters 请求参数
 *  @param mask       是否显示请求遮罩
 *  @param describle  请求描述
 *  @param success    成功回调
 *  @param failed     失败回调
 */
- (void)getSessionWithUrl:(NSString *)url parameters:(id)parameters isMask:(BOOL)mask describle:(NSString *)describle success:(void (^) (id responseJSON))success failed:(void(^) (NSString * error))failed;
/**
 *  POST请求方法
 *
 *  @param url        url
 *  @param parameters 请求参数
 *  @param mask       是否显示请求遮罩
 *  @param describle  请求描述
 *  @param success    成功回调
 *  @param failed     失败回调
 */
- (void)postSessionWithUrl:(NSString *)url parameters:(id)parameters isMask:(BOOL)mask describle:(NSString *)describle success:(void (^)(id responseJSON))success failed:(void(^) (NSString * error))failed;

/**
 *  POST请求上传方法
 *
 *  @param url        url
 *  @param parameters 请求参数
 *  @param mask       是否显示请求遮罩
 *  @param success    成功回调
 *  @param failed     失败回调
 */
- (void)postFileWithUrl:(NSString *)url parameters:(id)parameters isMask:(BOOL)mask success:(void (^)(id responseJSON))success failed:(void (^) (NSError * error))failed;

@end
