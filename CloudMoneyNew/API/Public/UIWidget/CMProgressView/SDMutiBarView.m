//
//  SDMutiBarView.m
//  CloudMoneyNew
//
//  Created by haitao on 2017/3/10.
//  Copyright © 2017年 dfyg. All rights reserved.
//

#import "SDMutiBarView.h"

@interface SDMutiBarView ()<CAAnimationDelegate>
@property (nonatomic, strong) NSMutableArray *layers;
@property (nonatomic, strong) CAShapeLayer *trackerLayer;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign, readwrite) float textBottom;
@end

@implementation SDMutiBarView

+ (instancetype)mutiBarWith:(NSArray *)mutiArray {
    return [[SDMutiBarView alloc] initWithMutiDic:mutiArray];
}

- (instancetype)initWithMutiDic:(NSArray *)mutiArray {
    self = [super init];
    if (self) {
        _mutiArray = mutiArray;
        _layers = @[].mutableCopy;
        [self setLayers];
    }
    return self;
}

- (void)setLayers {
    _trackerLayer = [CAShapeLayer layer];
    _trackerLayer.strokeColor = [UIColor whiteColor].CGColor;
    _trackerLayer.fillColor = [UIColor clearColor].CGColor;
    _trackerLayer.lineCap = kCALineCapButt;
    _trackerLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:_trackerLayer];
    for (NSDictionary *mutiDic in _mutiArray) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        UIColor *strokeColor = mutiDic[@"progressColor"];
        layer.strokeColor = strokeColor.CGColor;
        layer.fillColor = [UIColor clearColor].CGColor;
        [_trackerLayer addSublayer:layer];
        [_layers addObject:layer];
    }
}

- (void)setCurrentColor:(UIColor *)currentColor {
    _currentColor = currentColor;
    for (int i = 1; i < _layers.count; i++) {
        CAShapeLayer *layer = _layers[i];
        [layer removeFromSuperlayer];
    }
    CAShapeLayer *layer = _layers[0];
    layer.strokeColor = currentColor.CGColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _lineWidth = CGRectGetWidth(self.bounds);
    _trackerLayer.lineWidth = _lineWidth;
    _trackerLayer.frame = self.bounds;
    for (CAShapeLayer *layer in _layers) {
        layer.lineWidth = _lineWidth;
        layer.frame = self.bounds;
    }
    [self setTrackPath];
    if (_currentColor) {
        [self setProgressPathWith:0];
    } else {
        for (int i = 0; i < _layers.count; i++) {
            [self setProgressPathWith:i];
        }
    }
    
}

- (void)setTrackPath {
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(CGRectGetMinX(self.bounds), CGRectGetMaxY(self.bounds))];
    [path addLineToPoint:CGPointMake(CGRectGetMinX(self.bounds), CGRectGetHeight(self.bounds))];
    path.lineWidth = _lineWidth;
    path.lineCapStyle = kCGLineCapSquare;
    _trackerLayer.path = path.CGPath;
}

- (void)setProgressPathWith:(NSInteger)index {
    CAShapeLayer *layer = _layers[index];
    NSDictionary *info = _mutiArray[index];
    float progress = [info[@"progress"] floatValue];
    float duration = [info[@"duration"] floatValue];
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds))];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetHeight(self.bounds) * (1 - progress))];
    path.lineCapStyle = kCGLineCapButt;
    [path setLineWidth:_lineWidth];
    layer.path = path.CGPath;
    
    if (_currentColor) {
        _textBottom = CGRectGetHeight(self.bounds) * (1 - progress) + 5;
    }
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = duration;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
    pathAnimation.delegate = self;
    [layer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    layer.strokeEnd = 1.0;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        
        if (_currentColor) {
            CAShapeLayer *layer = _layers[0];
            CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
            scaleAnimation.toValue = [NSNumber numberWithFloat:1.2];
            scaleAnimation.duration = 0.75f;
            scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            scaleAnimation.repeatCount = 2;
            scaleAnimation.autoreverses = YES;
            [layer addAnimation:scaleAnimation forKey:@"transform.scale"];
        }
        
    }
}


@end
