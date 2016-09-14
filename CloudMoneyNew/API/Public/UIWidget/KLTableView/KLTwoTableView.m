//
//  KLTwoTableView.m
//  CloudMoneyNew
//
//  Created by nice on 16/8/23.
//  Copyright © 2016年 dfyg. All rights reserved.
//

#import "KLTwoTableView.h"

static NSString * leftIdentifier = @"leftCellIdentifier";
static NSString * rightIdentifier = @"rightCellIdentifier";

@interface KLTwoTableView ()<UITableViewDelegate, UITableViewDataSource>
/*左侧TableView*/
@property (nonatomic, strong) UITableView * leftTableView;
/**右侧TableView*/
@property (nonatomic, strong) UITableView * rightTableView;

@end

@implementation KLTwoTableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self addSubview:self.leftTableView];
    [self addSubview:self.rightTableView];
    _leftTableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame) / 3, CGRectGetHeight(self.frame));
    _rightTableView.frame = CGRectMake(CGRectGetMaxX(_leftTableView.frame), 0, CGRectGetWidth(self.frame) - CGRectGetWidth(_leftTableView.frame), CGRectGetHeight(self.frame));
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _leftTableView) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:leftIdentifier forIndexPath:indexPath];
        cell.textLabel.text = _leftDataSource[indexPath.row];
        return cell;
    } else if (tableView == _rightTableView) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:rightIdentifier forIndexPath:indexPath];
        if (_rightStyle == RightTableViewPlane) {
            cell.textLabel.text = _rightDataSource[indexPath.row];
        } else if (_rightStyle == RightTableViewGroup) {
            cell.textLabel.text = _rightDataSource[indexPath.section][indexPath.row];
        }
        return cell;
    }
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _leftTableView) {
        return _leftDataSource.count;
    } else if (tableView == _rightTableView) {
        if (_rightStyle == RightTableViewPlane) return _rightDataSource.count;
        else if (_rightStyle == RightTableViewGroup) return [(NSArray *)_rightDataSource[section] count];
        return _rightDataSource.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == _leftTableView) {
        return 1;
    } else if (tableView == _rightTableView) {
        if (_rightStyle == RightTableViewPlane) return 1;
        else if (_rightStyle == RightTableViewGroup) return _leftDataSource.count;
    }
    return 1;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)setRightStyle:(RightTableViewStyle)rightStyle{
    if (rightStyle == RightTableViewGroup) {
        for (NSInteger i = 0; i < _rightDataSource.count; i++) {
            NSAssert([_rightDataSource[i] isKindOfClass:[NSArray class]], @"右侧TableView数组格式不正确");
        }
    }
    _rightStyle = rightStyle;
}

#pragma -mark -- 懒加载
- (UITableView *)leftTableView {
	if (_leftTableView == nil) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.tableFooterView = [UIView new];
        [_leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:leftIdentifier];
	}
	return _leftTableView;
}
- (UITableView *)rightTableView {
	if (_rightTableView == nil) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.tableFooterView = [UIView new];
        [_rightTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:rightIdentifier];
	}
	return _rightTableView;
}


@end
