//
//  AppDelegate+Category.m
//  CloudMoneyNew
//
//  Created by nice on 15/11/26.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import "AppDelegate+Category.h"
#import <objc/runtime.h>
static char kTabBarControllerKey;
@implementation AppDelegate (Category)
- (UITabBarController *)tabbarController {
    UITabBarController *tabbarController = objc_getAssociatedObject(self, &kTabBarControllerKey);
    if (!tabbarController) {
        tabbarController = [[UITabBarController alloc] init];
        objc_setAssociatedObject(self, &kTabBarControllerKey, tabbarController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return tabbarController;
}
- (void)setTabbarController:(UITabBarController *)tabbarController {
    objc_setAssociatedObject(self, &kTabBarControllerKey, tabbarController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

+ (void)closeKeyWindow {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)push:(NSDictionary *)dict{
    // 类名
    NSString * class = [NSString stringWithFormat:@"%@", dict[@"class"]];
    const char * className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    if (!newClass) {
        // 创建一个类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        //注册你创建的这个类
        objc_registerClassPair(newClass);
    }
    //创建对象
    id instance = [[newClass alloc] init];
    //对该对象赋值属性
    NSDictionary * propertys = dict[@"property"];
    [propertys enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       //检测这个对象是否存在该属性
        if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
            //利用kvc赋值
            [instance setValue:obj forKey:key];
        }
    }];
    //获取导航控制器
    UITabBarController * tabVC = (UITabBarController *)self.window.rootViewController;
    UINavigationController * pushClassStance = (UINavigationController *)tabVC.viewControllers[tabVC.selectedIndex];
    // 跳转到对应的控制器
    [pushClassStance pushViewController:instance animated:YES];
}
//检测对象是否存在该属性
- (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName{
    NSArray * array = [NSArray getProperties:[instance class]];
    for (NSString * propertyName in array) {
        if ([propertyName isEqualToString:verifyPropertyName]) {
            return YES;
        }
    }
    return NO;
}

@end
