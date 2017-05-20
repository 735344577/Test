//
//  KLSnarView.h
//  Month
//
//  Created by haitao on 2017/5/20.
//  Copyright © 2017年 haitao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLSannerView : UIView

//数据源
@property (nonatomic, copy) NSArray *dataSource;

@end

@interface KLSannerCenterView : UIView

//年化收益率
@property (nonatomic, copy) NSString *rateYear;
@end
