//
//  BaseRequest.m
//  CloudMoneyNew
//
//  Created by nice on 15/9/21.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import "BaseRequest.h"
#import "AFNetworking.h"
#import "BaseRequestDefine.h"
#import "ThirdParty.h"
#pragma mark 超时时间
#define TIMEOUT     30
#pragma mark block外部使用防止block内部照成循环引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
@interface BaseRequest ()

//@property (nonatomic, strong) AFHTTPRequestOperationManager * manager;
@property (nonatomic, strong) AFHTTPSessionManager * manager;
@property (nonatomic, strong) NSMutableDictionary * requestDic;
@end

@implementation BaseRequest
+ (instancetype)shareManager
{
    static BaseRequest * request = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[self alloc] init];
    });
    return request;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.manager = [AFHTTPSessionManager manager];
        AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
        [serializer setRemovesKeysWithNullValues:YES];
        [_manager setResponseSerializer:serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", nil];
        [_manager.reachabilityManager startMonitoring];
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _manager.requestSerializer.timeoutInterval = TIMEOUT;
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        self.requestDic = @{}.mutableCopy;
    }
    return self;
}


- (void)needHttps{
//    http://www.cocoachina.com/ios/20140916/9632.html
    AFSecurityPolicy * securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO
    //主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    securityPolicy.validatesDomainName = NO;
    //validatesCertificateChain 是否验证整个证书链，默认为YES
    //设置为YES，会将服务器返回的Trust Object上的证书链与本地导入的证书进行对比，这就意味着，假如你的证书链是这样的：
    //GeoTrust Global CA
    //    Google Internet Authority G2
    //        *.google.com
    //那么，除了导入*.google.com之外，还需要导入证书链上所有的CA证书（GeoTrust Global CA, Google Internet Authority G2）；
    //如是自建证书的时候，可以设置为YES，增强安全性；假如是信任的CA所签发的证书，则建议关闭该验证；
//    securityPolicy.validatesCertificateChain = NO;
    _manager.securityPolicy = securityPolicy;
//方式二
    //把服务端证书(需要转换成cer格式)放到APP项目资源里，AFSecurityPolicy会自动寻找根目录下所有cer文件
    AFSecurityPolicy *securityPolicy1 = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
    securityPolicy.allowInvalidCertificates = YES;
    _manager.securityPolicy = securityPolicy1;
/*
    AFSSLPinningModeNone
 
    这个模式表示不做SSL pinning，只跟浏览器一样在系统的信任机构列表里验证服务端返回的证书。若证书是信任机构签发的就会通过，若是自己服务器生成的证书，这里是不会通过的。
    
    AFSSLPinningModeCertificate
    
    这个模式表示用证书绑定方式验证证书，需要客户端保存有服务端的证书拷贝，这里验证分两步，第一步验证证书的域名/有效期等信息，第二步是对比服务端返回的证书跟客户端返回的是否一致。
    
    这里还没弄明白第一步的验证是怎么进行的，代码上跟去系统信任机构列表里验证一样调用了SecTrustEvaluate，只是这里的列表换成了客户端保存的那些证书列表。若要验证这个，是否应该把服务端证书的颁发机构根证书也放到客户端里？
    
    AFSSLPinningModePublicKey
    
    这个模式同样是用证书绑定方式验证，客户端要有服务端的证书拷贝，只是验证时只验证证书里的公钥，不验证证书的有效期等信息。只要公钥是正确的，就能保证通信不会被窃听，因为中间人没有私钥，无法解开通过公钥加密的数据。
  */
}

- (void)getSessionWithUrl:(NSString *)url parameters:(id)parameters isMask:(BOOL)mask describle:(NSString *)describle success:(void (^) (id responseJSON))success failed:(void(^) (NSString * error))failed
{
    
    WS(ws);
    NSURLSessionDataTask * tasked = [self.requestDic objectForKey:url];
    if (tasked) {
        [self.requestDic removeObjectForKey:url];
        [tasked cancel];
    }
    NSURLSessionDataTask * task = [_manager GET:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [ws.requestDic removeObjectForKey:url];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed([error description]);
        [ws.requestDic removeObjectForKey:url];
    }];
    [self.requestDic setValue:task forKey:url];
}

- (void)postSessionWithUrl:(NSString *)url parameters:(id)parameters isMask:(BOOL)mask describle:(NSString *)describle success:(void (^)(id responseJSON))success failed:(void(^) (NSString * error))failed
{
    
    WS(ws);
    NSURLSessionDataTask * tasked = [self.requestDic objectForKey:url];
    if (tasked) {
        [self.requestDic removeObjectForKey:url];
        [tasked cancel];
    }
    NSURLSessionDataTask * task = [_manager POST:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [ws.requestDic removeObjectForKey:url];
        CMRequestState state = [ws requestStateFromStr:[responseObject objectForKey:CMStateName]];
        if (state == CMRequestState_success) {
            success(responseObject);
        }else{
            
        }
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed([error description]);
        [ws.requestDic removeObjectForKey:url];
    }];
    [self.requestDic setValue:task forKey:url];
}

- (void)postFileWithUrl:(NSString *)url parameters:(id)parameters isMask:(BOOL)mask success:(void (^)(id responseJSON))success failed:(void (^) (NSError * error))failed
{
    [_manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //application/octet-stream通用格式
        NSURL *url2=[[NSBundle mainBundle]URLForResource:@"02.jpg" withExtension:nil];
        NSData *data2=[NSData dataWithContentsOfURL:url2];
        [formData appendPartWithFileData:data2 name:@"userfile[]" fileName:@"02.jpg" mimeType:@"application/octet-stream"];
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failed(error);
    }];
}

/**
 *  获取请求状态
 *
 *  @param requestState 服务端返回的State值
 *
 *  @return state对应的字段
 */
- (CMRequestState)requestStateFromStr:(id)requestState
{
    requestState = [NSString stringWithFormat:@"%@",requestState];
    if (requestState == nil || requestState == [NSNull null] || [requestState isEqualToString:@""]) {
        return CMRequestState_Unkown;
    }
    if ([requestState isEqualToString:@"1"] || [requestState isEqualToString:@"200"])
    {
        return CMRequestState_success;
    }
    else if ([requestState isEqualToString:@"0"] || [requestState hasPrefix:@"5"])
    {
        return CMRequestState_fail;
        
    }else if([requestState isEqualToString:@"-1"] || [requestState hasPrefix:@"4"])
    {
        return CMRequestState_CertifyFail;
    }
    else
    {
        return CMRequestState_Unkown;
    }
}


@end
