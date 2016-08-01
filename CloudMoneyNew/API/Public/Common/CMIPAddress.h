//
//  CMIPAddress.h
//  CloudMoney
//
//  Created by nice on 16/7/11.
//  Copyright © 2016年 Nemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMIPAddress : NSObject
+ (NSString *)getIPAddress:(BOOL)preferIPv4;
@end
