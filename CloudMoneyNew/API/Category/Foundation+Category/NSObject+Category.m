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
        /*
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFConstantString")]) {
            type = @"NSString";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSArrayI")]){
            type = @"NSArray";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSDictionaryI")]){
            type = @"NSDictionary";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            type = @"BOOL";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFNumber")]){
            NSString * value = [(NSNumber *)obj stringValue];
            if ([value isContainsString:@"."]) {
                type = @"double";
            }else{
                type = @"NSInteger";
            }
        }
        */
        
        
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
            str = [NSString stringWithFormat:@"@property (nonatomic, strong) %@ * %@;", type, key];
        }else{
            str = [NSString stringWithFormat:@"@property (nonatomic, assign) %@ %@;", type, key];
        }
        // 每生成属性字符串，就自动换行。
        [strM appendFormat:@"\n%@\n",str];
    }];
    // 把拼接好的字符串打印出来，就好了。
    NSLog(@"%@",strM);
}


- (NSUInteger)obj_retainCount {
    return [[self valueForKey:@"retainCount"] unsignedLongValue];
}

- (NSString *)description
{
    NSString * string;
    NSDictionary * info = [self properties_aps];
    for (NSString * key in info.allKeys) {
        if (string) {
            string = [NSString stringWithFormat:@"%@,\n\t%@ : %@", string, key, info[key]];
        }else{
            string = [NSString stringWithFormat:@"\t%@ : %@", key, info[key]];
        }
        
    }
    return [NSString stringWithFormat:@"%@ {\n%@\n}", NSStringFromClass([self class]), string];
}

@end
