//
//  DragView.m
//  CloudMoneyNew
//
//  Created by nice on 15/11/6.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import "DragView.h"

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface DragView ()

@property (nonatomic, strong) UIPanGestureRecognizer * panGestureRecognizer;

@property (nonatomic, strong) UITapGestureRecognizer * tapGestureRecognizer;
/**
 *  层级 是放在root及还是 child级 root级含有TabBarVC child级不含TabBarVC
 *  默认  是Root_Level
 */
@property (nonatomic, assign) Level level;

@property (nonatomic, copy) dispatch_block_t clickBlock;

@property (nonatomic, strong) UIWindow * window;

@property (nonatomic, strong) NSDate * endDate;

@property (nonatomic, assign) BOOL  isAddWindow;

@end

@implementation DragView


- (instancetype)initWithFrame:(CGRect)frame level:(Level)level clickBlock:(dispatch_block_t)clickBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clickBlock = clickBlock;
        self.backgroundColor = [UIColor clearColor];
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.backgroundColor = [UIColor clearColor];
        _imageView.image = [UIImage imageNamed:@"459FA1E4-A272-4F15-82BC-831C8957D069.png"];
        [self addSubview:self.imageView];
        
        self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandleGesture:)];
        [self addGestureRecognizer:_panGestureRecognizer];
        
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClickAction:)];
        [self addGestureRecognizer:_tapGestureRecognizer];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.alpha = 0.9;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.alpha = 0.9;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self performSelector:@selector(startAnimation) withObject:nil afterDelay:5.0];
    _endDate  = [NSDate date];
}

- (void)startAnimation
{
    NSDate * nowDate = [NSDate date];
    NSComparisonResult result = [nowDate compare:[_endDate dateByAddingTimeInterval:5]];
    if (result >= 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 0.7;
        }];
    }
}

- (void)panHandleGesture:(UIPanGestureRecognizer *)gesture
{
    if (!_isAddWindow) {
        [self.superview bringSubviewToFront:self];
    }
    CGPoint translation = [gesture translationInView:self.superview];
    gesture.view.center = CGPointMake(gesture.view.center.x + translation.x, gesture.view.center.y + translation.y);
    [gesture setTranslation:CGPointZero inView:self.superview];
    __weak typeof(self) weakSelf = self;
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.20 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGRect rect = self.frame;
            
            float originY = 0;
            
            if (_level == ROOT) {
                originY = SCREEN_HEIGHT - 49 - CGRectGetHeight(self.frame);
            }else if (_level == CHILD){
                originY = SCREEN_HEIGHT - CGRectGetHeight(self.frame);
            }
            if (_isAddWindow) {
                if (gesture.view.origin.y < 64) {
                    rect.origin.y = 64;
                }else if (gesture.view.origin.y > originY){
                    rect.origin.y = originY;
                }
            }else{
                if (gesture.view.origin.y < 0) {
                    rect.origin.y = 0;
                }else if (gesture.view.origin.y > originY - 64 - 49){
                    rect.origin.y = originY - 64;
                }
            }
            
            if (gesture.view.origin.x < 5) {
                rect.origin.x = 0;
            }else if (gesture.view.origin.x > SCREEN_WIDTH - CGRectGetWidth(self.frame) - 5){
                rect.origin.x = SCREEN_WIDTH - CGRectGetWidth(self.frame);
            }
            if (gesture.view.center.x  < (SCREEN_WIDTH / 2)) {
                rect.origin.x = 0;
            }else{
                rect.origin.x = SCREEN_WIDTH - rect.size.width;
            }
            
            self.frame = rect;
        } completion:^(BOOL finished) {
            if (weakSelf.frame.origin.x < 10) {
                weakSelf.imageView.transform = CGAffineTransformMakeScale(-1, 1);
            }else{
                weakSelf.imageView.transform = CGAffineTransformMakeScale(1, 1);
            }

        }];
    }
    
}

- (void)tapClickAction:(UITapGestureRecognizer *)tap
{
    
    if (self.clickBlock) {
        self.clickBlock();
    }
}

- (void)show
{
    _window = [[UIApplication sharedApplication] windows].lastObject;
    _window.windowLevel = UIWindowLevelNormal;
    [_window.rootViewController.view addSubview:self];
    _isAddWindow = YES;
//    [_window addSubview:self];
    
}


- (void)hide
{
    if (_isAddWindow) {
        [self removeFromSuperview];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
