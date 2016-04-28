//
//  UIImageView+Category.m
//  admin
//
//  Created by haitao on 15/9/21.
//  Copyright © 2015年 haitao. All rights reserved.
//

#import "UIImageView+Category.h"

@implementation UIImageView (Category)
+ (instancetype)imageViewWithFrame:(CGRect)frame image:(UIImage *)image
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    return imageView;
}

+ (instancetype)imageViewWithFrame:(CGRect)frame img:(NSString *)img
{
    return [self imageViewWithFrame:frame image:[UIImage imageNamed:img]];
}
@end

@implementation UIImageView (Animation)

- (void)rotate360DegreeWithImageView{
    CABasicAnimation * rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];//旋转角度
    rotationAnimation.duration = 2;//旋转周期
    rotationAnimation.cumulative = YES;//旋转累加角度
    rotationAnimation.repeatCount = 100000;//旋转次数
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopRotate{
    [self.layer removeAllAnimations];
}

@end
