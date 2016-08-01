//
//  KLDataBase.h
//  CloudMoneyNew
//
//  Created by nice on 16/7/22.
//  Copyright © 2016年 dfyg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyValueItem :NSObject

@property (nonatomic, copy) NSString * itemId;

@property (nonatomic, strong) id itemObject;

@property (nonatomic, strong) NSDate * createdTime;


@end

@interface KLDataBase : NSObject
//不是单例，为打开/关闭数据库， 不创建单例方法
+ (instancetype)shareManager;
/**
 *  初始化创建名字为dbName的数据库
 *
 *  @param dbName 数据库名称 字段不能为空
 *
 *  @return 返回该类
 */
- (instancetype)initDBWithName:(NSString *)dbName;
/**
 *  @brief 创建数据库方法
 *
 *  @param dbPath 数据库路径，包含数据库
 */
- (instancetype)initWithDBWithPath:(NSString *)dbPath;
/**
 *  @brief 创建表
 *
 *  @param tableName 表名
 */
- (void)createTableWithName:(NSString *)tableName;
/**
 *  @brief 数据库中是否存在表名为 tableName的表
 *
 *  @param tableName 表名
 */
- (BOOL)isTableExists:(NSString *)tableName;
/**
 *  @brief 删除表名为 tableName 的表
 *
 *  @param tableName 表名
 */
- (void)clearTable:(NSString *)tableName;
/**
 *  @brief 关闭数据库
 */
- (void)close;

/**
 *  Put &  Get  methods *******************
 */
/**
 *  @brief 存储 object数据
 *
 *  @param object    要存储的数据对象 NSArray 或者 NSDictionary
 *  @param objectId  key
 *  @param tableName 表名
 */
- (void)putObject:(id)object withId:(NSString *)objectId intoTable:(NSString *)tableName;
/**
 *  @brief 读取数据
 *
 *  @param objectId  key
 *  @param tableName 表名
 *
 *  @return 要取的数据
 */
- (id)getObjectById:(NSString *)objectId fromTable:(NSString *)tableName;

- (KeyValueItem *)getKeyValueItemById:(NSString *)objectId fromTable:(NSString *)tableName;

//存储 key-Value类型的数据 针对NSString类型
- (void)putString:(NSString *)string withId:(NSString *)stringId intoTable:(NSString *)tableName;

//获取 key-Value类型的数据 针对NSString类型
- (NSString *)getStringById:(NSString *)stringId fromTable:(NSString *)tableName;

//存储 key-Value类型的数据 针对NSNumber类型 或者 NSInteger float double BOOL等
- (void)putNumber:(NSNumber *)number withId:(NSString *)numberId intoTable:(NSString *)tableName;

//获取 key-Value类型的数据 针对NSNumber类型 或者 NSInteger float double BOOL等
- (NSNumber *)getNumberById:(NSString *)numberId fromTable:(NSString *)tableName;

- (NSArray *)getAllItemsFromTable:(NSString *)tableName;

- (void)deleteObjectById:(NSString *)objectId fromTable:(NSString *)tableName;

- (void)deleteObjectsByIdArray:(NSArray *)objectIdArray fromTable:(NSString *)tableName;

- (void)deleteObjectsByIdPrefix:(NSString *)objectIdPrefix fromTable:(NSString *)tableName;
@end


