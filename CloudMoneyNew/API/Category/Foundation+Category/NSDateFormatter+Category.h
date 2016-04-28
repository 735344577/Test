//
//  NSDateFormatter+Category.h
//  CloudMoneyNew
//
//  Created by nice on 15/9/29.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Category)
/*！
 *  NSDateFormatter 的单例方法  每次都创建开销很大
 */
+ (instancetype)shareFormatter;  /**NSDateFormatter 的单例方法 单例方法开销小*/

@end
