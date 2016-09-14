//
//  KLPopView.m
//  CloudMoneyNew
//
//  Created by nice on 16/6/2.
//  Copyright © 2016年 dfyg. All rights reserved.
//

#import "KLPopView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define Length 5
#define Length2 15

@interface KLPopView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView * backgroundView;

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) XTDirectionType type;
@end

@implementation KLPopView

- (instancetype)initWithOrigin:(CGPoint)origin
                         width:(CGFloat)width
                        height:(CGFloat)height
                          Type:(XTDirectionType)type
                         color:(UIColor *)color{
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)]) {
        self.backgroundColor = [UIColor clearColor];
        self.origin = origin;
        self.width = width;
        self.height = height;
        self.type = type;
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(origin.x, origin.y, width, height)];
        if (!color) {
            color = [UIColor colorWithRed:0.2737 green:0.2737 blue:0.2737 alpha:1.0];
        }
        self.backgroundView.backgroundColor = color;
        [self addSubview:self.backgroundView];
        [self.backgroundView addSubview:self.tableView];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    switch (self.type) {
        case XTTypeOfUpLeft:
        case XTTypeOfUpCenter:
        case XTTypeOfUpRight:
            {
                CGFloat startX = self.origin.x;
                CGFloat StartY = self.origin.y;
                CGContextMoveToPoint(context, startX, StartY);
                CGContextAddLineToPoint(context, startX + Length, StartY + Length);
                CGContextAddLineToPoint(context, startX - Length, StartY + Length);
            }
        break;
        
        case XTTypeOfDownLeft:
        case XTTypeOfDownCenter:
        case XTTypeOfDownRight:
        {
            CGFloat startX = self.origin.x;
            CGFloat StartY = self.origin.y;
            CGContextMoveToPoint(context, startX, StartY);
            CGContextAddLineToPoint(context, startX - Length, StartY - Length);
            CGContextAddLineToPoint(context, startX + Length, StartY - Length);
        }
            break;
            
        case XTTypeOfLeftUp:
        case XTTypeOfLeftCenter:
        case XTTypeOfLeftDown:
        {
            CGFloat startX = self.origin.x;
            CGFloat StartY = self.origin.y;
            CGContextMoveToPoint(context, startX, StartY);
            CGContextAddLineToPoint(context, startX + Length, StartY - Length);
            CGContextAddLineToPoint(context, startX + Length, StartY + Length);
        }
            break;
            
        case XTTypeOfRightUp:
        case XTTypeOfRightCenter:
        case XTTypeOfRightDown:
        {
            CGFloat startX = self.origin.x;
            CGFloat StartY = self.origin.y;
            CGContextMoveToPoint(context, startX, StartY);
            CGContextAddLineToPoint(context, startX - Length, StartY - Length);
            CGContextAddLineToPoint(context, startX - Length, StartY + Length);
        }
            break;
            
        default:
            break;
    }
    
    CGContextClosePath(context);
    [self.backgroundView.backgroundColor setFill];
    [self.backgroundColor setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)popView{
    NSArray * results = [self.backgroundView subviews];
    for (UIView * view in results) {
        [view setHidden:YES];
    }
    UIWindow * windowView = [[UIApplication sharedApplication].windows firstObject];
    [windowView addSubview:self];
    
    CGFloat origin_x = self.origin.x - Length2;
    CGFloat origin_y = self.origin.y + Length;
    CGFloat size_width = self.width;
    CGFloat size_height = self.height;
    switch (self.type) {
        case XTTypeOfUpLeft:
        {
            self.backgroundView.frame = CGRectMake(self.origin.x, self.origin.y + Length, 0, 0);
        }
            break;
        case XTTypeOfUpCenter:
        {
            self.backgroundView.frame = CGRectMake(self.origin.x, self.origin.y + Length, 0, 0);
            origin_x = self.origin.x - self.width / 2;
            origin_y = self.origin.y + Length;
        }
            break;
        case XTTypeOfUpRight:
        {
            self.backgroundView.frame = CGRectMake(self.origin.x, self.origin.y + Length, 0, 0);
            origin_x = self.origin.x + Length2;
            origin_y = self.origin.y + Length;
            size_width = -self.width;
        }
            break;
            
        
        case XTTypeOfDownLeft:
        {
            self.backgroundView.frame = CGRectMake(self.origin.x, self.origin.y - Length, 0, 0);
            origin_x = self.origin.x - Length2;
            origin_y = self.origin.y - Length;
            size_height = -self.height;
        }
            break;
        case XTTypeOfDownCenter:
        {
            self.backgroundView.frame = CGRectMake(self.origin.x, self.origin.y - Length, 0, 0);
            origin_x = self.origin.x - self.width / 2;
            origin_y = self.origin.y - Length;
            size_height = -self.height;
        }
            break;
        case XTTypeOfDownRight:
        {
            self.backgroundView.frame = CGRectMake(self.origin.x, self.origin.y - Length, 0, 0);
            origin_x = self.origin.x - self.width + Length2;
            origin_y = self.origin.y - Length;
            size_height = -self.height;
        }
            break;
            
        case XTTypeOfLeftUp:
        {
            self.backgroundView.frame = CGRectMake(self.origin.x + Length, self.origin.y, 0, 0);
            origin_x = self.origin.x + Length;
            origin_y = self.origin.y - Length2;
        }
            break;
        case XTTypeOfLeftCenter:
        {
            self.backgroundView.frame = CGRectMake(self.origin.x + Length, self.origin.y, 0, 0);
            origin_x = self.origin.x + Length;
            origin_y = self.origin.y - self.height / 2;
        }
            break;
        case XTTypeOfLeftDown:
        {
            self.backgroundView.frame = CGRectMake(self.origin.x + Length, self.origin.y, 0, 0);
            origin_x = self.origin.x + Length;
            origin_y = self.origin.y - self.height + Length2;
        }
            break;
            
        case XTTypeOfRightUp:
        {
            self.backgroundView.frame = CGRectMake(self.origin.x - Length, self.origin.y, 0, 0);
            origin_x = self.origin.x - Length;
            origin_y = self.origin.y - Length2;
            size_width = -self.width;
        }
            break;
        case XTTypeOfRightCenter:
        {
            self.backgroundView.frame = CGRectMake(self.origin.x - Length, self.origin.y, 0, 0);
            origin_x = self.origin.x - Length;
            origin_y = self.origin.y - self.height / 2;
            size_width = -self.width;
        }
            break;
        case XTTypeOfRightDown:
        {
            self.backgroundView.frame = CGRectMake(self.origin.x - Length, self.origin.y, 0, 0);
            origin_x = self.origin.x - Length;
            origin_y = self.origin.y - self.height + Length2;
            size_width = -self.width;
        }
            break;
        default:
            break;
    }
    [self startAnimationViewX:origin_x y:origin_y origin_width:size_width oright_height:size_height];
    
}

