//
//  SDMutiBarView.h
//  CloudMoneyNew
//
//  Created by haitao on 2017/3/10.
//  Copyright © 2017年 dfyg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDMutiBarView : UIView
//形如 @[@{@"progressColor": [UIColor redColor], @"progress": @(0.2), @"duration": @(0.75)}]
@property (nonatomic, strong) NSArray *mutiArray;
//@property (nonatomic, assign) BOOL isCurrentBar;
@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign, readonly) float textBottom;

+ (instancetype)mutiBarWith:(NSArray *)mutiArray;

@end
