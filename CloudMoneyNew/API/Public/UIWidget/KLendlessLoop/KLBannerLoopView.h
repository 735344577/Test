//
//  KLendlessLoopView.h
//  CloudMoneyNew
//
//  Created by nice on 16/8/17.
//  Copyright © 2016年 dfyg. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PositionDefault,                //默认  == PositionBottomRight
    PositionHide,
    PositionTopLeft,
    PositionTopCenter,
    PositionTopRight,
    PositionBottomLeft,
    PositionBottomCenter,
    PositionBottomRight,
} PageControlPosition;

@interface KLBannerLoopView : UIView
/*输入图片数组*/
@property (nonatomic, strong) NSArray * imageArray;

/*图片描述*/
@property (nonatomic, strong) NSArray * textArray;
/* 切换时间*/
@property (nonatomic, assign) NSTimeInterval time;
/* 指示器位置*/
@property (nonatomic, assign) PageControlPosition position;//
/* 点击事件*/
@property (nonatomic, copy) void (^ clickBlock)(NSInteger index);
/**
 *  @brief 根据图片数组和frane创建视图
 *
 *  @param frame      frame
 *  @param imageArray imageArray
 */
- (instancetype)initWithFrame:(CGRect)frame
                   imageArray:(NSArray *)imageArray;
/**
 *  @brief 根据图片数组和点击事件创建视图
 *
 *  @param imageArray imageArray
 *  @param imageClick 点击时间
 */
- (instancetype)initWithImageArray:(NSArray *)imageArray
                        imageClick:(void (^)(NSInteger index))imageClick;

/**
 *  @brief 根据图片数组和文字说明数组创建视图
 *
 *  @param imageArray imageArray
 *  @param textArray  textArray
 */
+ (instancetype)viewWithImageArray:(NSArray *)imageArray
                         textArray:(NSArray *)textArray;




- (void)setpageColor:(UIColor *)pageColor
        currentColor:(UIColor *)currentColor;

- (void)setPageImage:(UIImage *)image
    currentPageImage:(UIImage *)currentImage;

- (void)setDescribeTextColor:(UIColor *)textColor
                        font:(UIFont *)font
                     bgColor:(UIColor *)bgColor;




@end
