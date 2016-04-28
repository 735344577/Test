//
//  WebView.m
//  TestDraw
//
//  Created by nice on 15/11/24.
//  Copyright © 2015年 NICE. All rights reserved.
//

#import "WebView.h"
#import "IMY_NJKWebViewProgress.h"
#define IS_iOS8  [[UIDevice currentDevice].systemVersion floatValue] >= 8.0
typedef void(^Progress)(float progress);

@interface WebView ()<WKNavigationDelegate, WKUIDelegate, UIWebViewDelegate, IMY_NJKWebViewProgressDelegate>
@property (nonatomic, assign) double estimatedProgress;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSURLRequest *originRequest;
@property (nonatomic, strong) NSURLRequest *currentRequest;

@property (nonatomic, strong) id webView;
@property (nonatomic, strong) IMY_NJKWebViewProgress* webViewProgress;
@property (nonatomic, copy) Progress progress;
@end


@implementation WebView

@synthesize scalesPageToFit = _scalesPageToFit;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initMySelf];
    }
    return self;
}

- (void)_initMySelf
{
    
    Class wkWebView = NSClassFromString(@"WKWebView");
    if(wkWebView && IS_iOS8)
    {
        [self initWKWebView];
        _usingUIWebView = NO;
    }
    else
    {
        [self initUIWebView];
        _usingUIWebView = YES;
    }
    self.scalesPageToFit = YES;
    
    [self.webView setFrame:self.bounds];
    [self.webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self addSubview:self.webView];
}

- (void)initUIWebView
{
    UIWebView* uiWebView = [[UIWebView alloc] initWithFrame:self.bounds];
    uiWebView.backgroundColor = [UIColor clearColor];
    uiWebView.opaque = NO;
    for (UIView *subview in [uiWebView.scrollView subviews])
    {
        if ([subview isKindOfClass:[UIImageView class]])
        {
            ((UIImageView *) subview).image = nil;
            subview.backgroundColor = [UIColor clearColor];
        }
    }
    uiWebView.delegate = self;
    self.webViewProgress = [[IMY_NJKWebViewProgress alloc] init];
    
    uiWebView.delegate = _webViewProgress;
    _webViewProgress.webViewProxyDelegate = self;
    _webViewProgress.progressDelegate = self;
    
    _webView = uiWebView;

}

-(void)initWKWebView
{
    WKWebViewConfiguration* configuration = [[NSClassFromString(@"WKWebViewConfiguration") alloc] init];
    configuration.preferences = [NSClassFromString(@"WKPreferences") new];
    configuration.userContentController = [NSClassFromString(@"WKUserContentController") new];
    
    WKWebView * wkWebView = [[NSClassFromString(@"WKWebView") alloc] initWithFrame:self.bounds configuration:configuration];
    wkWebView.UIDelegate = self;
    wkWebView.navigationDelegate = self;
    
    wkWebView.backgroundColor = [UIColor clearColor];
    wkWebView.opaque = NO;
    _webView = wkWebView;
    [self addSubview:_webView];
    
    //通知获取h5 title
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"estimatedProgress"])
    {
        self.estimatedProgress = [change[NSKeyValueChangeNewKey] doubleValue];
        [self progressUpdate];
    }
    else if([keyPath isEqualToString:@"title"])
    {
        self.title = change[NSKeyValueChangeNewKey];
        [self topViewController].title = self.title;
    }
}

- (void)progressUpdate
{
    if (_progress) {
        _progress(self.estimatedProgress);
    }
    if (_progressView) {
        [_progressView setProgress:_estimatedProgress];
        if (_estimatedProgress < 1.0) {
            _progressView.hidden = NO;
        }else{
//            _progressView.hidden = YES;
            _progressView.progress = 0;
        }
    }

}


#pragma -mark MKNavigationDelegate
// 在发送请求之前，决定是否跳转
//根据webView、navigationAction相关信息决定这次跳转是否可以继续进行,这些信息包含HTTP发送请求，如头部包含User-Agent,Accept
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    NSString * hostName = navigationAction.request.URL.host.lowercaseString;
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated && ![hostName containsString:@".baidu.com"]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
// 在收到响应后，决定是否跳转
//这个代理方法表示当客户端收到服务器的响应头，根据response相关信息，可以决定这次跳转是否可以继续进行。
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    decisionHandler(WKNavigationResponsePolicyAllow);
}
//用来追踪加载过程（页面开始加载、加载完成、加载失败）的方法：
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

//页面跳转的代理方法：
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"");
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"didCommit");
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

/*! @abstract Invoked when an error occurs during a committed main frame
 navigation.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 @param error The error that occurred.
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

//如果我们的请求要求授权、证书等，我们需要处理下面的代理方法，以提供相应的授权处理等：
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler
{
    
}

//当我们终止页面加载时，我们会可以处理下面的代理方法，如果不需要处理，则不用实现之：
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0)
{
    
}


#pragma -mark WKUIDelegate
// 创建一个新的WebView
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    return webView;
}

/*! @abstract Notifies your app that the DOM window object's close() method completed successfully.
 @param webView The web view invoking the delegate method.
 @discussion Your app should remove the web view from the view hierarchy and update
 the UI as needed, such as by closing the containing browser tab or window.
 */
