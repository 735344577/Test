//
//  UIViewController+Category.m
//  CloudMoneyNew
//
//  Created by nice on 16/3/29.
//  Copyright © 2016年 dfyg. All rights reserved.
//

#import "UIViewController+Category.h"

@implementation UIViewController (Category)

+ (instancetype)getViewControllerWithNib{
    return [[self alloc] initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
}

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(new_viewWillAppear:);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);
        
        SEL disAppearSelector = @selector(viewWillDisappear:);
        SEL swDisAppearSelector = @selector(new_viewWillDisappear:);
        Method disAppearMethod = class_getInstanceMethod(class, disAppearSelector);
        Method swDisAppearMethod = class_getInstanceMethod(class, swDisAppearSelector);
        method_exchangeImplementations(disAppearMethod, swDisAppearMethod);
    });
}

- (void)new_viewWillAppear:(BOOL)animation{
    [self insert_viewWillAppear];
    [self new_viewWillAppear:animation];
}

- (void)new_viewWillDisappear:(BOOL)animation{
    [self insert_viewWillDisappear];
    [self new_viewWillDisappear:animation];
}

- (void)insert_viewWillAppear{
    NSString * pageID = [self pageEventID:YES];
    if (pageID) {
        
    }
}

- (void)insert_viewWillDisappear{
    NSString * pageID = [self pageEventID:NO];
    if (pageID) {
        
    }
}

- (NSString *)pageEventID:(BOOL)bEnterPage{
    NSDictionary * configInfo = [Status dictionaryFromConfigPlist];
    NSString * selfClassName = NSStringFromClass([self class]);
    return configInfo[selfClassName][@"PageEventIDs"][bEnterPage ? @"Enter" : @"Leave"];
}

@end
