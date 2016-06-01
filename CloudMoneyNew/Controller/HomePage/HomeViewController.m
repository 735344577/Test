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
#import "DragView.h"
#import "LoadingView.h"
#import "WHAnimation.h"
@interface HomeViewController ()
@property (nonatomic, strong) DragView * dragView;
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
//    _dragView = [[DragView alloc] initWithFrame:CGRectMake(ScreenWidth - 60, 150, 60, 80) level:ROOT clickBlock:^{
//        
//    }];
//    [self.view addSubview:_dragView];
    
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
        [self.view addSubview:view];
    }
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(100, 250, 200, 200)];
    [view.layer addSublayer:[WHAnimation replicatorLayer_HUD]];
    [self.view addSubview:view];
    
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
    
        // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"首页";
    [self loginButton];
    [self registerButton];
//    [_dragView show];
    [Status currentViewController];
    [Status appRootViewController];
    NSDictionary * dict = @{@"name":@"join", @"age": @23, @"sex":@"man", @"type":@YES, @"source":@80.5, @"array":@[@"q", @"w", @"e"], @"dic":@{@"name":@"join", @"age": @23}};
    [[self class] createPropertyWithDict:dict];
    CMLineProgressView * progressView = [[CMLineProgressView alloc] initWithFrame:CGRectMake(50, 200, CGRectGetWidth(self.view.frame) - 2 * 50, 8)];
    progressView.trackTintColor = [UIColor purpleColor];
    progressView.progressTintColor = [UIColor colorWithRed:140 / 255.0 green:2 / 255.0 blue:140 / 255.0 alpha:1.0];
    progressView.progress = 0.5;
    [self.view addSubview:progressView];
    
    LoadingView * loadView;
    
    if (!loadView) {
        loadView = [[LoadingView alloc] init];
        loadView.center = self.view.center;
//        [self.view addSubview:loadView];
    }
//    [loadView startAnimation];
}

- (void)animationStart
{
    _dragView.alpha = 1.0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationRepeatCount:2.5];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    _dragView.transform = CGAffineTransformMakeScale(1.25f, 1.25f);
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(stopAnimation)];
    [UIView commitAnimations];
}

- (void)stopAnimation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    _dragView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(hadStopAnimation)];
    [UIView commitAnimations];
}
- (void)hadStopAnimation
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _dragView.alpha = 0.7;
    });
}

- (void)dragViewAnimation
{
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _dragView.transform = CGAffineTransformMakeScale(1.25f, 1.25f);
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _dragView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:1.0 delay:2.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _dragView.transform = CGAffineTransformMakeScale(1.25f, 1.25f);
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:1.0 delay:3.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _dragView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:1.0 delay:4.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _dragView.transform = CGAffineTransformMakeScale(1.25f, 1.25f);
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:1.0 delay:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _dragView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_dragView hide];
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
