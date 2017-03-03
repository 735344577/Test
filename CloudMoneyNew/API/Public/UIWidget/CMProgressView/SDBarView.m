//
//  SDBarView.m
//  CloudMoneyNew
//
//  Created by nice on 2017/2/24.
//  Copyright © 2017年 dfyg. All rights reserved.
//

#import "SDBarView.h"

@interface SDBarView ()
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CAShapeLayer *whiteLayer;
@property (nonatomic, strong) CAShapeLayer *trackLayer;
@end

@implementation SDBarView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
        //默认5
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self initView];
}

- (void)initView
{
    self.lineWidth = CGRectGetWidth(self.frame);
    self.trackLayer = [CAShapeLayer layer];
    _trackLayer.frame = self.bounds;
    [self.layer addSublayer:_trackLayer];
    _trackLayer.fillColor = nil;
    _trackLayer.lineCap = kCALineCapButt;
    _trackLayer.lineJoin = kCALineJoinRound;
    _trackLayer.lineWidth = _lineWidth;
    [self setTrackPath];
    
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    _progressLayer.lineCap = kCALineCapButt;
    _progressLayer.lineWidth = _lineWidth;
    [_trackLayer addSublayer:_progressLayer];
}

- (void)setTrackFillColor:(UIColor *)trackFillColor
{
    _trackLayer.fillColor = trackFillColor.CGColor;
}

- (void)setTrackTintColor:(UIColor *)trackTintColor
{
    _trackLayer.strokeColor = trackTintColor.CGColor;
}

- (void)setProgressTintColor:(UIColor *)progressTintColor
{
    _progressLayer.strokeColor = progressTintColor.CGColor;
}

- (void)setLineWidth:(float)lineWidth
{
    _lineWidth = lineWidth;
    _trackLayer.lineWidth = _lineWidth;
    _progressLayer.lineWidth = _lineWidth;
    [self setTrackPath];
    [self setProgressPath];
}

- (void)setProgress:(float)progress
{
    _progress = progress;
    [self setProgressPath];
}

//设置线条路径
- (void)setTrackPath
{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(CGRectGetMinX(self.bounds), CGRectGetMaxY(self.bounds))];
    [path addLineToPoint:CGPointMake(CGRectGetMinX(self.bounds), CGRectGetHeight(self.bounds))];
    path.lineWidth = _lineWidth;
    path.lineCapStyle = kCGLineCapSquare;
    _trackLayer.path = path.CGPath;
}


//设置进度路径
- (void)setProgressPath
{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds))];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetHeight(self.bounds) * (1 - _progress))];
    path.lineCapStyle = kCGLineCapButt;
    [path setLineWidth:_lineWidth];
    [_progressTintColor setStroke];
    self.progressLayer.path = path.CGPath;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 0.75;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
    [_progressLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    _progressLayer.strokeEnd = 1.0;
}


@end
