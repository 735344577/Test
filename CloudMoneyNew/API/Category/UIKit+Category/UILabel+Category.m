//
//  UILabel+Category.m
//  admin
//
//  Created by haitao on 15/9/21.
//  Copyright © 2015年 haitao. All rights reserved.
//

#import "UILabel+Category.h"
#import "UIKit+Category.h"
@implementation UILabel (Category)


@end


@implementation UILabel (CGRect)

- (CGSize)getSizeWithFont:(UIFont *)font
{
    if (!font) {
        font = self.font;
    }
    CGSize size = CGSizeMake(CGRectGetWidth(self.frame), 300);
    CGSize rect = [self.text boundingRectWithSize:size
                                             options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                          attributes:@{NSFontAttributeName:font}
                                             context:nil].size;
    return rect;
}

- (CGSize)getSizeWithAttributeDict:(NSDictionary *)dict{
    CGSize size = CGSizeMake(CGRectGetWidth(self.frame), 300);
    CGSize rect = [self.text boundingRectWithSize:size
                                          options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                       attributes:dict
                                          context:nil].size;
    return rect;
}

- (CGFloat)sizeToFitWidth{
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat x = CGRectGetMinX(self.frame);
    CGFloat y = CGRectGetMinY(self.frame);
    [self sizeToFit];
    CGSize size = self.frame.size;
    width = width < size.width ? width : size.width;
    self.frame = CGRectMake(x, y, width, height);
    return width;
}

- (CGFloat)getWidth{
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    CGSize size = [self sizeThatFits:self.frame.size];
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), size.width, height);
    return width;
}

- (void)sizeToFitWidthChangeHeight{
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat x = CGRectGetMinX(self.frame);
    CGFloat y = CGRectGetMinY(self.frame);
    CGFloat center_Y = CGRectGetMidY(self.frame);
    [self sizeToFit];
    CGSize size = self.frame.size;
    width = width < size.width ? width : size.width;
    self.frame = CGRectMake(x, y, width, size.height);
    self.center = CGPointMake(self.center.x, center_Y);
}

@end
@implementation UILabel (changeValue)

- (void)textChangeFromNum:(NSInteger)start endNum:(NSInteger)end{
    CGFloat animationPeriod = 0.25;
    NSInteger conut = end - start;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        for (NSInteger i = start; i <= start + conut; i++) {
            usleep(animationPeriod/conut * 1000000); // sleep in microseconds
            dispatch_async(dispatch_get_main_queue(), ^{
                self.text = [NSString stringWithFormat:@"%ld", i];
            });
        }
    });
}

- (void)textChangeStartNum:(CGFloat)start endNum:(CGFloat)end{
    CGFloat animationPeriod = 0.25;
    NSInteger conut = (end - start) * 100;
    if (conut > 100000) {
        animationPeriod = 1.25;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        for (NSInteger i = start * 100; i <= end * 100; i++) {
            usleep(animationPeriod/conut * 1000000); // sleep in microseconds
            dispatch_async(dispatch_get_main_queue(), ^{
                self.text = [NSString stringWithFormat:@"%.2f", [@(i) floatValue] / 100];
            });
        }
    });
}

@end


@implementation UILabel (Font_Color)

- (void)txtArr:(NSArray *)txtArr colorArr:(NSArray *)colorArr fontArr:(NSArray *)fontArr {
    
    NSInteger okCount = 0;
    okCount = txtArr.count < colorArr.count ? txtArr.count : colorArr.count;
    okCount = okCount < fontArr.count ? okCount : fontArr.count;
    
    NSMutableString *txt = [NSMutableString string];
    for (NSString *str in txtArr) {
        [txt appendString:str];
    }
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:txt];
    NSInteger startLoc = 0;
    for (int i = 0; i < okCount; i++) {
        if ([fontArr[i] isKindOfClass:[NSNumber class]]) {
           [str addAttributes:@{NSForegroundColorAttributeName:colorArr[i], NSFontAttributeName:[UIFont systemFontOfSize:[fontArr[i] integerValue]]} range:NSMakeRange(startLoc, [txtArr[i] length])];
        }else if ([fontArr[i] isKindOfClass:[UIFont class]]){
            [str addAttributes:@{NSForegroundColorAttributeName:colorArr[i], NSFontAttributeName:fontArr[i]} range:NSMakeRange(startLoc, [txtArr[i] length])];
        }
        
        startLoc += [txtArr[i] length];
    }
    self.attributedText = str;
}

@end

@implementation UILabel (LineSpace)

- (void)setLineSpace:(NSInteger)lineSpace{
    NSMutableAttributedString *attributedString =
    [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableParagraphStyle *paragraphStyle =  [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    //调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
}

@end

