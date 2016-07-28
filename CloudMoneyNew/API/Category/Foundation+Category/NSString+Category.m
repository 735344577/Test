//
//  NSString+Category.m
//  admin
//
//  Created by haitao on 15/9/21.
//  Copyright © 2015年 haitao. All rights reserved.
//

#import "NSString+Category.h"
#define SystemVersion(a)               [[[UIDevice currentDevice]systemVersion]floatValue] >= a

@implementation NSString (Category)
//处理四舍五入的问题
+ (NSString *)notRounding:(float)price afterPoint:(int)position{
//    NSDecimalNumberHandler初始化时的关键参数：decimalNumberHandlerWithRoundingMode：NSRoundDown，
//    NSRoundDown代表的就是 只舍不入。
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

- (BOOL)isContainsString:(NSString *)str
{
    if (SystemVersion(8)) {
        return [self containsString:str];
    }else{
        NSRange range = [self rangeOfString:str];
        BOOL result = range.location != NSNotFound;
        return result;
    }
}


//邮箱

+ (BOOL) validateEmail:(NSString *)email

{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}





//手机号码验证

- (BOOL)validateMobile{
    
    NSString *MOBILE = @"^1[34578]\\d{9}$";
    
    NSPredicate *regexTestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    
    if ([regexTestMobile evaluateWithObject:self]) {
        
        return YES;
        
    }else {
        
        return NO;
    }
}
    
    
    
    
    //车牌号验证
    
+ (BOOL) validateCarNo:(NSString *)carNo
    
{
        
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
        
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
        
    NSLog(@"carTest is %@",carTest);
        
    return [carTest evaluateWithObject:carNo];
        
}

//车型
    
+ (BOOL) validateCarType:(NSString *)CarType
    
{
        
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
        
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
        
    return [carTest evaluateWithObject:CarType];
        
}

//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
        
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
        
    BOOL B = [userNamePredicate evaluateWithObject:name];
        
    return B;
        
}

//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

//昵称 4~8位中文
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

//身份证号   非严谨性  未验证身份证上的出生日期
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
    
//判断是否有特殊符号 大小写字母和数字认为不是特殊符号 长度为6~20位
- (BOOL)effectivePassword
{
    NSString *regex = @"[a-zA-Z0-9]{6,20}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

- (NSString *)changeStringWithStr:(NSString *)change
                            range:(NSRange)range{
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:0 error:nil];
    return [regularExpression stringByReplacingMatchesInString:self options:0 range:range withTemplate:change];
}

- (NSString *)changeAsteriskStringWithRange:(NSRange)range{
    return [self changeStringWithStr:@"*" range:range];
}

@end
