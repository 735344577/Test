//
//  BaseViewController.m
//  CloudMoneyNew
//
//  Created by nice on 15/9/21.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import "BaseViewController.h"
#import "UIKit+Category.h"
#import "PublicDefine.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "BaseNavigationViewController.h"
#import "ThirdParty.h"
#import "CMTouchID.h"
#import "APIManager.h"
@interface BaseViewController ()<MBProgressHUDDelegate>
{
    UIView * sickNetView;
    MBProgressHUD * waitingHUD;
    
}
@end

@implementation BaseViewController

#pragma  mark SystemMethod 系统自带方法   

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configuration];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark 设置状态栏字体颜色为白色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight;
}

- (BOOL)shouldAutorotate
{
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark customMethod 自定义方法
- (void)configuration
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.navigationController.navigationBar.translucent = NO;
}

#pragma mark BarButtonItem
//返回按钮
- (void)buildBackButton
{
    UIButton * backBtn = [UIButton buttonwithType:UIButtonTypeCustom Frame:CGRectMake(0, 0, 25 /2, 45 / 2) TitileName:nil backgroundIamge:@"BarBtnImage.png"];
    [backBtn addTarget:self action:@selector(popToLastController:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * backBarBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backBarBtn;
}

- (void)popToLastController:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 注册按钮
- (void)registerButton
{
    UIBarButtonItem * registerBtn = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleBordered target:self action:@selector(toRegister)];
    [registerBtn setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = registerBtn;
}

- (void)toRegister
{
    RegisterViewController * registerVC = [[RegisterViewController alloc] init];
    [registerVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:registerVC animated:YES];
}

#pragma mark -- 登录按钮
- (void)loginButton
{
    UIBarButtonItem *loginBarBtn=[[UIBarButtonItem alloc]initWithTitle:@"登录" style: UIBarButtonItemStylePlain target:self action:@selector(toLoginView)];
    [loginBarBtn setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = loginBarBtn;
}

- (void)toLoginView
{
    LoginViewController * loginVC = [[LoginViewController alloc] init];
    [loginVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
}

#pragma mark 展示
- (void)showGuideView:(NSString *)imageName byKey:(NSString *)key
{
    
}
#pragma -mark 移除
- (void)removeGuide:(UIButton *)button
{
    
}
#pragma -mark 分享
- (void)shareToFriends:(UIView *)view shareText:(NSString *)text
{
    [UMSocialWechatHandler setWXAppId:WXID appSecret:WXAppSecret url:self.recommendURL];
    [UMSocialQQHandler setQQWithAppId:QQID appKey:QQKey url:self.recommendURL];
}

#pragma mark noNet  无网络或者弱网时显示的页面
- (void)showWhenNoNetOrNetIsSick
{
    float height = VIEW_HEIGHT(self.view) / 2;
    sickNetView = [UIView viewWithFrame:self.view.bounds bgColor:@"#FFFFFF"];
    UIImage * image = [UIImage imageNamed:@"nonetlogo.png"];
    CGRect rect = CGRectMake((self.view.frame.size.width-image.size.width/3)/2,height - 180,image.size.width/3, image.size.height/3);
    UIImageView * logoImage = [UIImageView imageViewWithFrame:rect image:image];
    [sickNetView addSubview:logoImage];
    
    //显示信息
    UILabel * messageLable = [UILabel labelwithFrame:CGRectMake((VIEW_WIDTH(self.view) - 200) / 2, height - 60, 200, 40) TextName:@"网络不给力,请检查网络连接" FontSize:16 textColor:@"#313131"];
    [sickNetView addSubview:messageLable];
    //重新加载 btn
    UIButton * reloadBtn = [UIButton buttonwithType:UIButtonTypeCustom Frame:CGRectMake((VIEW_WIDTH(self.view) - 120) / 2, height - 10, 120, 30) TitileName:@"重新加载" backgroundIamge:nil];
    [reloadBtn  setTitleColor:[UIColor  colorWithHexString:@"#313131"] forState:UIControlStateNormal];
    [reloadBtn titleLabel].font = [UIFont  systemFontOfSize:14];
    reloadBtn.layer.cornerRadius = 4;
    reloadBtn.layer.masksToBounds = YES;
    [[reloadBtn layer] setBorderWidth:0.40];
    [[reloadBtn layer] setBorderColor:[UIColor  colorWithHexString:@"#BBBAAA"].CGColor];
    [reloadBtn  addTarget:self action:@selector(reloadAgain) forControlEvents:UIControlEventTouchUpInside];
    [sickNetView  addSubview:reloadBtn];
    [self.view  addSubview:sickNetView];
    sickNetView.hidden = YES;
}

/**
 点击重新加载网络
 */
- (void)reloadAgain
{
    
}

- (void)showSickNetView
{
    
}

- (BaseNavigationViewController *)navVC
{
    return (BaseNavigationViewController *)self.navigationController;
}

- (void)cancelPanGesture:(BOOL)ist
{
    self.navVC.panGestureRecognizer.enabled = ist;
}

- (void)waitingHUDStart:(BOOL)isStart
{
    if (isStart) {
        if (!waitingHUD) {
            waitingHUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:waitingHUD];
            waitingHUD.color = [UIColor blackColor];
            waitingHUD.customView.alpha = 1;
            waitingHUD.labelText = @"加载中...";
            waitingHUD.delegate = self;
        }
        [waitingHUD show:YES];
    }
    else
    {
        [waitingHUD hide:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
