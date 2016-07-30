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
    static float DURATION = 1.25;
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
            string = [NSString stringWithFormat:@"%.2f", _toValue];
            string = [self valueFormatWithValue:string formatter:formatter];
        }else{
            string = [formatter stringFromNumber:[NSNumber numberWithUnsignedInteger:(NSUInteger)_toValue]];
        }
        self.text = [NSString stringWithFormat:@"%@%@", _headerString, string];
        [self endLinkAnimation];
        return;
    }
    float current = (_toValue - _fromValue) * dt + _fromValue;
    if (_isDecimal) {
        string = [NSString stringWithFormat:@"%.2f", current];
        string = [self valueFormatWithValue:string formatter:formatter];
    }else{
        string = [formatter stringFromNumber:[NSNumber numberWithUnsignedInteger:(NSUInteger)current]];
    }
    self.text = [NSString stringWithFormat:@"%@%@", _headerString, string];
}

- (NSString *)valueFormatWithValue:(NSString *)strValue formatter:(NSNumberFormatter *)formatter{
    //字符串转为数组
    NSMutableArray * array = [strValue componentsSeparatedByString:@"."].mutableCopy;
    NSString * firstStr = [array firstObject];
    [array removeObject:firstStr];
    firstStr = [formatter stringFromNumber:[NSNumber numberWithUnsignedInteger:(NSUInteger)[firstStr integerValue]]];
    [array insertObject:firstStr atIndex:0];
    //数组转为字符串
    return [array componentsJoinedByString:@"."];
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
