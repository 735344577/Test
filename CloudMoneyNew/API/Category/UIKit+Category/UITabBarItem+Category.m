//
//  UITabBarItem+Category.m
//  admin
//
//  Created by haitao on 15/9/21.
//  Copyright © 2015年 haitao. All rights reserved.
//

#import "UITabBarItem+Category.h"
#import "UIKit+Category.h"
@implementation UITabBarItem (Category)

+ (instancetype)itemWithTitle:(NSString *)title
                        image:(NSString *)imageName
                selectedImage:(NSString *)selectImageName
{
    
    UIImage* selectedImage = [UIImage imageNamed:selectImageName];
    
    //声明这张图片用原图(别渲染)
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem * tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:[UIImage imageNamed:imageName] selectedImage:selectedImage];
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#555555"],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#0a94e5"],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    return tabBarItem;
}

@end
