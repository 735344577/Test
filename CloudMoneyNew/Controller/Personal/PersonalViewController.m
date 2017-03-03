//
//  PersonalViewController.m
//  CloudMoneyNew
//
//  Created by nice on 15/9/22.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import "PersonalViewController.h"

@interface PersonalViewController ()<UIScrollViewDelegate>
/**<#Description#>*/
@property (nonatomic, strong) UIScrollView *bgScrollView;
/**<#Description#>*/
@property (nonatomic, strong) UIScrollView *topScrollView;
/**<#Description#>*/
//@property (nonatomic, strong) UIScrollView *bottomScrollView;
@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    [self.view addSubview:self.bgScrollView];
    [self.bgScrollView addSubview:self.topScrollView];
//    [self.bgScrollView addSubview:self.bottomScrollView];
    [self.bgScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.topScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.bgScrollView);
        make.height.equalTo(ScreenHeight - 64 - 49);
        make.width.equalTo(ScreenWidth);
    }];
    UIView *view1 = [UIView new];
    [self.topScrollView addSubview:view1];
    view1.backgroundColor = [UIColor orangeColor];
    [view1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.topScrollView);
        make.width.equalTo(ScreenWidth);
        make.height.equalTo(ScreenHeight);
    }];
    
    UIView *grayView = [UIView new];
    grayView.backgroundColor = [UIColor colorWithHexString:@"#eaeaea"];
    [self.topScrollView addSubview:grayView];
    [grayView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.topScrollView);
        make.top.equalTo(view1.bottom);
        make.height.equalTo(100);
    }];
    
    UIView *view2 = [UIView new];
    [self.bgScrollView addSubview:view2];
    view2.backgroundColor = [UIColor redColor];
    [view2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.bgScrollView);
        make.width.equalTo(ScreenWidth);
        make.height.equalTo(ScreenHeight - 64 - 49);
        make.top.equalTo(self.topScrollView.bottom);
    }];
    
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat topOffsetY = _topScrollView.contentOffset.y;
    CGFloat result = _topScrollView.contentSize.height - _topScrollView.bounds.size.height;
    result = result < 0 ? 0 : result;
    CGFloat bottomTop = _bgScrollView.contentSize.height - CGRectGetHeight(self.view.bounds);
    CGFloat bottomOffsetY = _bgScrollView.contentOffset.y;
    if (topOffsetY >= result + 60) {
        _bgScrollView.scrollEnabled = YES;
        [_bgScrollView setContentOffset:CGPointMake(0, bottomTop) animated:YES];
        DLog(@"bottomOffsetY = %f", bottomOffsetY);
    }
    
    
//    if (bottomOffsetY <= 50) {
//        _bgScrollView.scrollEnabled = NO;
//    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIScrollView *)topScrollView {
    if (!_topScrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.delegate = self;
        _topScrollView = scrollView;
    }
    return _topScrollView;
}

- (UIScrollView *)bgScrollView {
    if (!_bgScrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.delegate = self;
//        scrollView.scrollEnabled = NO;
        scrollView.pagingEnabled = YES;
        _bgScrollView = scrollView;
    }
    return _bgScrollView;
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
