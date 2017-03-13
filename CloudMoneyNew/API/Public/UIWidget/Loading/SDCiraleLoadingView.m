//
//  SDCiraleLoadingView.m
//  CloudMoneyNew
//
//  Created by nice on 2017/3/9.
//  Copyright © 2017年 dfyg. All rights reserved.
//

#import "SDCiraleLoadingView.h"

static CGFloat KShapeLayerMargin = 20.0;
static CGFloat KShapeLayerWidth  = 40.0;
static CGFloat KShapeLayerRadius = 20;
@interface SDCiraleLoadingView ()
/**bottomLayer*/
@property (nonatomic, strong) CAShapeLayer *bottomLayer;
/**londingLayer*/
@property (nonatomic, strong) CAShapeLayer *loadingLayer;
/**文字*/
@property (nonatomic, strong) UILabel *loadingLabel;

/**<#Description#>*/
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@end

@implementation SDCiraleLoadingView

+ (instancetype)ciraleView:(NSString *)text {
    return [[SDCiraleLoadingView alloc] initText:text];
}

- (instancetype)initText:(NSString *)text {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 80, 80);
        self.backgroundColor = [UIColor whiteColor];
        _bottomColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
        _loadingColor = [UIColor colorWithRed:0.984 green:0.153 blue:0.039 alpha:1.000];
        _lineWidth = 2.0;
        _text = text;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    /// 底部的灰色layer
    _bottomLayer = [CAShapeLayer layer];
    _bottomLayer.strokeColor = _bottomColor.CGColor;
    _bottomLayer.fillColor = [UIColor clearColor].CGColor;
    _bottomLayer.lineWidth = _lineWidth;
    CGRect rect = CGRectMake(KShapeLayerMargin, 10, KShapeLayerWidth, KShapeLayerWidth);
    _bottomLayer.path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:KShapeLayerRadius].CGPath;
    [self.layer addSublayer:_bottomLayer];
    /// 橘黄色的layer
    CAShapeLayer *ovalShapeLayer = [CAShapeLayer layer];
    ovalShapeLayer.strokeColor = _loadingColor.CGColor;
    ovalShapeLayer.fillColor = [UIColor clearColor].CGColor;
    ovalShapeLayer.lineWidth = _lineWidth;
    ovalShapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:KShapeLayerRadius].CGPath;
    [self.layer addSublayer:ovalShapeLayer];
    _loadingLayer = ovalShapeLayer;
    _loadingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _loadingLabel.text = _text;
    _loadingLabel.textAlignment = NSTextAlignmentCenter;
    _loadingLabel.font = [UIFont systemFontOfSize:13.0];
    _loadingLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_loadingLabel];
    
    
    _loadingLayer.strokeColor = [SDCiraleLoadingView gradientColor:@[(id)[UIColor blueColor].CGColor, (id)[UIColor clearColor].CGColor] size:self.frame.size].CGColor;
                                 
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UIView *superView = self.superview;
    if (superView) {
        self.center = CGPointMake(superView.center.x, superView.center.y - 50);
    }
    _loadingLabel.frame = CGRectMake(0, 60, self.frame.size.width, 15);
}

- (void)startAnimation {
    /// 起点动画
    CABasicAnimation * strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @(-1);
    strokeStartAnimation.toValue = @(1.0);
    /// 终点动画
    CABasicAnimation * strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(0.0);
    strokeEndAnimation.toValue = @(1.0);
    /// 组合动画
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[strokeStartAnimation, strokeEndAnimation];
    animationGroup.duration = 1.25;
    animationGroup.repeatCount = CGFLOAT_MAX;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    [_loadingLayer addAnimation:animationGroup forKey:nil];
//    _loadingLayer.lineDashPattern = @[@6, @3];
}

+ (UIImage *)imageWithlayer:(CALayer *)layer {
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, layer.isOpaque, 0);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}

+ (UIColor *)gradientColor:(NSArray *)colors size:(CGSize)size {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    gradientLayer.colors = colors;
    UIImage *image = [SDCiraleLoadingView imageWithlayer:gradientLayer];
    return [[UIColor alloc] initWithPatternImage:image];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
