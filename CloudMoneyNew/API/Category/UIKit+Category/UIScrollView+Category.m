//
//  UIScrollView+Category.m
//  CloudMoneyNew
//
//  Created by nice on 15/12/2.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import "UIScrollView+Category.h"
#import <objc/runtime.h>
static char * UIScrollViewSpringHeadView = "UIScrollViewSpringHeadView";
static char * kTopViewHeight = "kTopViewHeight";
@interface UIScrollView ()
@property (nonatomic, assign) CGFloat topViewHeight;
@end

@implementation UIScrollView (Category)

@end

@implementation UIScrollView (SpringHeadView)

- (void)setTopView:(UIView *)topView
{
    [self willChangeValueForKey:@"SpringHeadView"];
    objc_setAssociatedObject(self, &UIScrollViewSpringHeadView, topView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"SpringHeadView"];
}

- (UIView *)topView
{
    return objc_getAssociatedObject(self, &UIScrollViewSpringHeadView);
}

- (void)setTopViewHeight:(CGFloat)topViewHeight{
    objc_setAssociatedObject(self, &kTopViewHeight, @(topViewHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)topViewHeight{
    return [objc_getAssociatedObject(self, &kTopViewHeight) floatValue];
}

- (void)addSpringHeadView:(UIView *)view
{
    self.contentInset = UIEdgeInsetsMake(view.bounds.size.height, 0, 0, 0);
    [self addSubview:view];
    view.frame = CGRectMake(0, -view.bounds.size.height, view.bounds.size.width, view.bounds.size.height);
    self.topView = view;
    self.topViewHeight = CGRectGetHeight(view.frame);
    //kVO监听scrollView的滚动
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self scrollViewDidScroll:self];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offy = scrollView.contentOffset.y;
    //防止height小于0
    if (CGRectGetHeight(self.topView.frame) - offy < 0) {
        return;
    }
    //如果不使用约束的话，图片的y值要上移offsetY,同时height也要增加offsetY
    CGFloat width = CGRectGetWidth(self.topView.frame);
    CGFloat height = self.topViewHeight;
    if (offy <= -self.topViewHeight) {
        if (offy + height <= -self.topViewHeight) {
            height = 0;
        }else{
            height = height * 2 + offy;
        }
        self.topView.frame = CGRectMake(0, offy, width, -offy);
    }
}

@end
