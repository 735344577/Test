//
//  NSObject+Category.m
//  CloudMoneyNew
//
//  Created by nice on 15/11/11.
//  Copyright © 2015年 dfyg. All rights reserved.
//

#import "NSObject+Category.h"

@implementation NSObject (Category)

+ (instancetype)loopObject:(NSDictionary *)dic
{
    id object = [self new];
    NSArray * names = [NSArray getProperties:[self class]];
    for (NSString * name in names) {
        if (![dic[name] isKindOfClass:[NSNull class]]) {
            if ([dic[name] isKindOfClass:[NSString class]]) {
                [object setValue:dic[name] forKey:name];
            }else{
                [object setValue:[NSString stringWithFormat:@"%@", dic[name]] forKey:name];
            }
        }else{
            [object setValue:nil forKey:name];
        }
    }
    return object;
}

+ (instancetype)setValuesForKeysWithDictionary:(NSDictionary *)dict
{
    id object = [self new];
    [object setValuesForKeysWithDictionary:dict];
    return object;
}

- (NSDictionary *)properties_aps
{
    NSMutableDictionary * props = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t * properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char * CString = property_getName(property);
        NSString * propertyName = [NSString stringWithUTF8String:CString];
        //取出对应的值
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) {
            [props setObject:propertyValue forKey:propertyName];
        }
    }
    free(properties);
    return props;
}

- (NSDictionary *)dictionaryWithValuesForKeys
{
    NSArray * names = [NSArray getProperties:[self class]];
    return [self dictionaryWithValuesForKeys:names];
}

+ (void)createPropertyWithDict:(NSDictionary *)dict{
    //拼接属性字符串代码
    NSMutableString * strM = [NSMutableString string];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString * type;
        if ([obj isKindOfClass:[NSString class]]) {
            type = @"NSString";
        }else if ([obj isKindOfClass:[NSArray class]]){
            type = @"NSArray";
        }else if ([obj isKindOfClass:[NSDictionary class]]){
            type = @"NSDictionary";
        }else if ([obj isKindOfClass:[@(YES) class]]){
            type = @"BOOL";
        }else if ([obj isKindOfClass:[NSNumber class]]){
            NSString * value = [(NSNumber *)obj stringValue];
            if ([value isContainsString:@"."]) {
                type = @"double";
            }else{
                type = @"NSInteger";
            }
        }

        //属性字符串
        NSString * str;
        if ([type isContainsString:@"NS"] && ![type isEqualToString:@"NSInteger"]) {
            if ([type isContainsString:@"NSString"]) {
                str = [NSString stringWithFormat:@"@property (nonatomic, copy) %@ * %@;", type, key];
            } else {
                str = [NSString stringWithFormat:@"@property (nonatomic, strong) %@ * %@;", type, key];
            }
            
        }else{
            str = [NSString stringWithFormat:@"@property (nonatomic, assign) %@ %@;", type, key];
        }
        // 每生成属性字符串，就自动换行。
        [strM appendFormat:@"\n%@\n",str];
    }];
    // 把拼接好的字符串打印出来，就好了。
    NSLog(@"%@",strM);
}

/**
 propertyType = T@"NSString",&,N,V_pString    --> NSString //@ id 指针 对象
 propertyType = T@"NSNumber",&,N,V_pNumber    --> NSNumber
 propertyType = Ti,N,V_pInteger               --> long long
 propertyType = Ti,N,V_pint                  --> long long
 propertyType = Tq,N,V_plonglong             --> long long
 propertyType = Tc,N,V_pchar                 --> char
 propertyType = Tc,N,V_pBool                 --> char
 propertyType = Ts,N,V_pshort                --> short
 propertyType = Tf,N,V_pfloat                --> float
 propertyType = Tf,N,V_pCGFloat              --> float
 propertyType = Td,N,V_pdouble               --> double
 
 .... ^i 表示  int*  一般都不会用到
 *
 *  @param protypes 转换后存到protypes数组中
 *  @param property 属性
 */

- (NSString *)convertToType:(objc_property_t)property {
    
    NSString *attributes = [NSString stringWithCString: property_getAttributes(property) encoding:NSUTF8StringEncoding];
    
    NSString *type = nil;
    if ([attributes hasPrefix:@"T@"]) {
        type = [attributes substringWithRange:NSMakeRange(3, [attributes rangeOfString:@","].location-4)];
    }
    else if ([attributes hasPrefix:@"Ti"] || [attributes hasPrefix:@"Tq"]) {
        type = @"long long";
    }
    else if ([attributes hasPrefix:@"Tf"]) {
        type = @"float";
    }
    else if([attributes hasPrefix:@"Td"]) {
        type = @"double";
    }
    else if([attributes hasPrefix:@"Tl"]) {
        type = @"long";
    }
    else if ([attributes hasPrefix:@"Tc"]) {
        type = @"char";
    }
    else if([attributes hasPrefix:@"Ts"]) {
        type = @"short";
    }
    else {
        type = @"NSString";
    }
    return type;
}


- (NSUInteger)obj_retainCount {
    return [[self valueForKey:@"retainCount"] unsignedLongValue];
}

//- (NSString *)description
//{
//    NSString * string;
//    NSDictionary * info = [self properties_aps];
//    for (NSString * key in info.allKeys) {
//        if (string) {
//            string = [NSString stringWithFormat:@"%@,\n\t%@ : %@", string, key, info[key]];
//        }else{
//            string = [NSString stringWithFormat:@"\t%@ : %@", key, info[key]];
//        }
//        
//    }
//    return [NSString stringWithFormat:@"%@ {\n%@\n}", NSStringFromClass([self class]), string];
//}

@end
