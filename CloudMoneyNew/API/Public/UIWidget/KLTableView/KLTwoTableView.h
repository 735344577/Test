//
//  KLTwoTableView.h
//  CloudMoneyNew
//
//  Created by nice on 16/8/23.
//  Copyright © 2016年 dfyg. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  @brief 右边的TableView是否分组
 */
typedef NS_ENUM(NSUInteger, RightTableViewStyle) {
    
    RightTableViewPlane,    //不分组
    
    RightTableViewGroup,    //分组
};

@interface KLTwoTableView : UIView

/*左侧TableView数据源*/
@property (nonatomic, strong) NSArray * leftDataSource;

/*右侧TableView数据源
 *   说明：若是 RightTableViewGroup 则为数组嵌套数组 [[],[],[]]
 */
@property (nonatomic, strong) NSArray * rightDataSource;
/* 右侧TableView样式*/
@property (nonatomic, assign) RightTableViewStyle rightStyle;

- (instancetype)initWithFrame:(CGRect)frame;



@end
