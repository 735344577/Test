//
//  KLSannerCell.m
//  CloudMoneyNew
//
//  Created by haitao on 2017/5/20.
//  Copyright © 2017年 dfyg. All rights reserved.
//

#import "KLSannerCell.h"

@interface KLSannerCell ()
//月份
@property (nonatomic, strong) UILabel *monnthLabel;
@end

@implementation KLSannerCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _monnthLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_monnthLabel];
        _monnthLabel.textAlignment = NSTextAlignmentCenter;
        [_monnthLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(5);
            make.right.equalTo(self.contentView).offset(-5);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return self;
}


- (void)setMonth:(NSString *)month {
    _month = month;
    _monnthLabel.text = month;
}

@end
