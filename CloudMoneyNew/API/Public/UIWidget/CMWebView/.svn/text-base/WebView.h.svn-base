//
//  WebView.h
//  TestDraw
//
//  Created by nice on 15/11/24.
//  Copyright © 2015年 NICE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@class WebView;
@protocol WebViewDelegate <NSObject>
@optional

- (void)webViewDidStartLoad:(WebView *)webView;
- (void)webViewDidFinishLoad:(WebView *)webView;
- (void)webView:(WebView *)webView didFailLoadWithError:(NSError *)error;
- (BOOL)webView:(WebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;

@end

///无缝切换UIWebView   会根据系统版本自动选择 使用WKWebView 还是  UIWebView
@interface WebView : UIView
///内部使用的webView
//@property (nonatomic, readonly) id realWebView;
@property(weak,nonatomic)id<WebViewDelegate> delegate;
///是否正在使用 UIWebView
@property (nonatomic, readonly) BOOL usingUIWebView;

@property (nonatomic, readonly) NSURLRequest *originRequest;

//webView进度
//第一种方法   webView加载进度条 默认为nil需自己创建
@property (nonatomic, strong) UIProgressView * progressView;

/**
 *  第二种方法  获取当前webView加载进度
 */
- (void)getProgress:(void (^)(float progress))progress;

/**
 *  添加js回调oc通知方式，适用于 iOS8 之后
 */
- (void)addScriptMessageHandler:(id <WKScriptMessageHandler>)scriptMessageHandler name:(NSString *)name;
/**
 *  注销 注册过的js回调oc通知方式，适用于 iOS8 之后
 */
- (void)removeScriptMessageHandlerForName:(NSString *)name;

///back 层数
- (NSInteger)countOfHistory;
- (void)gobackWithStep:(NSInteger)step;

///---- UI 或者 WK 的API
@property (nonatomic, readonly) UIScrollView *scrollView;

- (id)loadRequest:(NSURLRequest *)request;
- (id)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL;

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly) NSURLRequest *currentRequest;
@property (nonatomic, readonly) NSURL *URL;

@property (nonatomic, readonly, getter=isLoading) BOOL loading;
@property (nonatomic, readonly) BOOL canGoBack;
@property (nonatomic, readonly) BOOL canGoForward;

- (id)goBack;
- (id)goForward;
- (id)reload;
- (id)reloadFromOrigin;
- (void)stopLoading;

- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id, NSError *))completionHandler;
///不建议使用这个办法  因为会在内部等待webView 的执行结果
- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)javaScriptString __deprecated_msg("Method deprecated. Use [evaluateJavaScript:completionHandler:]");

///是否根据视图大小来缩放页面  默认为YES
@property (nonatomic, assign) BOOL scalesPageToFit;

@end

