//
//  WHAnimation.m
//  CloudMoneyNew
//
//  Created by nice on 16/5/11.
//  Copyright © 2016年 dfyg. All rights reserved.
//

#import "WHAnimation.h"

@implementation WHAnimation

+ (CALayer *)replicatorLayer_Circle{
    CAShapeLayer * shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(0, 0, 50, 50);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 50, 50)].CGPath;
    shape.fillColor = [UIColor redColor].CGColor;
    shape.opacity = 0.0;
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[[WHAnimation alphaAnimation], [WHAnimation scaleAnimation]];
    animationGroup.duration = 3.0;
    animationGroup.autoreverses = NO;
    animationGroup.repeatCount = HUGE;
    [shape addAnimation:animationGroup forKey:@"animationGroup"];
    CAReplicatorLayer * replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(10, 10, 50, 50);
    replicatorLayer.instanceDelay = 0.5;
    replicatorLayer.instanceCount = 6;
    [replicatorLayer addSublayer:shape];
    return replicatorLayer;
}

+ (CALayer *)replicatorLayer_Wave{
    CGFloat between = 5.0;
    CGFloat radius = (55 - 2 * between) / 3;
    CAShapeLayer * shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(0, (55 - radius) / 2, radius, radius);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shape.fillColor = [UIColor redColor].CGColor;
    [shape addAnimation:[WHAnimation scaleAnimation1] forKey:@"scaleAnimation"];
    CAReplicatorLayer * replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(10, 10, 55, 55);
    replicatorLayer.instanceDelay = 0.3;
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(between * 2 + radius, 0, 0);
    [replicatorLayer addSublayer:shape];
    return replicatorLayer;
}

+ (CALayer *)replicatorLayer_Triangle{
    CGFloat radius = 60 / 4;
    CGFloat transX = 60 - radius;
    CAShapeLayer * shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(0, 0, radius, radius);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shape.strokeColor = [UIColor redColor].CGColor;
    shape.fillColor = [UIColor redColor].CGColor;
    shape.lineWidth = 1;
    [shape addAnimation:[WHAnimation rotationAnimation:transX] forKey:@"rotateAnimation"];
    CAReplicatorLayer * replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(10, 10, radius, radius);
    replicatorLayer.instanceDelay = 0.0;
    replicatorLayer.instanceCount = 3;
    CATransform3D trans3D = CATransform3DIdentity;
    trans3D = CATransform3DTranslate(trans3D, transX, 0, 0);
    trans3D = CATransform3DRotate(trans3D, 120 * M_PI / 180.0, 0.0, 0.0, 1.0);
    replicatorLayer.instanceTransform = trans3D;
    [replicatorLayer addSublayer:shape];
    return replicatorLayer;
}

+ (CALayer *)replicatorLayer_Grid{
    NSInteger column = 3;
    CGFloat between = 5.0;
    CGFloat radius = (15 - between * (column - 1) / column);
    CAShapeLayer * shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(5, 5, radius, radius);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shape.fillColor = [UIColor redColor].CGColor;
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[[WHAnimation scaleAnimation1], [WHAnimation alphaAnimation]];
    animationGroup.duration = 1.5;
    animationGroup.autoreverses = YES;
    animationGroup.repeatCount = HUGE;
    [shape addAnimation:animationGroup forKey:@"groupAnimation"];
    
    CAReplicatorLayer *replicatorLayerX = [CAReplicatorLayer layer];
    replicatorLayerX.frame = CGRectMake(5, 5, 15, 15);
    replicatorLayerX.instanceDelay = 0.3;
    replicatorLayerX.instanceCount = column;
    replicatorLayerX.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, radius + between, 0, 0);
    [replicatorLayerX addSublayer:shape];
    
    CAReplicatorLayer * replicatorLayerY = [CAReplicatorLayer layer];
    replicatorLayerY.frame = CGRectMake(5, 5, 15, 15);
    replicatorLayerY.instanceDelay = 0.3;
    replicatorLayerY.instanceCount = column;
    replicatorLayerY.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, 0, between + radius, 0);
    [replicatorLayerY addSublayer:replicatorLayerX];
    return replicatorLayerY;
}



+ (CAReplicatorLayer *)replicatorLayer_upDown{
    CAShapeLayer * shape = [CAShapeLayer layer];
    shape.frame =  CGRectMake(10, 10, 5, 40);
    shape.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 5, 40) cornerRadius:2].CGPath;
    shape.fillColor = [UIColor redColor].CGColor;
    shape.borderColor = [UIColor redColor].CGColor;
    [shape addAnimation:[WHAnimation zoomAnimation] forKey:@"zoomAnimation"];
    CAReplicatorLayer * replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(0, 0, 40, 40);
    replicatorLayer.instanceDelay = 0.1;
    replicatorLayer.instanceCount = 5;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(10, 0, 0);
    [replicatorLayer addSublayer:shape];
    return replicatorLayer;
}