- (void)webViewDidClose:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0)
{
    
}

/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param frame             主窗口
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    // js 里面的alert实现，如果不实现，网页的alert函数无效
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];
    
    [[self topViewController] presentViewController:alertController animated:YES completion:^{}];
}


- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler(YES);
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action){
                                                          completionHandler(NO);
                                                      }]];
    
    [[self topViewController] presentViewController:alertController animated:YES completion:^{}];
}



- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler
{
    completionHandler(@"Client Not handler");
}


//WKWebView 执行脚本方法

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


#pragma -mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    BOOL resultBOOL = YES;
    if([self.delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)])
    {
        if(navigationType == UIWebViewNavigationTypeOther) {
            navigationType = UIWebViewNavigationTypeOther;
        }
        resultBOOL = [self.delegate webView:self shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    return resultBOOL;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if(self.originRequest == nil)
    {
        self.originRequest = webView.request;
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma -mark IMY_NJKWebViewProgress
- (void)webViewProgress:(IMY_NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    self.estimatedProgress = progress;
    [self progressUpdate];
}

#pragma mark- 基础方法
-(UIScrollView *)scrollView
{
    return [(id)self.webView scrollView];
}

- (id)loadRequest:(NSURLRequest *)request
{
    if ([_webView isKindOfClass:[UIWebView class]]) {
        [(UIWebView *)_webView loadRequest:request];
        return nil;
    }
    return  [(WKWebView *)_webView loadRequest:request];
}

- (id)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL
{
    if ([_webView isKindOfClass:[UIWebView class]]) {
        [(UIWebView *)_webView loadHTMLString:string baseURL:baseURL];
        return nil;
    }
    return [(WKWebView *)_webView loadHTMLString:string baseURL:baseURL];
}

-(NSURLRequest *)currentRequest
{
    if(_usingUIWebView)
    {
        return [(UIWebView*)self.webView request];;
    }
    else
    {
        return _currentRequest;
    }
}
-(NSURL *)URL
{
    if(_usingUIWebView)
    {
        return [(UIWebView*)self.webView request].URL;;
    }
    else
    {
        return [(WKWebView*)self.webView URL];
    }
}
-(BOOL)isLoading
{
    return [self.webView isLoading];
}
-(BOOL)canGoBack
{
    return [self.webView canGoBack];
}
-(BOOL)canGoForward
{
    return [self.webView canGoForward];
}

- (id)goBack
{
    if(_usingUIWebView)
    {
        [(UIWebView*)self.webView goBack];
        return nil;
    }
    else
    {
        return [(WKWebView*)self.webView goBack];
    }
}
- (id)goForward
{
    if(_usingUIWebView)
    {
        [(UIWebView*)self.webView goForward];
        return nil;
    }
    else
    {
        return [(WKWebView*)self.webView goForward];
    }
}
- (id)reload
{
    if(_usingUIWebView)
    {
        [(UIWebView*)self.webView reload];
        return nil;
    }
    else
    {
        return [(WKWebView*)self.webView reload];
    }
}
- (id)reloadFromOrigin
{
    if(_usingUIWebView)
    {
        if(self.originRequest)
        {
            [self evaluateJavaScript:[NSString stringWithFormat:@"window.location.replace('%@')",self.originRequest.URL.absoluteString] completionHandler:nil];
        }
        return nil;
    }
    else
    {
        return [(WKWebView*)self.webView reloadFromOrigin];
    }
}
- (void)stopLoading
{
    [self.webView stopLoading];
}

- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id, NSError *))completionHandler
{
    if(_usingUIWebView)
    {
        NSString* result = [(UIWebView*)self.webView stringByEvaluatingJavaScriptFromString:javaScriptString];
        if(completionHandler)
        {
            completionHandler(result,nil);
        }
    }
    else
    {
        return [(WKWebView*)self.webView evaluateJavaScript:javaScriptString completionHandler:completionHandler];
    }
}

-(NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)javaScriptString
{
    if(_usingUIWebView)
    {
        NSString* result = [(UIWebView*)self.webView stringByEvaluatingJavaScriptFromString:javaScriptString];
        return result;
    }
    else
    {
        __block NSString* result = nil;
        __block BOOL isExecuted = NO;
        [(WKWebView*)self.webView evaluateJavaScript:javaScriptString completionHandler:^(id obj, NSError *error) {
            result = obj;
            isExecuted = YES;
        }];
        
        while (isExecuted == NO) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        return result;
    }
}
-(void)setScalesPageToFit:(BOOL)scalesPageToFit
{
    if(_usingUIWebView)
    {
        UIWebView* webView = _webView;
        webView.scalesPageToFit = scalesPageToFit;
    }
    else
    {
        if(_scalesPageToFit == scalesPageToFit)
        {
            return;
        }
        
        WKWebView* webView = _webView;
        
        NSString *jScript = @"var meta = document.createElement('meta'); \
        meta.name = 'viewport'; \
        meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'; \
        var head = document.getElementsByTagName('head')[0];\
        head.appendChild(meta);";
        
        if(scalesPageToFit)
        {
            WKUserScript *wkUScript = [[NSClassFromString(@"WKUserScript") alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
            [webView.configuration.userContentController addUserScript:wkUScript];
        }
        else
        {
            NSMutableArray* array = [NSMutableArray arrayWithArray:webView.configuration.userContentController.userScripts];
            for (WKUserScript *wkUScript in array)
            {
                if([wkUScript.source isEqual:jScript])
                {
                    [array removeObject:wkUScript];
                    break;
                }
            }
            for (WKUserScript *wkUScript in array)
            {
                [webView.configuration.userContentController addUserScript:wkUScript];
            }
        }
    }
    
    _scalesPageToFit = scalesPageToFit;
}
-(BOOL)scalesPageToFit
{
    if(_usingUIWebView)
    {
        return [_webView scalesPageToFit];
    }
    else
    {
        return _scalesPageToFit;
    }
}
/**
 *  添加js回调oc通知方式，适用于 iOS8 之后
 */
- (void)addScriptMessageHandler:(id <WKScriptMessageHandler>)scriptMessageHandler name:(NSString *)name
{
    if ([_webView isKindOfClass:NSClassFromString(@"WKWebView")]) {
        [[(WKWebView *)_webView configuration].userContentController addScriptMessageHandler:scriptMessageHandler name:name];
    }
}

/**
 *  注销 注册过的js回调oc通知方式，适用于 iOS8 之后
 */
- (void)removeScriptMessageHandlerForName:(NSString *)name
{
    if ([_webView isKindOfClass:NSClassFromString(@"WKWebView")]) {
        [[(WKWebView *)_webView configuration].userContentController removeScriptMessageHandlerForName:name];
    }
}

-(NSInteger)countOfHistory
{
    if(_usingUIWebView)
    {
        UIWebView* webView = self.webView;
        
        int count = [[webView stringByEvaluatingJavaScriptFromString:@"window.history.length"] intValue];
        if (count)
        {
            return count;
        }
        else
        {
            return 1;
        }
    }
    else
    {
        WKWebView* webView = self.webView;
        return webView.backForwardList.backList.count;
    }
}
-(void)gobackWithStep:(NSInteger)step
{
    if(self.canGoBack == NO)
        return;
    
    if(step > 0)
    {
        NSInteger historyCount = self.countOfHistory;
        if(step >= historyCount)
        {
            step = historyCount - 1;
        }
        
        if(_usingUIWebView)
        {
            UIWebView* webView = self.webView;
            [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"window.history.go(-%ld)", (long) step]];
        }
        else
        {
            WKWebView* webView = self.webView;
            WKBackForwardListItem* backItem = webView.backForwardList.backList[step];
            [webView goToBackForwardListItem:backItem];
        }
    }
    else
    {
        [self goBack];
    }
}

#pragma mark-  如果没有找到方法 去webView 中调用
-(BOOL)respondsToSelector:(SEL)aSelector
{
    BOOL hasResponds = [super respondsToSelector:aSelector];
    if(hasResponds == NO)
    {
        hasResponds = [self.delegate respondsToSelector:aSelector];
    }
    if(hasResponds == NO)
    {
        hasResponds = [self.webView respondsToSelector:aSelector];
    }
    return hasResponds;
}
- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature* methodSign = [super methodSignatureForSelector:selector];
    if(methodSign == nil)
    {
        if([self.webView respondsToSelector:selector])
        {
            methodSign = [self.webView methodSignatureForSelector:selector];
        }
        else
        {
            methodSign = [(id)self.delegate methodSignatureForSelector:selector];
        }
    }
    return methodSign;
}
- (void)forwardInvocation:(NSInvocation*)invocation
{
    if([self.webView respondsToSelector:invocation.selector])
    {
        [invocation invokeWithTarget:self.webView];
    }
    else
    {
        [invocation invokeWithTarget:self.delegate];
    }
}


#pragma -mark other
- (UIViewController *)topViewController
{
    UIResponder * next = self.nextResponder;
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    } while (next != nil);
    return nil;
}

- (void)dealloc
{
    if(_usingUIWebView)
    {
        UIWebView* webView = _webView;
        webView.delegate = nil;
    }
    else
    {
        WKWebView* webView = _webView;
        webView.UIDelegate = nil;
        webView.navigationDelegate = nil;
        
        [webView removeObserver:self forKeyPath:@"estimatedProgress"];
        [webView removeObserver:self forKeyPath:@"title"];
    }
    [_webView scrollView].delegate = nil;
    [_webView stopLoading];
    [(UIWebView*)_webView loadHTMLString:@"" baseURL:nil];
    [_webView stopLoading];
    [_webView removeFromSuperview];
    _webView = nil;
}

#pragma -mark Setting

- (void)setProgressView:(UIProgressView *)progressView
{
    _progressView = progressView;
    //通知获取h5加载进度
    if (!_progress) {
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
}

#pragma -mark Getting
- (void)getProgress:(void (^)(float))progress
{
    _progress = progress;
    //通知获取h5加载进度
    if (!_progressView) {
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
}


@end

