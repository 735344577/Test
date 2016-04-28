//
//  BaseViewController.h
//  CloudMoneyNew
//
//  Created by nice on 15/9/21.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocial.h"
@class BaseNavigationViewController;
@class APIManager;
#define QQID   @"1103560095"
#define QQKey  @"RsWmVp5CyXsWuiWg"

#define WXID   @"wxf9d1c06ee3029288"
#define WXAppSecret  @"e4ca7f53232f80a014693d46e7ee59df"

@protocol ReformerProtocol <NSObject>
- (NSDictionary *)reformDataWithManager:(APIManager *)manager;
@end

@interface BaseViewController : UIViewController<UMSocialDataDelegate, UMSocialUIDelegate>
//视图的NavigationViewController
//用于关闭手势滑动返回 例：self.navVC.panGestureRecognizer.enabled = NO;
@property (strong, nonatomic, readonly) BaseNavigationViewController * navVC;

/**
 各个类对友盟的统计描述
 */
@property (nonatomic,retain) NSString *UmengDecription;

/**
 获取分享的url地址
 */
@property (nonatomic,retain) NSString *recommendURL;

/**
 获取分享的文字
 */
@property (nonatomic,retain) NSString *recommendText;

/**
 获取分享的标题
 */
@property (nonatomic,retain) NSString *recommendTitle;

/**
 获取分享的标题
 */
@property (nonatomic,retain) NSString *recommendMoreTitle;

/**
 分享数
 */
@property (nonatomic,assign) int shareCount;


#pragma  -mark 去除滑动返回手势  YES 为开启  NO为关闭， 默认是开启的
- (void)cancelPanGesture:(BOOL)ist;

#pragma mark 返回按钮
//返回按钮
- (void)buildBackButton;
/**
 *  返回操作
*/
- (void)popToLastController:(UIButton *)sender;

#pragma mark 注册按钮
//注册按钮
- (void)registerButton;

/**
 *  跳转到注册页面
 */
- (void)toRegister;

#pragma mark 登录按钮
//登录按钮
- (void)loginButton;

//跳转到登录页面
- (void)toLoginView;

#pragma mark Guide 引导页
/**
 *  展示引导页
 */
- (void)showGuideView:(NSString *)imageName byKey:(NSString *)key;

- (void)removeGuide:(UIButton *)button;

@end
