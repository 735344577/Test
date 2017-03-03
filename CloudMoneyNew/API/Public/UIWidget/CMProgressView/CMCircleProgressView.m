//
//  CMCircleProgressView.m
//  CloudMoneyNew
//
//  Created by nice on 15/10/8.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import "CMCircleProgressView.h"

@interface CMCircleProgressView (){
    CAShapeLayer *_trackLayer;
    UIBezierPath *_trackPath;
    CAShapeLayer *_progressLayer;
    UIBezierPath *_progressPath;
    NSTimeInterval _lastTime;
    NSTimeInterval _time;
}
/*CADisplayLink*/
@property (nonatomic, strong) CADisplayLink * displaylink;
/*进度*/
@property (nonatomic, strong) UILabel * progressLabel;
/*状态*/
@property (nonatomic, strong) UILabel * stateLabel;
/**是否动画*/
@property (nonatomic, assign) BOOL isAnimation;
@end

@implementation CMCircleProgressView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addSubview:self.progressLabel];
        [self addSubview:self.stateLabel];
        [_progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(13);
            make.centerX.equalTo(self);
        }];
        
        [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-8);
            make.centerX.equalTo(self);
        }];
        //默认5
        self.lineWidth = 2;
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _trackLayer = [CAShapeLayer new];
    [self.layer addSublayer:_trackLayer];
    _trackLayer.fillColor = nil;
    _trackLayer.frame = self.bounds;
    
    _progressLayer = [CAShapeLayer new];
    [self.layer addSublayer:_progressLayer];
    _progressLayer.fillColor = nil;
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.frame = self.bounds;

}

- (void)setTrack
{
    _trackPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2) radius:(self.bounds.size.width - _lineWidth)/ 2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];;
    _trackLayer.path = _trackPath.CGPath;
}

- (void)setProgress
{
    _progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2) radius:(self.bounds.size.width - _lineWidth)/ 2 startAngle:- M_PI_2 endAngle:(M_PI * 2) * _progress - M_PI_2 clockwise:YES];
    _progressLayer.path = _progressPath.CGPath;

    if (_isAnimation) {
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = 0.75;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnimation.autoreverses = NO;
        [_progressLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        _progressLayer.strokeEnd = 1.0;
    }
}

- (void)setProgress:(float)progress animation:(BOOL)animation {
    _isAnimation = animation;
    _progress = progress;
    _progressLabel.text = [NSString stringWithFormat:@"%.2f%%", progress * 100];
//    if (_isAnimation) {
//        [self startAnimation];
//    } else {
//        [self setProgress];
//    }
    [self setProgress];
}


- (void)setLineWidth:(float)lineWidth
{
    _lineWidth = lineWidth;
    _trackLayer.lineWidth = _lineWidth;
    _progressLayer.lineWidth = _lineWidth;
    
    [self setTrack];
    [self setProgress];
}

- (void)setTrackTintColor:(UIColor *)trackTintColor
{
    _trackLayer.strokeColor = trackTintColor.CGColor;
}

- (void)setProgressTintColor:(UIColor *)progressTintColor
{
    _progressLayer.strokeColor = progressTintColor.CGColor;
}

- (void)setProgress:(float)progress
{
    if (progress >= 1.0) {
        progress = 1.0;
        _progressTintColor = _trackTintColor;
    }
    _progress = progress;
    _progressLabel.text = [NSString stringWithFormat:@"%.2f%%", progress * 100];
//    if (_isAnimation) {
//        [self startAnimation];
//    }
    [self setProgress];
}

- (void)setState:(NSString *)state {
    _stateLabel.text = state;
}

- (void)setTextColor:(UIColor *)textColor {
    _stateLabel.textColor = textColor;
    _progressLabel.textColor = textColor;
}

- (void)displayAction:(CADisplayLink *)link {
    NSTimeInterval now = CACurrentMediaTime();
    _time = now - _lastTime;
    float dt = _time / 0.5;
    
    CGFloat progress = dt * _progress;
    if (dt >= 1.0) {
        _progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2) radius:(self.bounds.size.width - _lineWidth)/ 2 startAngle:- M_PI_2 endAngle:(M_PI * 2) * _progress - M_PI_2 clockwise:YES];
        _progressLayer.path = _progressPath.CGPath;
        [self endAnimation];
        return ;
    } else {
        _progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2)radius:(self.bounds.size.width - _lineWidth)/ 2 startAngle:- M_PI_2 endAngle:(M_PI * 2) * progress - M_PI_2 clockwise:YES];
        _progressLayer.path = _progressPath.CGPath;
    }
}

- (void)startAnimation {
    _lastTime = CACurrentMediaTime();
    self.displaylink.paused = NO;
}

- (void)endAnimation {
    _displaylink.paused = YES;
    [_displaylink invalidate];
    [_displaylink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    _displaylink = nil;
}

- (CADisplayLink *)displaylink {
    if (!_displaylink) {
        _displaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayAction:)];
        [_displaylink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        _displaylink.paused = YES;
    }
    return _displaylink;
}

- (UILabel *)progressLabel {
    if (!_progressLabel) {
        _progressLabel = [UILabel new];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.textColor = [UIColor colorWithHexString:@"#FC712E"];
        _progressLabel.font = [UIFont systemFontOfSize:12];
    }
    return _progressLabel;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [UILabel new];
        _stateLabel.textColor = [UIColor colorWithHexString:@"#FC712E"];
        _stateLabel.font = [UIFont systemFontOfSize:11];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _stateLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
