//
//  UIButton+Category.m
//  admin
//
//  Created by haitao on 15/9/21.
//  Copyright © 2015年 haitao. All rights reserved.
//

#import "UIButton+Category.h"
#import "UIKit+Category.h"
#import <objc/runtime.h>
@implementation UIButton (Category)

- (void)startWithTime:(NSInteger)timeLine countDownTitle:(NSString *)subTitle{
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = [UIColor colorWithHexString:@"#FF562F"];
                [self setTitle:@"重新获取" forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        } else {
            int allTime = (int)timeLine + 1;
            int seconds = timeOut % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = [UIColor colorWithHexString:@"#CCCCCC"];
                [self setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}


@end

NSString static* kAnimationType = @"kAnimationType";
NSString static* kAnimationColor = @"kAnimationColor";

@interface UIButton ()<CAAnimationDelegate>

@end

@implementation UIButton (animation)

- (void)setAnimationColor:(UIColor *)animationColor {
    objc_setAssociatedObject(self, &kAnimationColor, animationColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)animationColor {
    return objc_getAssociatedObject(self, &kAnimationColor);
}

- (void)setAnimationType:(KLAnimationType)animationType {
    objc_setAssociatedObject(self, &kAnimationType, @(animationType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (KLAnimationType)animationType {
    return [objc_getAssociatedObject(self, &kAnimationType) integerValue];
}

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [super sendAction:action to:target forEvent:event];
    if (self.animationType == KLAnimationInner ||
        self.animationType == KLAnimationOuter) {
        CGRect rect;
        CGFloat cordius = self.layer.cornerRadius;
        
        CGPoint pos = [self touchPoint:event];
        CGFloat width = CGRectGetWidth(self.frame);
        CGFloat height = CGRectGetHeight(self.frame);
        float smallerSize = MIN(width, height);
        float longgerSize = MAX(width, height);
        float scale = longgerSize / smallerSize + 0.5;
        
        switch (self.animationType) {
            case KLAnimationInner:
                cordius = smallerSize / 2;
                rect = CGRectMake(0, 0, cordius * 2, cordius * 2);
                break;
            case KLAnimationOuter:
                scale = 2.5;
                pos = CGPointMake(width / 2, height / 2);
                rect = CGRectMake(pos.x - width, pos.y - height, width, height);
                break;
            default:
                break;
        }
        CALayer * layer = [self animationLayerRect:rect radius:cordius position:pos];
        CAAnimationGroup * group = [self animationGroup:scale];
        [self.layer addSublayer:layer];
        [group setValue:layer forKey:@"animatedLayer"];
        [layer addAnimation:group forKey:@"buttonAnimation"];
        self.layer.masksToBounds = YES;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    CALayer * layer = [anim valueForKey:@"animatedLayer"];
    if (layer) {
        [layer removeFromSuperlayer];
    }
}

- (CGPoint)touchPoint:(UIEvent *)event {
    UITouch * touch = [event.allTouches anyObject];
    if (touch) {
        return [touch locationInView:self];
    } else {
        return CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2);
    }
}

- (CALayer *)animationLayerRect:(CGRect)rect
                         radius:(CGFloat)radius
                       position:(CGPoint)position {
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.lineWidth = 1;
    layer.position = position;
    layer.path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath;
    switch (self.animationType) {
        case KLAnimationInner:
            layer.fillColor = self.animationColor.CGColor;
            layer.bounds = CGRectMake(0, 0, radius * 2, radius * 2);
            break;
        case KLAnimationOuter:
            layer.strokeColor = self.animationColor.CGColor;
            layer.fillColor = [UIColor clearColor].CGColor;
            break;
        default:
            break;
    }
    return layer;
}

- (CAAnimationGroup *)animationGroup:(CGFloat)scale {
    CABasicAnimation * opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacity.fromValue = @(1);
    opacity.toValue = @(0);
    
    CABasicAnimation * scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, scale)];
    
    CAAnimationGroup * group = [CAAnimationGroup animation];
    group.animations = @[opacity, scaleAnim];
    group.duration = 0.35;
    group.delegate = self;
    group.fillMode = kCAFillModeBoth;
    group.removedOnCompletion = false;
    return group;
}

@end
