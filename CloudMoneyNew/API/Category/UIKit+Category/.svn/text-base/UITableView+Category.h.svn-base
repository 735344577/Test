//
//  UITableView+Category.h
//  CloudMoneyNew
//
//  Created by nice on 15/11/16.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Category)

- (void)registerClass:(Class)cellClass;
- (void)registerNib:(Class)cellClass;

@end


@interface UITableView (EmptyData)

- (void)tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount;

@end

/**
 *  @brief 添加此方法不能
 */
@interface UITableView (SpringTableHeadView)

@property (nonatomic, weak) UIView * SpringHeadView;
@property (nonatomic, assign) CGFloat SpringHeadViewHeight;
- (void)addSpringTableHeadView:(UIView *)view;

@end

@interface zoomHeaderView : UIView

@property (nonatomic, strong) UIImageView * headerImageView;

@end
