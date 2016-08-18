//
//  CMLineProgressView.m
//  CloudMoneyNew
//
//  Created by nice on 15/10/8.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import "CMLineProgressView.h"

@interface CMLineProgressView ()

@property (nonatomic, strong) CAShapeLayer * trackLayer;

@property (nonatomic, strong) CAShapeLayer * progressLayer;

@property (nonatomic, strong) CAShapeLayer * whiteLayer;

@end

@implementation CMLineProgressView
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
    self.lineWidth = CGRectGetHeight(self.frame);
    self.trackLayer = [CAShapeLayer layer];
    _trackLayer.frame = self.bounds;
    [self.layer addSublayer:_trackLayer];
    _trackLayer.fillColor = nil;
    _trackLayer.lineCap = kCALineCapRound;
    _trackLayer.lineJoin = kCALineJoinRound;
    _trackLayer.lineWidth = _lineWidth;
    [self setTrackPath];
    
    self.whiteLayer = [CAShapeLayer layer];
    _whiteLayer.frame = self.bounds;
    [_trackLayer addSublayer:_whiteLayer];
    _whiteLayer.fillColor = [UIColor whiteColor].CGColor;
    _whiteLayer.lineCap = kCALineCapRound;
    _whiteLayer.lineWidth = _lineWidth - 1;
    [self setWhitePath];
    _whiteLayer.strokeColor = [UIColor whiteColor].CGColor;
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = _trackLayer.bounds;
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    _progressLayer.lineCap = kCALineCapRound;
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

- (void)setWhitePath
{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];
    _whiteLayer.path = path.CGPath;
    
}

//设置线条路径
- (void)setTrackPath
{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];
    _trackLayer.path = path.CGPath;
}

//设置进度路径
- (void)setProgressPath
{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame) * _progress, 0)];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinBevel;
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end



