//
//  KLWaveView.m
//  CloudMoneyNew
//
//  Created by nice on 2017/4/18.
//  Copyright © 2017年 dfyg. All rights reserved.
//

#import "KLWaveView.h"

@interface KLWaveView ()
/**定时器*/
@property (nonatomic, strong) CADisplayLink *displayLink;
/**水波颜色*/
@property (nonatomic, strong) UIColor *waveColor;
/**水波速度*/
@property (nonatomic, assign) float speed;
/**水面高度*/
@property (nonatomic, assign) float waveHeight;
/**<#Description#>*/
@property (nonatomic, assign) float waveCycle;
/**<#Description#>*/
@property (nonatomic, assign) float wave;
@end


@implementation KLWaveView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _speed = 3.0;
        _waveColor = [UIColor greenColor];
        _waveHeight = CGRectGetHeight(frame) / 2 + 20;
        _waveCycle = 1.4;
        _wave = 3.0;
        [self waveLink];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)waveLink {
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(doAni)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)doAni {
    
    if (_wave >= 1.5) {
        _wave -= 0.05;
    } else if (_wave <= 1.0){
        _wave += 0.05;
    }
    
    _waveCycle += 0.05;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    //画水
    CGContextSetLineWidth(context, 1);
    CGContextSetFillColorWithColor(context, [_waveColor CGColor]);
    float y = self.waveHeight;
    CGPathMoveToPoint(path, NULL, 0, y);
    for(float x = 0; x <= rect.size.width; x++){
        y = self.wave * sin(x / 180 * M_PI + 3 * self.waveCycle / M_PI ) * 5 + self.waveHeight;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    //左上到右下颜色填充
    CGPathAddLineToPoint(path, nil, CGRectGetWidth(rect), rect.size.height);
    //右上到左下颜色填充
    CGPathAddLineToPoint(path, nil, 0, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.waveHeight);
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
}


@end
