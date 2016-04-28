//
//  UITabBarItem+Category.h
//  admin
//
//  Created by haitao on 15/9/21.
//  Copyright © 2015年 haitao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarItem (Category)

+ (instancetype)itemWithTitle:(NSString *)title
                        image:(NSString *)imageName
                selectedImage:(NSString *)selectImageName;


@end