- (void)startAnimationViewX:(CGFloat)x
                          y:(CGFloat)y
                origin_width:(CGFloat)width
               oright_height:(CGFloat)height{
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundView.frame = CGRectMake(x, y, width, height);
    } completion:^(BOOL finished) {
        NSArray * results = [self.backgroundView subviews];
        for (UIView * view in results) {
            [view setHidden:NO];
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (![[touches anyObject].view isEqual:self.backgroundView]) {
        [self dismiss];
    }
}

- (void)dismiss{
    NSArray * results = [self.backgroundView subviews];
    for (UIView * view in results) {
        [view removeFromSuperview];
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundView.frame = CGRectMake(self.origin.x, self.origin.y, 0, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.backgroundView.frame.size.width - 5, self.backgroundView.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIndentifiers"];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.row_height == 0) {
        return 44;
    }else{
        return self.row_height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellIndentifiers" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    if (self.images[indexPath.row]) {
        cell.imageView.image = [UIImage imageNamed:self.images[indexPath.row]];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    if (!self.titleTextColor) {
        self.titleTextColor = [UIColor whiteColor];
    }
    cell.textLabel.textColor = self.titleTextColor;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:self.fontSize];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_selectBlock) {
        _selectBlock(indexPath.row);
    }else if (_delegate && [_delegate respondsToSelector:@selector(selectIndexPathRow:)]) {
        [_delegate selectIndexPathRow:indexPath.row];
    }
    [self dismiss];
}

@end
