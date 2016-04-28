//
//  UITableView+Category.m
//  CloudMoneyNew
//
//  Created by nice on 15/11/16.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import "UITableView+Category.h"
#import <objc/runtime.h>
@implementation UITableView (Category)

- (void)registerClass:(Class)cellClass{
    [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerNib:(Class)cellClass{
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

@end


@implementation UITableView (EmptyData)

- (void)tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount
{
    if (rowCount == 0) {
        // Display a message when the table is empty
        // 没有数据的时候，UILabel的显示样式
        UILabel *messageLabel = [UILabel new];
        
        messageLabel.text = message;
        messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        messageLabel.textColor = [UIColor lightGrayColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [messageLabel sizeToFit];
        
        self.backgroundView = messageLabel;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}

@end

static char * SpringTableHeadView = "SpringTableHeadView";
static char * kSpringTableHeadViewHeight = "kSpringTableHeadViewHeight";
@implementation UITableView (SpringTableHeadView)

- (void)setSpringHeadView:(UIView *)SpringHeadView{
    objc_setAssociatedObject(self, &SpringTableHeadView, SpringHeadView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)SpringHeadView{
    return objc_getAssociatedObject(self, &SpringTableHeadView);
}

- (void)setSpringHeadViewHeight:(CGFloat)SpringHeadViewHeight{
    objc_setAssociatedObject(self, &kSpringTableHeadViewHeight, @(SpringHeadViewHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)SpringHeadViewHeight{
    return [objc_getAssociatedObject(self, &kSpringTableHeadViewHeight) floatValue];
}

- (void)addSpringTableHeadView:(UIView *)view{
    if ([view isKindOfClass:[UIImageView class]]) {
        view.clipsToBounds = YES;
    }
    UIView * newView = [[UIView alloc] initWithFrame:view.bounds];
    [newView addSubview:view];
    for (UIView * subView in view.subviews) {
        [newView addSubview:subView];
    }
    [view removeAllSubviews];
    self.tableHeaderView = newView;
    self.SpringHeadView = view;
    self.SpringHeadViewHeight = CGRectGetHeight(view.frame);
    //kVO监听scrollView的滚动
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self scrollViewDidScroll:self];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0) {
        return ;
    }
    //防止height小于0
    if (self.SpringHeadViewHeight - offsetY < 0) {
        return;
    }
    //如果不使用约束的话，图片的y值要上移offsetY,同时height也要增加offsetY
    CGFloat x = self.SpringHeadView.origin.x;
    CGFloat y = offsetY;
    CGFloat width = self.SpringHeadView.size.width;
    CGFloat height = self.SpringHeadViewHeight - offsetY;
    self.SpringHeadView.frame = CGRectMake(x, y, width, height);
}

@end

@interface zoomHeaderView ()

@end

@implementation zoomHeaderView



@end


