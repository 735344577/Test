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
#import "SDCiraleLoadingView.h"
#import "CMPersion.h"
#import "KLWaveView.h"
@interface HomeViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) ChangeValueLabel * ValueLabel;
/**<#Description#>*/
@property (nonatomic, strong) CMCircleProgressView * circleProgressView;
/**<#Description#>*/
@property (nonatomic, strong) NSThread *thread;
/**<#Description#>*/
@property (nonatomic, strong) UIScrollView *scrollView;
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
    CGFloat radius = 79;
    for (NSInteger loop = 0; loop < arr.count; loop++) {
        NSInteger col = loop % 4;
        NSInteger row = loop / 4;
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake((radius + 1) * col, (radius + 1) * row, radius, radius)];
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
//    [self.view addSubview:bannerView];
    
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
    
    KLWaveView *wave = [[KLWaveView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    [self.view addSubview:wave];
//    [self groupAsyncSerialTest];
//    [self groupAsyncConcurrentTest];
}

//算法
//二分法查找 非递归
int binarySearch1(int a[], int low, int high, int findNum) {
    while (low <= high) {
        int mid = (low + high) / 2;
        if (a[mid] < findNum) {
            low = mid + 1;
        } else if (a[mid] > findNum)
            high = mid - 1;
        else
            return mid;
    }
    return -1;
}


//冒泡排序
void bubble_sort(int a[], int n) {
    int tmp;
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (a[j] > a[j+1]) {
                tmp = a[j];
                a[j] = a[j+1];
                a[j+1] = tmp;
            }
        }
    }
}



//快速排序
void quickSort(int a[], int low, int high) {
    if (high <= low) {
        return;
    }
    int start = low;
    int end = high;
    int tmp = a[low];
    while (start < end) {
        while (start < end && tmp <= a[end]) {
            end--;
        }//找到第一个比a[low]数值大的位置start
        a[start] = a[end];
        while (start < end && tmp >= a[start]) {
            start++;
        }//找到第一个比a[low]数值小的位置end
        //进行到此，a[end] < a[low] < a[start],但是物理位置上还是low< start < end,因此接下来交换a[start]和a[end],于是[low,start]这个区间里面全部比a[low]小的，[end,hight]这个区间里面全部都是比a[low]大的
        a[end] = a[start];
    }
    a[start] = tmp;/*当在当组内找完一遍以后就把中间数key回归*/
    //此时以start分为2部分 左边的小于a[start] 右边部分 大于a[start]
    quickSort(a, low, start - 1);
    quickSort(a, start + 1, high);
}

//选择排序
void chooseSort(int a[]) {
    int n = sizeof(&a) / sizeof(int);;
    int min, tmp;
    for (int i = 0; i < n - 1; i++) {
        min = i;
        for (int j = i + 1; j < n; j++) {
            if (a[j] < a[min]) {
                min = j;
            }
        }
        if (min != i) {
            tmp = a[i];
            a[i] = a[min];
            a[min] = tmp;
        }
    }
}


//插入排序
void insertSort(int a[]) {
    int n = sizeof(&a) / sizeof(int);
    int j, tmp;
    for (int i = 0; i < n; i++) {
        tmp = a[i];
        j = i - 1;
        while (j >= 0 && a[j] > tmp) {
            a[j + 1] = a[j];
            j--;
        }
        a[j + 1] = tmp; //直到该手牌比抓到的牌小(或二者相等),将抓到的牌插入到该手牌右边(相等元素的相对次序未变,所以插入排序是稳定的)
    }
}

void binaryInsertSort(int a[]) {
    int n = sizeof(&a) / sizeof(int);
    int tmp, left, right, mid;
    for (int i = 1; i < n; i++) {
        tmp = a[i];
        left = 0;
        right = i - 1;
        while (left <= right) {
            mid = (left + right) / 2;
            if (a[mid] > tmp) {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
            for (int j = i - 1; j >= left; j--) {
                a[j + 1] = a[j];
            }
            a[left] = tmp;
        }
    }
}


//异步串行group
- (void)groupAsyncSerialTest {
    //创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.sccc", DISPATCH_QUEUE_SERIAL);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        [self doSomething:^() {
            NSLog(@"任务一");
        }];
    });
    dispatch_group_async(group, queue, ^{
        [self doSomething:^() {
            NSLog(@"任务二");
        }];
    });
    dispatch_group_async(group, queue, ^{
        [self doSomething:^() {
            NSLog(@"任务三");
        }];
    });
    dispatch_group_notify(group, queue, ^{
        NSLog(@"前面的任务已完成");
    });
}

