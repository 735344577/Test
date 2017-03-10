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
#import "KLBannerLoopView.h"
#import "KLPopView.h"
#import "SDBarView.h"
#import "SDMutiBarView.h"
@interface HomeViewController ()
@property (nonatomic, strong) ChangeValueLabel * ValueLabel;
/**<#Description#>*/
@property (nonatomic, strong) CMCircleProgressView * circleProgressView;
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
    
//    [self.view addSubview:strView];
    
    _ValueLabel = [ChangeValueLabel new];
    _ValueLabel.frame = CGRectMake(50, 300, ScreenWidth - 100, 40);
    _ValueLabel.font = [UIFont systemFontOfSize:30];
    _ValueLabel.textAlignment = NSTextAlignmentCenter;
    _ValueLabel.textColor = [UIColor redColor];
//    [self.view addSubview:_ValueLabel];
//    _ValueLabel.headerString = @"￥";
    
    
    KLBannerLoopView * bannerView = [[KLBannerLoopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150) imageArray:@[@"http://mtest.yunqiandai.com/images/activity/0630/banner/1242X450.jpg", @"http://mtest.yunqiandai.com/static/activity/anniversary2nd/img/banner/1242-450.jpg", @"http://scimg.jb51.net/allimg/160716/105-160G61F250436.jpg", @"http://c.hiphotos.baidu.com/image/h%3D200/sign=a280d7a0ed24b899c13c7e385e071d59/2934349b033b5bb54352dd5e32d3d539b700bc8d.jpg", @"http://g.hiphotos.baidu.com/image/h%3D200/sign=dccb079f4ffbfbedc359317f48f1f78e/8b13632762d0f70317eb037c0cfa513d2697c531.jpg"]];
    [bannerView setpageColor:[UIColor redColor] currentColor:[UIColor orangeColor]];
    [bannerView setPosition:PositionBottomRight];
    bannerView.textArray = @[@"1", @"2"];
    [bannerView setClickBlock:^(NSInteger index) {
        NSLog(@"index = %ld", index);
    }];
    [self.view addSubview:bannerView];
    
    KLPopView * popView = [[KLPopView alloc] initWithOrigin:CGPointMake(50, 250) width:100 height:175 Type:XTTypeOfLeftUp color:nil];
    popView.dataArray = @[@"100", @"200", @"300", @"400", @"500", @"1000", @"1500", @"2000", @"2500", @"3000"];
    NSArray * array = popView.dataArray;
    popView.selectBlock = ^(NSInteger row){
        NSLog(@"result = %@", array[row]);
    };
//    [popView popView];
        // Do any additional setup after loading the view.
    _circleProgressView = [[CMCircleProgressView alloc] initWithFrame:CGRectMake(100, 250, 55, 55)];
    _circleProgressView.lineWidth = 2.5;
    _circleProgressView.trackTintColor = [UIColor colorWithHexString:@"#d9d9d9"];
    _circleProgressView.progressTintColor = [UIColor colorWithHexString:@"#FC712E"];
    _circleProgressView.state = @"抢购中";
//    [self.view addSubview:_circleProgressView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"云钱袋";
    self.tabBarItem.title = @"首页";
    [self loginButton];
    [self registerButton];
//    [_ValueLabel animationChangeValueFromValue:0.0 toValue:999999999.976 decimal:YES];
    CMLineProgressView * progressView = [[CMLineProgressView alloc] initWithFrame:CGRectMake(50, 200, CGRectGetWidth(self.view.frame) - 2 * 50, 8)];
    progressView.trackTintColor = [UIColor purpleColor];
    progressView.progressTintColor = [UIColor colorWithRed:140 / 255.0 green:2 / 255.0 blue:140 / 255.0 alpha:1.0];
    progressView.progress = 0.5;
//    [self.view addSubview:progressView];
    
    [_circleProgressView setProgress:0 animation:NO];
    [_circleProgressView setProgress:0.5 animation:YES];
    
    
    
//    SDBarView *barView = [[SDBarView alloc] initWithFrame:CGRectZero];
//    [self.view addSubview:barView];
//    [barView makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(250);
//        make.centerX.equalTo(self.view);
//        make.width.equalTo(30);
//        make.height.equalTo(150);
//    }];
//    
//    barView.progressTintColor = [UIColor colorWithHexString:@"#FC712E"];
//    barView.progress = 0.3;
//    barView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    NSArray *message = @[@{@"progressColor": [UIColor redColor], @"progress": @(0.8)},
                         @{@"progressColor": [UIColor blueColor], @"progress": @(0.38)},
                         @{@"progressColor": [UIColor orangeColor], @"progress": @(0.2)}];
//    SDMutiBarView *barView = [SDMutiBarView mutiBarWith:message];//[[SDMutiBarView alloc] initWithFrame:CGRectZero];
//    [self.view addSubview:barView];
//    [barView makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(250);
//        make.centerX.equalTo(self.view);
//        make.width.equalTo(30);
//        make.height.equalTo(150);
//    }];
//    barView.currentColor = [UIColor redColor];
    NSMutableArray *dataSource = @[].mutableCopy;
    NSMutableArray *bars = @[].mutableCopy;
    
    for (int i = 0; i < 12; i++) {
        NSDictionary *dic = @{@"progressColor": [UIColor redColor], @"progress": @(0.4 + i * 0.05), @"duration": @(0.75 + 0.05 * i)};
        NSArray *source = @[dic,
                                   @{@"progressColor": [UIColor blueColor], @"progress": @(0.3), @"duration": @(0.55)},
                                   @{@"progressColor": [UIColor orangeColor], @"progress": @(0.2), @"duration": @(0.25)}].mutableCopy;
        [dataSource addObject:source];
        
        SDMutiBarView *barView = [SDMutiBarView mutiBarWith:source];//[[SDMutiBarView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:barView];
        [barView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(65 + (15 + 5) * i);
            make.width.equalTo(15);
            make.height.equalTo(150);
            make.top.equalTo(self.view).offset(250);
        }];
        [bars addObject:barView];
        UILabel *label = [[UILabel alloc] init];
        label.text = [NSString stringWithFormat:@"%@", @(i + 1)];
        [self.view addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(barView.bottom).offset(5);
            make.left.centerX.equalTo(barView);
        }];
    }
    SDMutiBarView *bar = bars[7];
    bar.currentColor = [UIColor purpleColor];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"10.5%";
    label.textColor = [UIColor purpleColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:label];
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bar.bottom).offset(-135);
        make.centerX.equalTo(bar);
    }];
    
    
//    barView.progressTintColor = [UIColor colorWithHexString:@"#FC712E"];
//    barView.progress = 0.3;
//    barView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarItem.title = @"首页";
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
