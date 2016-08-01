//
//  CMUserInfo.h
//  CloudMoneyNew
//
//  Created by nice on 15/9/22.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  客户信息类
 */
@interface CMUserInfo : NSObject
@property (nonatomic, copy) NSString * name;
@property (nonatomic, assign) BOOL sex;
@property (nonatomic, assign) float grade;
@property (nonatomic, copy) NSString * love;
@end