//异步并行
- (void)groupAsyncConcurrentTest {
    //创建并行队列
    dispatch_queue_t queue = dispatch_queue_create("com.sccc", DISPATCH_QUEUE_CONCURRENT);
    queue = dispatch_get_global_queue(0, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        [self doSomething:^() {
            NSLog(@"任务一");
        }];
    });
    dispatch_group_async(group, queue, ^{
        [self doSomething:^() {
            NSLog(@"任务二");
        }];
    });
    dispatch_group_async(group, queue, ^{
        [self doSomething:^() {
            NSLog(@"任务三");
        }];
    });
    dispatch_group_notify(group, queue, ^{
        NSLog(@"前面的任务已完成");
    });
}

- (void)doSomething:(void (^)())handler {
    if (handler) {
        sleep(2);
        handler();
    }
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
    
//    [_circleProgressView setProgress:0 animation:NO];
//    [_circleProgressView setProgress:0.5 animation:YES];
    

    
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
    NSMutableArray *months = @[].mutableCopy;
    for (int i = 0; i < 12; i++) {
        NSDictionary *dic = @{@"progressColor": [UIColor redColor], @"progress": @(0.4 + i * 0.05), @"duration": @(0.75 + 0.05 * i)};
        NSArray *source = @[dic,
                                   @{@"progressColor": [UIColor blueColor], @"progress": @(0.3), @"duration": @(0.55)},
                                   @{@"progressColor": [UIColor orangeColor], @"progress": @(0.2), @"duration": @(0.25)}].mutableCopy;
        [dataSource addObject:source];
        [months addObject:[@(i + 1) stringValue]];
//        SDMutiBarView *barView = [SDMutiBarView mutiBarWith:source];//[[SDMutiBarView alloc] initWithFrame:CGRectZero];
//        [self.view addSubview:barView];
//        [barView makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.view).offset(65 + (15 + 5) * i);
//            make.width.equalTo(15);
//            make.height.equalTo(150);
//            make.top.equalTo(self.view).offset(250);
//        }];
//        [bars addObject:barView];
//        UILabel *label = [[UILabel alloc] init];
//        label.text = [NSString stringWithFormat:@"%@", @(i + 1)];
//        [self.view addSubview:label];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.font = [UIFont systemFontOfSize:10];
//        [label makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(barView.bottom).offset(5);
//            make.left.centerX.equalTo(barView);
//        }];
    }
//    SDMutiBarView *bar = bars[7];
//    bar.currentColor = [UIColor purpleColor];
//    UILabel *label = [[UILabel alloc] init];
//    label.text = @"10.5%";
//    label.textColor = [UIColor purpleColor];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.font = [UIFont systemFontOfSize:14.0];
//    [self.view addSubview:label];
//    [label makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(bar.bottom).offset(-135);
//        make.centerX.equalTo(bar);
//    }];
    
    
//    barView.progressTintColor = [UIColor colorWithHexString:@"#FC712E"];
//    barView.progress = 0.3;
//    barView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    
//    SDCiraleLoadingView *loadingView = [SDCiraleLoadingView ciraleView:@"正在加载..."];
//    [self.view addSubview:loadingView];
//    [loadingView startAnimation];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self testDemo1];
}

- (void)testDemo1
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"线程开始");
        //获取到当前线程
        self.thread = [NSThread currentThread];
        
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        //添加一个Port，同理为了防止runloop没事干直接退出
        [runloop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        
        //运行一个runloop，[NSDate distantFuture]：很久很久以后才让它失效
        [runloop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        
        NSLog(@"线程结束");
        
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //在我们开启的异步线程调用方法
        [self performSelector:@selector(recieveMsg) onThread:self.thread withObject:nil waitUntilDone:NO];
    });
}

- (void)recieveMsg
{
    NSLog(@"收到消息了，在这个线程：%@",[NSThread currentThread]);
    
    /*
     imageUrl
     imageUrl hash
     if 存在
     取出image
     else 
     网络请求
     请求结果
     成功 存储image 并和imageUrl hash关联
     
     */
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
