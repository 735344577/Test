//
//  UIView+Category.h
//  admin
//
//  Created by haitao on 15/9/21.
//  Copyright © 2015年 haitao. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)
@interface UIView (Category)
/**CALayer 的属性*/
/**设置圆角*/
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
/**设置边宽*/
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
/**设置边框线的颜色*/
@property (nonatomic, strong) IBInspectable UIColor * borderColor;
/**设置阴影的颜色*/
@property (nonatomic, strong) IBInspectable UIColor * shadowColor;
/**设置阴影透明度*/
@property (nonatomic, assign) IBInspectable CGFloat shadowOpacity;
/**设置阴影角度*/
@property (nonatomic, assign) IBInspectable CGFloat shadowRadius;
/**设置阴影偏移量*/
@property (nonatomic, assign) IBInspectable CGSize shadowOffset;

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;

@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;
@property(nonatomic) CGPoint origin;
@property(nonatomic) CGSize size;

@property(nonatomic,readonly) CGFloat screenX;
@property(nonatomic,readonly) CGFloat screenY;
@property(nonatomic,readonly) CGFloat screenViewX;
@property(nonatomic,readonly) CGFloat screenViewY;
@property(nonatomic,readonly) CGRect screenFrame;


- (void)removeAllSubviews;


+ (instancetype)viewWithFrame:(CGRect)frame color:(UIColor *)color;

+ (instancetype)viewWithFrame:(CGRect)frame bgColor:(NSString *)color;

+ (instancetype)viewWithNib;

//自定义圆角方法
- (void)cornerView:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;


/**
 Returns the visible alpha on screen, taking into account superview and window.
 */
@property (nonatomic, readonly) CGFloat visibleAlpha;

/**
 Converts a point from the receiver's coordinate system to that of the specified view or window.
 
 @param point A point specified in the local coordinate system (bounds) of the receiver.
 @param view  The view or window into whose coordinate system point is to be converted.
 If view is nil, this method instead converts to window base coordinates.
 @return The point converted to the coordinate system of view.
 */
- (CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(UIView *)view;

/**
 Converts a point from the coordinate system of a given view or window to that of the receiver.
 
 @param point A point specified in the local coordinate system (bounds) of view.
 @param view  The view or window with point in its coordinate system.
 If view is nil, this method instead converts from window base coordinates.
 @return The point converted to the local coordinate system (bounds) of the receiver.
 */
- (CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(UIView *)view;

/**
 Converts a rectangle from the receiver's coordinate system to that of another view or window.
 
 @param rect A rectangle specified in the local coordinate system (bounds) of the receiver.
 @param view The view or window that is the target of the conversion operation. If view is nil, this method instead converts to window base coordinates.
 @return The converted rectangle.
 */
- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(UIView *)view;

/**
 Converts a rectangle from the coordinate system of another view or window to that of the receiver.
 
 @param rect A rectangle specified in the local coordinate system (bounds) of view.
 @param view The view or window with rect in its coordinate system.
 If view is nil, this method instead converts from window base coordinates.
 @return The converted rectangle.
 */
- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(UIView *)view;
@end

@interface UIView (RoundedCorners)

-(void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius;

@end

@interface UIView (LaunchImage)
//LaunchImage在APP初始化完之后会立即消失并显示APP的界面 但是有的时候我们不希望它这么快就消失(比如有的人希望有个过渡效果 有的人希望等某些设置或者数据加载完之后再消失)
- (void)addLaunchImage;

@end
/**
 *  这个类目是为了可以在Xib和SB上设置layer的属性
 */
@interface UIView (CALayer)
/**
 Shortcut to set the view.layer's shadow
 
 @param color  Shadow Color
 @param offset Shadow offset
 @param radius Shadow radius
 */
- (void)setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;
@end

@interface UIView (KUIViewController)

@property (nonatomic, readonly) UIViewController * viewComtroller;
@end

/**
 *  截图相关
 */
@interface UIView (KSnapshot)
/**
 Create a snapshot image of the complete view hierarchy.
 */
- (UIImage *)snapshotImage;

/**
 Create a snapshot image of the complete view hierarchy.
 @discussion It's faster than "snapshotImage", but may cause screen updates.
 See -[UIView drawViewHierarchyInRect:afterScreenUpdates:] for more information.
 */
- (UIImage *)snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;

/**
 Create a snapshot PDF of the complete view hierarchy.
 */
- (NSData *)snapshotPDF;
@end
