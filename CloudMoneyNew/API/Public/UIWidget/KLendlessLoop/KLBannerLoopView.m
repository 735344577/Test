//
//  KLendlessLoopView.m
//  CloudMoneyNew
//
//  Created by nice on 16/8/17.
//  Copyright © 2016年 dfyg. All rights reserved.
//

#import "KLBannerLoopView.h"
#import "UIKit+AFNetworking.h"
#define DEFAULTTIME   2

@interface KLBannerLoopView ()<UIScrollViewDelegate>
/*scrollView*/
@property (nonatomic, strong) UIScrollView * scrollView;
/*图片描述控件，默认在图片底部*/
@property (nonatomic, strong) UILabel * describeLabel;
/*分页控件*/
@property (nonatomic, strong) UIPageControl * pageControl;
/*当前显示图片视图*/
@property (nonatomic, strong) UIImageView * currentImgView;
/*将要显示的图片视图*/
@property (nonatomic, strong) UIImageView * otherImgView;
/* 当前索引*/
@property (nonatomic, assign) NSInteger currentIndex;
/* 下一个索引*/
@property (nonatomic, assign) NSInteger nextIndex;
/*定时器*/
@property (nonatomic, strong) NSTimer * timer;
@end

@implementation KLBannerLoopView

+ (instancetype)viewWithImageArray:(NSArray *)imageArray
                         textArray:(NSArray *)textArray {
    KLBannerLoopView * bannerView = [[self alloc] initWithFrame:CGRectZero imageArray:imageArray];
    bannerView.textArray = textArray;
    return bannerView;
}

- (instancetype)initWithFrame:(CGRect)frame
                   imageArray:(NSArray *)imageArray {
    if (self = [super initWithFrame:frame]) {
        self.imageArray = imageArray;
    }
    return self;
}

- (instancetype)initWithImageArray:(NSArray *)imageArray
                        imageClick:(void (^)(NSInteger))imageClick {
    if (self = [self initWithFrame:CGRectZero imageArray:imageArray]) {
        self.imageArray = imageArray;
        self.clickBlock = imageClick;
    }
    return self;
}

- (void)setpageColor:(UIColor *)pageColor
        currentColor:(UIColor *)currentColor {
    self.pageControl.pageIndicatorTintColor = pageColor;
    self.pageControl.currentPageIndicatorTintColor = currentColor;
}

- (void)setPageImage:(UIImage *)image
    currentPageImage:(UIImage *)currentImage {
    if (!image || !currentImage) return;
    [self.pageControl setValue:currentImage forKey:@"_currentPageImage"];
    [self.pageControl setValue:image forKey:@"_pageImage"];
}

- (void)setDescribeTextColor:(UIColor *)textColor
                        font:(UIFont *)font
                     bgColor:(UIColor *)bgColor {
    if (textColor) self.describeLabel.textColor = textColor;
    if (font) self.describeLabel.font = font;
    if (bgColor) self.describeLabel.backgroundColor = bgColor;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self addSubview:self.scrollView];
    [self addSubview:self.describeLabel];
    [self addSubview:self.pageControl];
}

- (void)changeCurrentPageWithOffsetX:(CGFloat)offsetX {
    if (offsetX < self.scrollView.frame.size.width * 1) {
        NSInteger index = self.currentIndex - 1;
        if (index < 0) index = _imageArray.count - 1;
        _pageControl.currentPage = index;
    } else if (offsetX > self.scrollView.frame.size.width * 2) {
        _pageControl.currentPage = (self.currentIndex + 1) % self.imageArray.count;
    } else {
        _pageControl.currentPage = self.currentIndex;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (CGSizeEqualToSize(CGSizeZero, scrollView.contentSize)) return;
    CGFloat offsetX = scrollView.contentOffset.x;
//    [self changeCurrentPageWithOffsetX:offsetX];
    if (offsetX > self.scrollView.frame.size.width * 1) {
        self.otherImgView.frame = CGRectMake(CGRectGetMaxX(self.currentImgView.frame), 0, ScreenWidth, scrollView.frame.size.height);
        self.nextIndex = (self.currentIndex + 1) % self.imageArray.count;
        
        //大于等于2倍的宽表示已经到最后一个范围上（即第三个）这时候正在向第四和滑动，但第三个已经是最后一个了，所以调整scrollView显示位置
        if (offsetX >= scrollView.frame.size.width * 2) [self changeToNext];
    } else if (offsetX < self.scrollView.frame.size.width * 1) {
        self.otherImgView.frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height);
        self.nextIndex = self.currentIndex - 1;
        if (self.nextIndex < 0) self.nextIndex = self.imageArray.count - 1;
        if (offsetX <= scrollView.frame.size.width * 0) [self changeToNext];
    }
    [self.otherImgView setImageWithURL:[NSURL URLWithString:_imageArray[_nextIndex]] placeholderImage:nil];
    
}

