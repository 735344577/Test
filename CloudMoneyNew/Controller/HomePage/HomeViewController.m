//
//  HomeViewController.m
//  CloudMoneyNew
//
//  Created by nice on 15/9/22.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import "HomeViewController.h"
#import "CMCircleProgressView.h"
#import "CMLineProgressView.h"
#import "LoadingView.h"
#import "WHAnimation.h"
#import "CMUserInfo.h"
#import "BaseRequest.h"
#import "KLAttStrView.h"
#import "ChangeValueLabel.h"
@interface HomeViewController ()
@property (nonatomic, strong) ChangeValueLabel * ValueLabel;
@end

@implementation HomeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self loginButton];
        [self registerButton];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray * arr = [NSMutableArray arrayWithCapacity:3];
    [arr addObject:[WHAnimation replicatorLayer_Circle]];
    [arr addObject:[WHAnimation replicatorLayer_Wave]];
    [arr addObject:[WHAnimation replicatorLayer_Triangle]];
    [arr addObject:[WHAnimation replicatorLayer_Grid]];
    [arr addObject:[WHAnimation replicatorLayer_upDown]];
    [arr addObject:[WHAnimation replicatorLayer_upDown1]];
    CGFloat radius = 80;
    for (NSInteger loop = 0; loop < arr.count; loop ++) {
        NSInteger col = loop % 4;
        NSInteger row = loop / 4;
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(radius * col, radius * row, radius, radius)];
        view.backgroundColor = [UIColor lightGrayColor];
        [view.layer addSublayer:[arr objectAtIndex:loop]];
//        [self.view addSubview:view];
    }
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(100, 250, 200, 200)];
    [view.layer addSublayer:[WHAnimation replicatorLayer_HUD]];
//    [self.view addSubview:view];
    
    NSString * content = @"5.8k\n粉丝";
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 300, 80, 80);
    button.backgroundColor = [UIColor lightGrayColor];
    button.titleLabel.numberOfLines = 2;
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:content];
    [attributeString addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:22.0], NSFontAttributeName, nil] range:NSMakeRange(0, content.length - 2)];
    [attributeString addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor cyanColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:14.0], NSFontAttributeName, nil] range:NSMakeRange(content.length -2, 2)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5.0;
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,content.length)];
    [button setAttributedTitle:attributeString forState:UIControlStateNormal];
//    [self.view addSubview:button];
    
    NSString * string=@"我已阅读并同意《用户注册服务协议》《支付协议》";
    NSRange range = [string rangeOfString:@"《用户注册服务协议》"];
    NSRange range1 = [string rangeOfString:@"《支付协议》"];
    NSMutableAttributedString* attributeStr=[[NSMutableAttributedString alloc]initWithString:string];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range1];
    KLAttStrView * strView = [[KLAttStrView alloc] initWithFrame:CGRectMake(50, 350, ScreenWidth - 100, 40)];
    strView.attributedString = attributeStr;
    strView.backgroundColor = [UIColor clearColor];
    [strView sizeToFit];
    [strView setClickAction:^(NSUInteger index) {
        if ([Status isContainsIndex:index range:range]) {
            NSLog(@"点击《用户注册服务协议》");
        }else if ([Status isContainsIndex:index range:range1])
            NSLog(@"点击《支付协议》");
    }];
    
    [self.view addSubview:strView];
    
    _ValueLabel = [ChangeValueLabel new];
    _ValueLabel.frame = CGRectMake(50, 300, ScreenWidth - 100, 40);
    _ValueLabel.font = [UIFont systemFontOfSize:30];
    _ValueLabel.textAlignment = NSTextAlignmentCenter;
    _ValueLabel.textColor = [UIColor redColor];
    [self.view addSubview:_ValueLabel];
//    _ValueLabel.headerString = @"￥";
    
    UILabel * label = [UILabel new];
    label.text = @"改进和规范公安派出所出具证明工作，是公安部等12个部门深入贯彻中央全面深化改革和国务院协同推进简政放权、放管结合、优化服务重要部署的实际举措。根据党中央、国务院的部署，公安部将改进和规范派出所出具证明工作作为全面深化公安改革、推进职能转变的一项重点任务，成立工作专班，协调12个部门深入研究、全力攻坚，着力解决群众反映强烈的这一突出问题。经过半年多的努力，于近日出台了《意见》和《通知》两个文件，自今年9月1日起实施。";
    label.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label];
    label.numberOfLines = 0;
    [label setLineSpace:8];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
    }];
    // Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"首页";
    [self loginButton];
    [self registerButton];
    [_ValueLabel animationChangeValueFromValue:0.0 toValue:999999999.976 decimal:YES];
    CMLineProgressView * progressView = [[CMLineProgressView alloc] initWithFrame:CGRectMake(50, 200, CGRectGetWidth(self.view.frame) - 2 * 50, 8)];
    progressView.trackTintColor = [UIColor purpleColor];
    progressView.progressTintColor = [UIColor colorWithRed:140 / 255.0 green:2 / 255.0 blue:140 / 255.0 alpha:1.0];
    progressView.progress = 0.5;
    [self.view addSubview:progressView];
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

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
