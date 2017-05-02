//
//  KLMosaicImage.h
//  CloudMoneyNew
//
//  Created by haitao on 2017/5/2.
//  Copyright © 2017年 dfyg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLMosaicImage : NSObject

+ (UIImage *)transToMosaicImage:(UIImage*)orginImage blockLevel:(NSUInteger)level;

+ (UIImage *)filterImageMosaic:(UIImage *)image;
@end
