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
    self.lineWidth = 5;
    self.trackLayer = [CAShapeLayer layer];
    _trackLayer.frame = self.bounds;
    [self.layer addSublayer:_trackLayer];
    _trackLayer.fillColor = nil;
    _trackLayer.lineCap = kCALineCapRound;
    _trackLayer.lineWidth = _lineWidth;
    [self setTrackPath];
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = self.bounds;
    [self.layer addSublayer:_progressLayer];
    _progressLayer.fillColor = nil;
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.lineWidth = _lineWidth;
    
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
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];
    UIGraphicsBeginImageContext(self.frame.size);
    [path stroke];
    UIGraphicsEndImageContext();
    
    _trackLayer.path = path.CGPath;
}

//设置进度路径
- (void)setProgressPath
{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame) * _progress, 0)];
    [path setLineWidth:_lineWidth];
    [_progressTintColor setStroke];
    UIGraphicsBeginImageContext(self.frame.size);
    [path stroke];
    UIGraphicsEndImageContext();
    self.progressLayer.path = path.CGPath;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
