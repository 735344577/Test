//
//  BaseTabBarViewController.m
//  admin
//
//  Created by haitao on 15/9/21.
//  Copyright © 2015年 haitao. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseNavigationViewController.h"
#import "UIKit+Category.h"
#import "HomeViewController.h"
#import "PersonalViewController.h"
#import "ProductViewController.h"
#import "MoreViewController.h"

@interface BaseTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation BaseTabBarViewController

#pragma mark systemMothod  系统自带方法
- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.delegate = self;
    [self addViewController];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 转动方向
- (BOOL)shouldAutorotate
{
    return self.selectedViewController.shouldAutorotate;
}


#pragma  mark 选中莫个VC
//- (void)selectViewController:(NSUInteger)index
//{
//    [self selectViewController:index];
//}

#pragma mark customMethod  自定义方法
- (void)addViewController
{
    HomeViewController * homeVC = [[HomeViewController alloc] init];
    BaseNavigationViewController * homeNav = [[BaseNavigationViewController   alloc] initWithRootViewController:homeVC];
    ProductViewController * productVC = [[ProductViewController alloc] init];
    BaseNavigationViewController * productNav = [[BaseNavigationViewController alloc] initWithRootViewController:productVC];
    PersonalViewController * personalVC = [[PersonalViewController alloc] init];
    BaseNavigationViewController * personalNav = [[BaseNavigationViewController alloc] initWithRootViewController:personalVC];
    MoreViewController * moreVC = [[MoreViewController alloc] init];
    BaseNavigationViewController * moreNav = [[BaseNavigationViewController alloc] initWithRootViewController:moreVC];
    self.viewControllers = @[homeNav, productNav, personalNav, moreNav];
    homeNav.tabBarItem = [UITabBarItem itemWithTitle:@"首页" image:@"tabbar_home_normal.png" selectedImage:@"tabbar_home_select.png"];
    productNav.tabBarItem = [UITabBarItem itemWithTitle:@"投资理财" image:@"tabbar_product_normal.png" selectedImage:@"tabbar_product_select.png"];
    personalNav.tabBarItem = [UITabBarItem itemWithTitle:@"我的" image:@"tabbar_personal_normal.png" selectedImage:@"tabbar_personal_select.png"];
    moreNav.tabBarItem = [UITabBarItem itemWithTitle:@"更多" image:@"tabbar_more_normal.png" selectedImage:@"tabbar_more_select.png"];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [self.tabBar setShadowImage:[UIImage new]];
}

//在下面方法里可以修改 TabBar 的高度
- (void)viewWillLayoutSubviews {
    // 修改TabBar的高度的方法
    CGFloat tabHeight = 49;
    CGRect tabFrame = self.tabBar.frame;
    tabFrame.size.height = tabHeight;
    tabFrame.origin.y = self.view.frame.size.height - tabHeight;
    self.tabBar.frame = tabFrame;
    
    [super viewWillLayoutSubviews];
    for (UIControl *tabBarButton in self.view.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBar")]) {
            for (UIControl * barButton in tabBarButton.subviews) {
                if ([barButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                   [barButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                }
            }
        }
    }
}


- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            //需要实现的帧动画,这里根据需求自定义
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
            animation.duration = 1;
            animation.calculationMode = kCAAnimationCubic;
            //把动画添加上去就OK了
            [imageView.layer addAnimation:animation forKey:nil];
        }
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
