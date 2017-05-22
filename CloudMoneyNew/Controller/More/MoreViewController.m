//
//  MoreViewController.m
//  CloudMoneyNew
//
//  Created by nice on 15/9/22.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import "MoreViewController.h"
#import "KLLineLayout.h"

int const cellCount = 24;
@interface MoreViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
/**layout*/
@property (nonatomic, strong) KLLineLayout *layout;
/** */
@property (nonatomic, copy) NSArray *imgArr;
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更多";
    
//    [self.view addSubview:self.collectionView];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource Delegate
#pragma mark cell的数量
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return cellCount;
}

#pragma mark cell的视图
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"CollectionViewCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:[self randomFloat] green:[self randomFloat] blue:[self randomFloat] alpha:1.0];
//    collectionViewCell.layer.cornerRadius = 6.0f;
//    
//    collectionViewCell.image.image = [self.imgArr objectAtIndex:indexPath.row];
//    collectionViewCell.title.text = [[NSString alloc] initWithFormat:@"图片%d",indexPath.row];
    return cell;
}

- (CGFloat)randomFloat {
    float num = (arc4random() % 255) / 255.0;
    return num;
}

#pragma mark cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(120, 80);
}

#pragma mark cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击图片%d",indexPath.row);
}

//图片懒加载
-(NSArray*)imgArr{
    if (!_imgArr) {
        NSMutableArray *muArr = [NSMutableArray array];
        for (int i = 0; i < cellCount; i++) {
            NSString *month = [NSString stringWithFormat:@"%d月份",i];
            [muArr addObject:month];
        }
        _imgArr = muArr;
    }
    return _imgArr;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150) collectionViewLayout:self.layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
        collectionView.backgroundColor = [UIColor whiteColor];
        [collectionView setContentInset:UIEdgeInsetsMake(0, ScreenWidth / 2 - 60, 0, (ScreenWidth - 120)/2 + 60)];
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (KLLineLayout *)layout {
    if (!_layout) {
        _layout = [[KLLineLayout alloc] init];
    }
    return _layout;
}

//AVCaptureSession
/*
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    CVImageBufferRef ref = CMSampleBufferGetImageBuffer(sampleBuffer);
    CIImage* ciImage = [[CIImage alloc]initWithCVPixelBuffer:ref];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:ciImage fromRect:[ciImage extent]];
    UIImage * image = [[UIImage alloc]initWithCGImage:cgImage];
    CGImageRelease(cgImage);
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
