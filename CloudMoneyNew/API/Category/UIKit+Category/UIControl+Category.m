//
//  UIControl+Category.m
//  CloudMoneyNew
//
//  Created by nice on 15/12/15.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import "UIControl+Category.h"
#import <objc/runtime.h>

@interface UIControl ()
@property (nonatomic, assign) BOOL uxy_ignoreEvent;
@end

static const char * acceptEventInterval = "acceptEventInterval";
static const char * HadTriggerEvent = "HadTriggerEvent";

@implementation UIControl (Category)

- (NSTimeInterval)uxy_acceptEventInterval{
    return [objc_getAssociatedObject(self, &acceptEventInterval) doubleValue];
}

- (void)setUxy_acceptEventInterval:(NSTimeInterval)uxy_acceptEventInterval{
    objc_setAssociatedObject(self, &acceptEventInterval, @(uxy_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)uxy_ignoreEvent{
    return [objc_getAssociatedObject(self, &HadTriggerEvent) boolValue];
}

- (void)setUxy_ignoreEvent:(BOOL)uxy_ignoreEvent{
    objc_setAssociatedObject(self, &HadTriggerEvent, @(uxy_ignoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
        Method b = class_getInstanceMethod(self, @selector(__uxy_sendAction:to:forEvent:));
        method_exchangeImplementations(a, b);
    });
}

- (void)__uxy_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if (self.uxy_ignoreEvent) return;
    if (self.uxy_acceptEventInterval > 0)
    {
        self.uxy_ignoreEvent = YES;
        [self performSelector:@selector(setUxy_ignoreEvent:) withObject:@(NO) afterDelay:self.uxy_acceptEventInterval];
    }
    [self performUserSendAction:action to:target forEvent:event];
    [self __uxy_sendAction:action to:target forEvent:event];
}

- (void)performUserSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    NSDictionary * configInfo = [Status dictionaryFromConfigPlist];
    NSString * actionString = NSStringFromSelector(action);
    NSString * targetName = NSStringFromClass([target class]);//ViewController
    NSString * eventID = configInfo[targetName][@"ControlEventIDs"][actionString];
    if (eventID) {
        NSLog(@"eventID = %@", eventID);
    }
}

@end
