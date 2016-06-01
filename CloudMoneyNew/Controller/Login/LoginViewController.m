//
//  LoginViewController.m
//  CloudMoneyNew
//
//  Created by nice on 15/9/22.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import "LoginViewController.h"
#import "UIKit+Category.h"
#import "PublicDefine.h"
#import "BaseNavigationViewController.h"
#import "ForgetPasswordViewController.h"
#import "RegisterViewController.h"
#import "Masonry.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
@interface LoginViewController ()
{
    UITextField * usernameTF;
    UITextField * passwordTF;
    
    
}
@end

@implementation LoginViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"登录";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self constructUI];
    self.navVC.panGestureRecognizer.enabled = YES;
    
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self buildBackButton];
    
    
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark  UI

- (void)constructUI
{
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    WS(ws);
    UIView  *whiteView = [[UIView  alloc]initWithFrame:CGRectMake(0, 40,VIEW_WIDTH(self.view), 91)];
    whiteView.backgroundColor = [UIColor   colorWithHexString:@"#FFFFFF"];
    [self.view  addSubview:whiteView];
    
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view).with.offset(10);
        make.right.equalTo(ws.view).with.offset(-10);
        make.top.equalTo(ws.view).with.offset(40);
        make.height.mas_equalTo(@91);
    }];
    
    //头像
    UIImageView *headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 18, 23)];
    headerImage.image = [UIImage  imageNamed:@"loginUser.png"];
    
    //用户名左视图
    UIView *userLeftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [userLeftview addSubview:headerImage];
    
    //输入用户名
    usernameTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, VIEW_WIDTH(self.view) - 40, 45)];
    usernameTF.autocapitalizationType =  UITextAutocapitalizationTypeNone;
    usernameTF.leftView = userLeftview;
    usernameTF.leftViewMode = UITextFieldViewModeAlways;
    usernameTF.placeholder = @"用户名/手机号/邮箱";
    usernameTF.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [whiteView  addSubview:usernameTF];
    
    //分割线
    UIView *lineView = [[UIView  alloc]initWithFrame:CGRectMake(5, 45.5,whiteView.frame.size.width-10, 0.5)];
    lineView.backgroundColor = [UIColor   colorWithHexString:@"F5F5F5"];
    [whiteView  addSubview:lineView];
    
    //密码 图
    UIImageView *passWordImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 17, 23)];
    passWordImage.image = [UIImage  imageNamed:@"loginpassword.png"];
    //密码左视图
    UIView *passwordLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [passwordLeftView addSubview:passWordImage];
    //输入密码
    passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(10, 46, VIEW_WIDTH(self.view) - 40, 45)];
    passwordTF.autocapitalizationType =  UITextAutocapitalizationTypeNone;
    passwordTF.leftView = passwordLeftView;
    passwordTF.leftViewMode = UITextFieldViewModeAlways;
    passwordTF.delegate = self;
    passwordTF.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    passwordTF.placeholder = @"密  码";
    passwordTF.secureTextEntry = YES;
    [whiteView addSubview:passwordTF];
    
    
    //忘记密码
    UIButton * forgetPassword_btn = [UIButton buttonWithTitle:@"忘记密码" titleColor:@"#32A8EC" buttonBgColor:nil];
    forgetPassword_btn.titleLabel.font  = [UIFont systemFontOfSize: 13];
    [forgetPassword_btn addTarget:self action:@selector(forgetPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPassword_btn];
    [forgetPassword_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.view).with.offset(-20); //距离self.view右边20
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@30);
        make.top.equalTo(ws.view).with.offset(135);
    }];
    
    // 登陆
    UIButton *login_btn = [UIButton buttonWithTitle:@"登录" titleColor:@"#FFFFFF" buttonBgColor:nil];
    login_btn.tintColor = [UIColor colorWithHexString:@"#FFFFFF"];
    login_btn.layer.cornerRadius = 4;
    login_btn.backgroundColor = [UIColor colorWithHexString:@"#32A8EC"];
    login_btn.titleLabel.font = [UIFont  systemFontOfSize:17];
    [login_btn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:login_btn];
    login_btn.uxy_acceptEventInterval = 2.0;
    [login_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.view).with.offset(-20);
        make.left.equalTo(ws.view).with.offset(20);
        make.height.mas_equalTo(@40);
        make.top.equalTo(ws.view).with.offset(190);
    }];
    
    // 注册
    UIButton *register_btn = [UIButton buttonWithTitle:@"注册" titleColor:@"#FFFFFF" buttonBgColor:@"#FC712E"];
    register_btn.tintColor = [UIColor  colorWithHexString:@"#FFFFFF"];
    register_btn.layer.cornerRadius = 4;
    register_btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [register_btn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:register_btn];
    [register_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.view).with.offset(-20);
        make.left.equalTo(ws.view).with.offset(20);
        make.top.equalTo(ws.view).with.offset(245);
        make.height.mas_equalTo(@40);
    }];
}

- (void)forgetPassword:(UIButton *)sender
{
    ForgetPasswordViewController * forgetVC = [[ForgetPasswordViewController alloc] init];
    [self.navVC pushViewController:forgetVC animated:YES];
}


- (void)loginAction:(UIButton *)sender
{
    
}

- (void)registerAction:(UIButton *)sender
{
    RegisterViewController * registerVC = [[RegisterViewController alloc] init];
    [self.navVC pushViewController:registerVC animated:YES];
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