+ (CAReplicatorLayer *)replicatorLayer_upDown1{
    CAShapeLayer * shape = [CAShapeLayer layer];
    shape.frame =  CGRectMake(10, 10, 5, 40);
    shape.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 5, 40) cornerRadius:2].CGPath;
    shape.fillColor = [UIColor redColor].CGColor;
    shape.borderColor = [UIColor redColor].CGColor;
    [shape addAnimation:[WHAnimation zoomAnimation] forKey:@"zoomAnimation"];
    CAReplicatorLayer * replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(0, 0, 40, 40);
    replicatorLayer.instanceDelay = 0.5;
    replicatorLayer.instanceCount = 5;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(10, 0, 0);
    [replicatorLayer addSublayer:shape];
    return replicatorLayer;
}


+ (CAReplicatorLayer *)replicatorLayer_HUD{
    CAShapeLayer * shape = [CAShapeLayer layer];
    shape.bounds = CGRectMake(0, 0, 10.0, 10.0);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 10.0, 10.0)].CGPath;
    shape.position = CGPointMake(25.0, 10.0);
    shape.borderColor = [UIColor redColor].CGColor;
    shape.fillColor = [UIColor redColor].CGColor;
    shape.transform = CATransform3DScale(CATransform3DIdentity, 0.01, 0.01, 0.01);
    [shape addAnimation:[WHAnimation scaleAnimation2] forKey:@"scale2"];
    CAReplicatorLayer * repelicatorLayer = [CAReplicatorLayer layer];
    repelicatorLayer.frame = CGRectMake(0, 0, 80, 80);
    repelicatorLayer.instanceCount = 10;
    repelicatorLayer.instanceDelay = 0.1;
    CGFloat angle = 2 * M_PI / 10;
    repelicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0);
    [repelicatorLayer addSublayer:shape];
    return repelicatorLayer;
}

+ (CABasicAnimation *)alphaAnimation{
    CABasicAnimation * alpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alpha.fromValue = @(1.0);
    alpha.toValue = @(0.4);
    return alpha;
}

+ (CABasicAnimation *)scaleAnimation{
    CABasicAnimation * scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 0.0)];
    scale.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 1.0)];
    return scale;
}

+ (CABasicAnimation *)scaleAnimation1{
    CABasicAnimation * scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    scale.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 0.0)];
    scale.autoreverses = YES;
    scale.repeatCount = HUGE;
    scale.duration = 0.6;
    return scale;
}

+ (CABasicAnimation *)scaleAnimation3{
    CABasicAnimation * scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 1.0)];
    scale.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 0.2)];
    scale.autoreverses = YES;
    scale.repeatCount = HUGE;
    scale.duration = 0.6;
    return scale;
}

+ (CABasicAnimation *)scaleAnimation2{
    CABasicAnimation * scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.fromValue = @(1.0);
    scale.toValue = @(0.2);
    scale.duration = 1.0;
    scale.repeatCount = HUGE;
    return scale;
}

+ (CABasicAnimation *)angleAnimation{
    CABasicAnimation * scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D fromValue = CATransform3DRotate(CATransform3DIdentity, 0.0, 0.0, 0.0, 0.0);
    scale.fromValue = [NSValue valueWithCATransform3D:fromValue];
    CATransform3D toValue = CATransform3DTranslate(CATransform3DIdentity, 20, 0, 0);
    toValue = CATransform3DRotate(toValue, 120 * M_PI / 180.0, 0.0, 0.0, 1.0);
    scale.toValue = [NSValue valueWithCATransform3D:toValue];
    scale.autoreverses = YES;
    scale.repeatCount = HUGE;
    scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scale.duration = 0.6;
    return scale;
}

+ (CABasicAnimation *)rotationAnimation:(CGFloat)transX{
    CABasicAnimation * scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D fromValue = CATransform3DRotate(CATransform3DIdentity, 0.0, 0.0, 0.0, 0.0);
    scale.fromValue = [NSValue valueWithCATransform3D:fromValue];
    CATransform3D toValue = CATransform3DTranslate(CATransform3DIdentity, transX, 0, 0);
    toValue = CATransform3DRotate(toValue, 120 * M_PI / 180.0, 0.0, 0.0, 1.0);
    scale.toValue = [NSValue valueWithCATransform3D:toValue];
    scale.autoreverses = NO;
    scale.repeatCount = HUGE;
    scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scale.duration = 0.8;
    return scale;
}


+ (CABasicAnimation *)zoomAnimation{
    CABasicAnimation * zoom = [CABasicAnimation animationWithKeyPath:@"transform"];
    zoom.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1, 1, 0)];
    zoom.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1, 0.15, 0)];
    zoom.autoreverses = YES;
    zoom.duration = 0.5;
    zoom.repeatCount = HUGE;
    return zoom;
}

@end
