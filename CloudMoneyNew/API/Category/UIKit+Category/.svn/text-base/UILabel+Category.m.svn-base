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

+ (UILabel *)labelwithFrame:(CGRect)frame TextName:(NSString *)textname  FontSize:(CGFloat)size
{
    UILabel *label = [[UILabel alloc] init];
    [label setFrame:frame];
    [label setText:textname];
    label.font = [UIFont  systemFontOfSize:size];
    label.backgroundColor = [UIColor  clearColor];
    //    label.textColor = [UIColor colorWithHexString:@"#818181"];
    //    label.translatesAutoresizingMaskIntoConstraints = NO;
    return label;
}

/**
 frame:位置和大小
 textname:标题名称
 size:字体大小
 str:字体颜色值
 */
+ (UILabel *)labelwithFrame:(CGRect)frame TextName:(NSString *)textname FontSize:(CGFloat)size  textColor:(NSString *)str
{
    UILabel *label = [[UILabel alloc] init];
    [label setFrame:frame];
    [label setText:textname];
    label.font = [UIFont  systemFontOfSize:size];
    label.textColor = [UIColor colorWithHexString:str];
    return label;
}

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

