//
//  KLPopView.h
//  CloudMoneyNew
//
//  Created by nice on 16/6/2.
//  Copyright © 2016年 dfyg. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    XTTypeOfUpLeft,     //上左
    XTTypeOfUpCenter,   //上中
    XTTypeOfUpRight,    //上右
    
    XTTypeOfDownLeft,   //下左
    XTTypeOfDownCenter, //下中
    XTTypeOfDownRight,  //下右
    
    XTTypeOfLeftUp,     //左上
    XTTypeOfLeftCenter, //左中
    XTTypeOfLeftDown,   //左下
    
    XTTypeOfRightUp,    //右上
    XTTypeOfRightCenter,//右中
    XTTypeOfRightDown,  //右下
} XTDirectionType;

typedef void(^SelectBlock)(NSInteger index);

@protocol selectIndexPathDelegate <NSObject>

- (void)selectIndexPathRow:(NSInteger)index;

@end

@interface KLPopView : UIView
/**
 *  @brief titles
 */
@property (nonatomic, strong) NSArray * dataArray;
/**
 *  @brief images
 */
@property (nonatomic, strong) NSArray * images;
/**
 *  @brief height
 */
@property (nonatomic, assign) CGFloat row_height;
/**
 *  @brief 字体大小     使用系统字体
 */
@property (nonatomic, assign) CGFloat fontSize;
/**
 *  @brief 字体颜色     默认白色
 */
@property (nonatomic, strong) UIColor * titleTextColor;
/**
 *  @brief 代理方法
 */
@property (nonatomic, assign) id<selectIndexPathDelegate> delegate;
/**
 *  @brief block方法  实现block方法这代理不会调用  注:（block的优先级高于代理）
 */
@property (nonatomic, copy) SelectBlock selectBlock;

/**
 *  @brief 初始化PopView
 *
 *  @param origin 显示的箭头位置
 *  @param width  popView宽
 *  @param height popView的高
 *  @param type   方向
 *  @param color  背景色  默认黑灰色
 */
- (instancetype)initWithOrigin:(CGPoint)origin
                         width:(CGFloat)width
                        height:(CGFloat)height
                          Type:(XTDirectionType)type
                         color:(UIColor *)color;
/**
 *  @brief 调用通过动画展示popView
 */
- (void)popView;

@end