- (void)changeToNext {
    self.currentImgView.image = self.otherImgView.image;
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    self.currentIndex = _nextIndex;
    self.pageControl.currentPage = self.currentIndex;
    self.describeLabel.text = self.textArray[_currentIndex];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.scrollView.contentInset = UIEdgeInsetsZero;
    _scrollView.frame = self.bounds;
    _describeLabel.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - 10, CGRectGetWidth(self.bounds), 10);
    if (_imageArray.count > 1) {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 3, CGRectGetHeight(self.scrollView.frame));
        self.currentImgView.frame = CGRectMake(self.scrollView.frame.size.width, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0) animated:NO];
        [self startTimer];
    } else {
        self.scrollView.contentSize = CGSizeZero;
        self.scrollView.contentOffset = CGPointZero;
        self.currentImgView.frame = CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        [self stopTimer];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}

#pragma -mark 定时器相关
- (void)timerAction {
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.scrollView.bounds) * 2, 0) animated:YES];
}

- (void)startTimer {
    if (_imageArray.count <= 1) return;
    if (_timer) [self stopTimer];
    _timer = [NSTimer timerWithTimeInterval:_time > DEFAULTTIME ? _time : DEFAULTTIME target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

- (void)stopTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)setPosition:(PageControlPosition)position{
    _position = position;
    _pageControl.hidden = (_position == PositionHide) || (_imageArray.count == 1);
    if (_pageControl.hidden) return;
    CGSize size;
    size = [_pageControl sizeForNumberOfPages:_pageControl.numberOfPages];
    _pageControl.frame = CGRectMake(0, 0, size.width, size.height);
    CGFloat centerY = self.scrollView.frame.size.height - size.height * 0.5 - 5 - (_describeLabel.hidden ? 0 : 10);
    
    if (_position == PositionDefault || _position == PositionBottomCenter)
        _pageControl.center = CGPointMake(ScreenWidth * 0.5, centerY);
    else if (_position== PositionTopCenter)
        _pageControl.center = CGPointMake(ScreenWidth * 0.5, size.height * 0.5 + 5);
    else if (_position == PositionTopLeft)
        _pageControl.center = CGPointMake(size.width * 0.5 + 5, size.height * 0.5 + 5);
    else if (_position == PositionTopRight)
        _pageControl.center = CGPointMake(ScreenWidth - size.width * 0.5 - 10, size.height * 0.5 + 5);
    else if (_position == PositionBottomLeft)
        _pageControl.center = CGPointMake(size.width * 0.5 + 5, centerY);
    else
        _pageControl.center = CGPointMake(ScreenWidth - size.width * 0.5, centerY);
        
}

- (void)setImageArray:(NSArray *)imageArray{
    if (imageArray.count == 0) return;
    _imageArray = imageArray;
    //防止数组越界造成crash
    if (_currentIndex >= imageArray.count) _currentIndex = imageArray.count - 1;
    self.pageControl.numberOfPages = imageArray.count;
    self.describeLabel.text = _textArray[_currentIndex];
    [self.currentImgView setImageWithURL:[NSURL URLWithString:imageArray[_currentIndex]] placeholderImage:nil];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setTextArray:(NSArray *)textArray{
    _textArray = textArray;
    if (!_textArray.count) {
        _describeLabel.hidden = YES;
    } else {
        if (_textArray.count < _imageArray.count) {
            NSMutableArray * array = [NSMutableArray arrayWithArray:_textArray];
            for (NSInteger i = _textArray.count; i < _imageArray.count; i++) {
                [array addObject:@""];
            }
            _textArray = array;
        }
        _describeLabel.text = _textArray[_currentIndex];
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    if (_clickBlock) {
        _clickBlock(_currentIndex);
    }
}


- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:self.currentImgView];
        [_scrollView addSubview:self.otherImgView];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_scrollView addGestureRecognizer:tap];
    }
    return _scrollView;
}
- (UILabel *)describeLabel {
    if (_describeLabel == nil) {
        _describeLabel = [[UILabel alloc] init];
        _describeLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _describeLabel.textColor = [UIColor whiteColor];
        _describeLabel.textAlignment = NSTextAlignmentCenter;
        _describeLabel.font = [UIFont systemFontOfSize:13];
        _describeLabel.hidden = YES;
    }
    return _describeLabel;
}
- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}
- (UIImageView *)currentImgView {
    if (_currentImgView == nil) {
        _currentImgView = [[UIImageView alloc] init];
    }
    return _currentImgView;
}
- (UIImageView *)otherImgView {
    if (_otherImgView == nil) {
        _otherImgView = [[UIImageView alloc] init];
    }
    return _otherImgView;
}

@end
