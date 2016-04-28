//
//  UIButton+Category.m
//  admin
//
//  Created by haitao on 15/9/21.
//  Copyright © 2015年 haitao. All rights reserved.
//

#import "UIButton+Category.h"
#import "UIKit+Category.h"
@implementation UIButton (Category)
+ (UIButton*)buttonwithType:(UIButtonType)type Frame:(CGRect)frame TitileName:(NSString *)name  backgroundIamge:(NSString*)image
{
    UIButton *mybtn = [UIButton buttonWithType:type];
    [mybtn setFrame:frame];
    [mybtn setTitle:name forState:UIControlStateNormal];
    [mybtn setBackgroundImage:[UIImage  imageNamed:image] forState: UIControlStateNormal];
    return mybtn;
}

//IOS 1.2版本 改动的地方用方法
/**
 type:  类型
 frame: 位置和大小
 titleName: 标题
 tiltleColorStr: 标题字体颜色
 buttonBgColorStr: 背景色
 */

+ (UIButton *)buttonWithType:(UIButtonType)type buttonFrame:(CGRect)frame buttonTitle:(NSString *)titleName  titleColor:(NSString *)tiltleColorStr  buttonBgColor:(NSString *)buttonBgColorStr
{
    UIButton *button = [UIButton  buttonWithType:type];
    [button  setFrame:frame];
    [button  setTitle:titleName forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor  colorWithHexString:buttonBgColorStr]];
    [button  setTitleColor:[UIColor  colorWithHexString:tiltleColorStr] forState:UIControlStateNormal];
    return button;
}


+ (UIButton *)buttonWithType:(UIButtonType)type buttonFrame:(CGRect)controlframe    labelTitle:(NSString *)titlename backgroundIamge:(NSString *)imagename
{
    UIButton *btn = [UIButton buttonWithType:type];
    
    UILabel *lab = [[UILabel alloc] init];
    lab.text = titlename;
    lab.textAlignment =  NSTextAlignmentCenter;
    lab.textColor = [UIColor  colorWithHexString:@"#818181"];
    lab.backgroundColor = [UIColor  clearColor];
    lab.font = [UIFont  systemFontOfSize:13];
    [btn addSubview:lab];
    [btn setBackgroundImage:[UIImage imageNamed:@"bg.png"] forState: UIControlStateNormal];
    UIImageView *imageview = [[UIImageView alloc]init];
    imageview.image = [UIImage imageNamed:imagename];
    [btn addSubview:imageview];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    /*
     if (IOS_SystemVersion(7) == NO)
     {
     [btn setBackgroundImage:nil forState:UIControlStateNormal];
     [[btn layer] setBorderWidth:0.25];
     [[btn layer] setBorderColor:[UIColor  colorWithHexString:@"#BBBAAA"].CGColor];
     btn.backgroundColor = [UIColor   whiteColor];
     lab.font = [UIFont systemFontOfSize:12];
     }
     
     if ([SDiPhoneVersion deviceSize] ==  iPhone35inch)
     {
     lab.font = [UIFont systemFontOfSize:12];
     [imageview  autoSetDimension:ALDimensionHeight toSize:30];
     [imageview autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:65];
     [imageview autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:65];
     [imageview autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:7];
     
     [lab  autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:35];
     [lab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imageview withOffset:5];
     [lab autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
     }
     else
     {
     lab.font = [UIFont systemFontOfSize:13];
     [imageview  autoSetDimension:ALDimensionHeight toSize:40];
     [imageview autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:60];
     [imageview autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60];
     [imageview autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
     
     [lab  autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:35];
     [lab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imageview withOffset:5];
     [lab autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
     
     }
     
     */
    return btn;
}

+ (UIButton *)buttonWithTitle:(NSString *)titleName titleColor:(NSString *)tiltleColorStr buttonBgColor:(NSString *)buttonBgColorStr
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button  setTitle:titleName forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor  colorWithHexString:buttonBgColorStr]];
    [button  setTitleColor:[UIColor  colorWithHexString:tiltleColorStr] forState:UIControlStateNormal];
    
    return button;
}

@end
