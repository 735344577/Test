//
//  ProductViewController.m
//  CloudMoneyNew
//
//  Created by nice on 15/9/22.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import "ProductViewController.h"

@interface ProductViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIImageView *topImageView;
@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.extendedLayoutIncludesOpaqueBars = YES;
//    self.modalPresentationCapturesStatusBarAppearance = NO;
//    self.navigationController.navigationBar.translucent = NO;
    [self.view addSubview:self.tableView];
    self.topImageView.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 150);
//    [self.tableView addSpringHeadView:self.topImageView];
        UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.topImageView.frame) - 30, 100, 30)];
    label1.backgroundColor = [UIColor orangeColor];
    label1.textColor = [UIColor whiteColor];
    label1.text = @"视图的层级关系";
    [_topImageView addSubview:label1];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.topImageView.frame) - 30, CGRectGetWidth(self.topImageView.frame), 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"在ImageView中的位置";
    label.backgroundColor = [UIColor lightGrayColor];
    label.alpha = 0.5;
    
    
    [_topImageView addSubview:label];
    [self.tableView addSpringTableHeadView:self.topImageView];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.title = @"我要出借";
//    [[self.navigationController.navigationBar subviews] firstObject].alpha = 0;
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    self.navigationController.hidesBarsOnTap = true;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellidentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"test:%ld", (long)indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 200;
}


//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat minAlphaOffset = - 64;
//    CGFloat maxAlphaOffset = 64;
//    CGFloat offset = scrollView.contentOffset.y;
//    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
//    [UIView animateWithDuration:0.25 animations:^{
//        [self.navigationController.navigationBar.subviews firstObject].alpha = alpha;
//    }];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 49) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

-(UIImageView *)topImageView{
    if (_topImageView == nil) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.image = [UIImage imageNamed:@"005.jpg"];
        _topImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _topImageView;
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
