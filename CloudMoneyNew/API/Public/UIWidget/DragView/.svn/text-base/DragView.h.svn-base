//
//  DragView.h
//  CloudMoneyNew
//
//  Created by nice on 15/11/6.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ROOT,
    CHILD,
} Level;

@interface DragView : UIView

@property (nonatomic, strong) UIImageView * imageView;


- (instancetype)initWithFrame:(CGRect)frame level:(Level)level clickBlock:(dispatch_block_t)clickBlock;

- (void)show;

- (void)hide;

@end
