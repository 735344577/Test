//
//  KLSnarView.m
//  Month
//
//  Created by haitao on 2017/5/20.
//  Copyright © 2017年 haitao. All rights reserved.
//

#import "KLSannerView.h"
#import "KLSannerCell.h"
@interface KLSannerView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

//centerView
@property (nonatomic, strong) KLSannerCenterView *centerView;

@end

static NSString *const cellIdentifier = @"identifier";
static CGFloat itemWidth = 70.0;

@implementation KLSannerView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.collectionView];
    [self addSubview:self.centerView];
    [self.collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.centerY.equalTo(self);
        make.height.equalTo(60);
    }];
    
    self.centerView.userInteractionEnabled = NO;
    [self.centerView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(100);
        make.top.bottom.equalTo(self);
        make.center.equalTo(self);
    }];
    self.centerView.layer.cornerRadius = 4;
    self.centerView.layer.borderColor = [UIColor colorWithHexString:@"#F5F5F5"].CGColor;
    self.centerView.layer.borderWidth = 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KLSannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.month = [NSString stringWithFormat:@"%ld月", indexPath.item + 1];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float x = scrollView.contentOffset.x;
    float offsetX = (ScreenWidth - itemWidth) / 2;
    NSInteger index = (x + offsetX) / itemWidth;
    if (index <= 0) {
        index = 0;
    } else if (index > _dataSource.count - 1) {
        index = _dataSource.count - 1;
    }
    [self updateCenterView:index];
}

- (void)updateCenterView:(NSInteger)index {
    self.centerView.rateYear = [NSString stringWithFormat:@"%.2f%%", index * 0.5 + 5];
}

- (CGFloat)randomFloat {
    float num = arc4random() % 255 / 255.0;
    return num;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(itemWidth, 40);
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 60) collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = self.backgroundColor;
        [collectionView registerClass:[KLSannerCell class] forCellWithReuseIdentifier:cellIdentifier];
        _collectionView = collectionView;
        collectionView.contentInset = UIEdgeInsetsMake(0, ScreenWidth / 2 - itemWidth / 2, 0, ScreenWidth / 2 - itemWidth / 2);
    }
    return _collectionView;
}

- (KLSannerCenterView *)centerView {
    if (!_centerView) {
        KLSannerCenterView *centerView = [[KLSannerCenterView alloc] init];
        _centerView = centerView;
    }
    return _centerView;
}

@end

@interface KLSannerCenterView ()
//预期年化收益率
@property (nonatomic, strong) UILabel *rateYearLabel;
@end

@implementation KLSannerCenterView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    UILabel *rateYearLab = [[UILabel alloc] init];
    rateYearLab.text = @"预期年化收益率";
    rateYearLab.textAlignment = NSTextAlignmentCenter;
    rateYearLab.font = [UIFont systemFontOfSize:11.0];
    [self addSubview:rateYearLab];
    [rateYearLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(10);
    }];
    
    UILabel *rateYearLabel = [[UILabel alloc] init];
    rateYearLabel.textAlignment = NSTextAlignmentCenter;
    rateYearLabel.font = [UIFont systemFontOfSize:30.0];
    [self addSubview:rateYearLabel];
    _rateYearLabel = rateYearLabel;
    [rateYearLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.centerY.equalTo(self);
    }];
}

- (void)setRateYear:(NSString *)rateYear {
    _rateYear = rateYear;
    _rateYearLabel.text = rateYear;
}

@end
