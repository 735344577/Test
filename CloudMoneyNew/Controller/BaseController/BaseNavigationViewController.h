//
//  BaseNavigationViewController.h
//  admin
//
//  Created by haitao on 15/9/21.
//  Copyright © 2015年 haitao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationViewController : UINavigationController

//滑动返回手势 如果想禁止手势设置手势的 enabled 为 NO  Default 为YES
@property (strong, nonatomic) UIPanGestureRecognizer * panGestureRecognizer;



@end
