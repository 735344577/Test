//
//  KLBannerView.m
//  AFNetworking
//
//  Created by nice on 16/8/18.
//  Copyright © 2016年 Haitao. All rights reserved.
//

#import "KLBannerView.h"
#import <AFNetworking/UIkit+AFNetworking.h>

static NSString * collCellIdentifier = @"KLBanner";
@interface KLBannerView ()<UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>
/*UICollectionView*/
@property (nonatomic, strong) UICollectionView * collectionView;
/*分页控制器*/
@property (nonatomic, strong) UIPageControl * pageControl;
/*背景图片*/
@property (nonatomic, strong) UIImageView * backgroundImageView;
/* 当前Index*/
@property (nonatomic, assign) NSInteger currentIndex;
/* count 数组count * n*/
@property (nonatomic, assign) NSInteger allCount;
/*layout*/
@property (nonatomic, strong) UICollectionViewFlowLayout * flowLayout;
/*描述文本Label*/
@property (nonatomic, strong) UILabel * describeLabel;
/*定时器*/
@property (nonatomic, strong) NSTimer * timer;
@end

@implementation KLBannerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCollectionView];
        [self setData];
        [self setupPageControl];
        [self setupTimer];
    }
    return self;
}

+ (instancetype)initWithFrame:(CGRect)frame
                    imageUrls:(NSArray *)imageUrls {
    KLBannerView * bannerView = [[KLBannerView alloc] initWithFrame:frame];
    bannerView.imageUrls = imageUrls;
    return bannerView;
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = layout;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[KLCollectionViewCell class] forCellWithReuseIdentifier:collCellIdentifier];
    [self addSubview:_collectionView];
}

- (void)setData {
    _timesecond = 2.0;
    _fontSize = 14.0;
    _textColor = [UIColor whiteColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _flowLayout.itemSize = self.frame.size;
    _collectionView.frame = self.bounds;
    if (_collectionView.contentOffset.x == 0 && _allCount) {
        NSInteger targetIndex = _allCount * 0.5;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    CGSize size = CGSizeZero;
    size = [_pageControl sizeForNumberOfPages:self.imageUrls.count];
    CGRect frame = CGRectMake(CGRectGetWidth(self.frame) - size.width - 5, CGRectGetHeight(self.frame) - 15, size.width, 15);
    _pageControl.frame = frame;
    if (self.backgroundImageView) {
        self.backgroundImageView.frame = self.bounds;
    }
}

#pragma -mark --CollectionView Delegate && DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _allCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    KLCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:collCellIdentifier forIndexPath:indexPath];
    NSInteger itemIndex = [self pageControlIndexWithCurrentCellIndex:indexPath.item];
    NSURL * imgUrl = [NSURL URLWithString:_imageUrls[itemIndex]];
    [cell.imgView setImageWithURL:imgUrl placeholderImage:_placeholderImage];
    if (_describes.count > itemIndex) {
        NSString * text = _describes[itemIndex];
        cell.text = text;
    } else {
        cell.text = nil;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_clickAction) {
        _clickAction([self pageControlIndexWithCurrentCellIndex:indexPath.item]);
    }
}

#pragma -mark --UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.imageUrls.count) return;
    NSInteger index = [self getCurrentIndex];
    NSInteger currentIndex = [self pageControlIndexWithCurrentCellIndex:index];
    _pageControl.currentPage = currentIndex;
    if (index == _allCount - 1) {
        index = _allCount * 0.5 - 1;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setupTimer];
}

- (void)automaticScroll {
    if (_allCount == 0) return;
    NSInteger currentIndex = [self getCurrentIndex];
    NSInteger targetIndex = currentIndex + 1;
    [self scrollToIndex:targetIndex];
}

- (void)scrollToIndex:(NSInteger)index {
    if (index >= _allCount) {
        index = _allCount * 0.5;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (NSInteger)getCurrentIndex {
    if (CGRectGetWidth(self.collectionView.frame) == 0 ||
        CGRectGetHeight(self.collectionView.frame) == 0) {
        return 0;
    }
    NSInteger index = 0;
    index = (_collectionView.contentOffset.x + _flowLayout.itemSize.width * 0.5) / _flowLayout.itemSize.width;
    return MAX(0, index);
}

- (NSInteger)pageControlIndexWithCurrentCellIndex:(NSInteger)index {
    return index % self.imageUrls.count;
}

- (void)setupTimer {
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:self.timesecond target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}


- (void)stopTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)setupPageControl {
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = self.imageUrls.count;
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    pageControl.userInteractionEnabled = NO;
    pageControl.currentPage = _currentIndex;
    [self addSubview:pageControl];
    _pageControl = pageControl;
}

#pragma -mark -- set
- (void)setImageUrls:(NSArray *)imageUrls {
    _imageUrls = imageUrls;
    if (_imageUrls.count <= 1) {
        _pageControl.hidden = YES;
        _allCount = _imageUrls.count;
    } else {
        _allCount = _imageUrls.count * 2;
        _pageControl.hidden = NO;
    }
    _pageControl.numberOfPages = _imageUrls.count;
    [_collectionView reloadData];
    [self setNeedsLayout];
}

- (void)setPlaceholderImage:(UIImage *)placeholderImage {
    _placeholderImage = placeholderImage;
    
    if (!self.backgroundImageView) {
        UIImageView *bgImageView = [UIImageView new];
        bgImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self insertSubview:bgImageView belowSubview:self.collectionView];
        self.backgroundImageView = bgImageView;
    }
    
    self.backgroundImageView.image = placeholderImage;
}

- (void)setFont:(UIFont *)font {
    _font = font;
}

- (void)setFontSize:(CGFloat)fontSize {
    _fontSize = fontSize;
}

- (void)setDescribes:(NSArray *)describes {
    _describes = describes;
}

@end

@interface KLCollectionViewCell ()
/* 描述文字*/
@property (nonatomic, strong) UILabel * textLabel;
/*蒙版*/
@property (nonatomic, strong) UIToolbar * toolBar;
@end

@implementation KLCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.toolBar];
        [self.toolBar addSubview:self.textLabel];
    }
    return self;
}

- (void)setText:(NSString *)text {
    _text = text;
    if (_text.length > 0) {
        _textLabel.text = _text;
//        _textLabel.hidden = NO;
        _toolBar.hidden = NO;
    } else {
        _textLabel.text = _text;
//        _textLabel.hidden = YES;
        _toolBar.hidden = YES;
    }
   
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakity(self);
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongity(self);
        make.edges.equalTo(self.contentView);
    }];
    
    [self.toolBar makeConstraints:^(MASConstraintMaker *make) {
        @strongity(self);
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(15);
    }];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongity(self);
        make.left.right.top.bottom.equalTo(self.toolBar);
    }];
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}

- (UIToolbar *)toolBar {
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        _toolBar.hidden = YES;
        _toolBar.barStyle = UIBarStyleDefault;
    }
    return _toolBar;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _textLabel.font = [UIFont systemFontOfSize:14];
//        _textLabel.hidden = YES;
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}
@end
