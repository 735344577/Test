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

@property (nonatomic, assign) double toValue;

@property (nonatomic, assign) NSTimeInterval startTime;
@property (nonatomic, assign) NSTimeInterval time;

@property (nonatomic, assign) BOOL isDecimal;
@end

@implementation ChangeValueLabel

- (void)animationChangeValueFromValue:(double)fromValue toValue:(double)toValue{
    self.fromValue = fromValue;
    self.toValue = toValue;
    [self startLinkAnimation];
    _isDecimal = NO;
}

- (void)animationChangeValueFromValue:(double)fromValue toValue:(double)toValue decimal:(BOOL)decimal{
    self.fromValue = fromValue;
    self.toValue = toValue;
    [self startLinkAnimation];
    _isDecimal = decimal;
}

- (void)handleAnimation:(CADisplayLink *)link{
//    double vaule = fabs(_fromValue - _toValue) / 10000;
    static float DURATION = 0.75;
//    if (vaule >= 10)        //  10万以上
//        DURATION = 1.0;
//    else if (vaule >= 100)  //  100万以上
//        DURATION = 1.25;
//    else if (vaule >= 1000) //  1000万以上
//        DURATION = 1.35;
    NSTimeInterval now = CACurrentMediaTime();
    _time = now - _startTime;
    float dt = (_time) / DURATION;
    if (!_headerString) {
        _headerString = @"";
    }
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *string = nil;
    if (dt >= 1.0) {
        if (_isDecimal) {
            formatter.roundingMode = NSNumberFormatterRoundFloor;   //不四舍五入
            [formatter setPositiveFormat:@"#,###.##"];  //自定义数据格式
            formatter.maximumFractionDigits = 2;        //保留2位小数
            string = [formatter stringFromNumber:[NSNumber numberWithDouble:_toValue]];
        }else{
            string = [formatter stringFromNumber:[NSNumber numberWithUnsignedInteger:(NSUInteger)_toValue]];
        }
        self.text = [NSString stringWithFormat:@"%@%@", _headerString, string];
        [self endLinkAnimation];
        return;
    }
    double current = (_toValue - _fromValue) * dt + _fromValue;
    if (_isDecimal) {
        formatter.roundingMode = NSNumberFormatterRoundFloor;
        [formatter setPositiveFormat:@"#,###.##"];
        string = [formatter stringFromNumber:[NSNumber numberWithDouble:current]];
    }else{
        string = [formatter stringFromNumber:[NSNumber numberWithUnsignedInteger:(NSUInteger)current]];
    }
    self.text = [NSString stringWithFormat:@"%@%@", _headerString, string];
}

- (void)startLinkAnimation{
    self.displayLink.paused = NO;
    _startTime = CACurrentMediaTime();
    self.text = [NSString stringWithFormat:@"%.2f", _fromValue];
}

- (void)endLinkAnimation{
    self.displayLink.paused = YES;
    [self.displayLink invalidate];
    [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
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
