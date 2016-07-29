//
//  ChangeValueLabel.m
//  CloudMoneyNew
//
//  Created by nice on 16/7/29.
//  Copyright © 2016年 dfyg. All rights reserved.
//

#import "ChangeValueLabel.h"

@interface ChangeValueLabel ()
@property (nonatomic, strong) CADisplayLink * displayLink;
@property (nonatomic, assign) double fromValue;

@property (nonatomic, assign) double toValue;//<#obj#>

@property (nonatomic, assign) NSTimeInterval startTime;
@property (nonatomic, assign) NSTimeInterval time;
@end

@implementation ChangeValueLabel

- (void)animationChangeValueFromValue:(double)fromValue toValue:(double)toValue{
    self.fromValue = fromValue;
    self.toValue = toValue;
    [self startLinkAnimation];
}


- (void)handleAnimation:(CADisplayLink *)link{
    static float DURATION = 1.25;
    NSTimeInterval now = CACurrentMediaTime();
    _time = now - _startTime;
    float dt = (_time) / DURATION;
    if (dt >= 1.0) {
        self.text = [NSString stringWithFormat:@"%.2f", _toValue];
        [self endLinkAnimation];
        return;
    }
    float current = (_toValue - _fromValue) * dt + _fromValue;
    self.text = [NSString stringWithFormat:@"%.2f", current];
}

- (void)startLinkAnimation{
    self.displayLink.paused = NO;
    _startTime = CACurrentMediaTime();
    self.text = [NSString stringWithFormat:@"%.2f", _fromValue];
}

- (void)endLinkAnimation{
    self.displayLink.paused = YES;
    [self.displayLink invalidate];
    self.displayLink = nil;
}

- (CADisplayLink *)displayLink{
    if (!_displayLink) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleAnimation:)];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        _displayLink.paused = YES;
    }
    return _displayLink;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
