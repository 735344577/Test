//
//  KLDataBase.m
//  CloudMoneyNew
//
//  Created by nice on 16/7/22.
//  Copyright © 2016年 dfyg. All rights reserved.
//

#import "KLDataBase.h"
#import <FMDB/FMDB.h>

#define PATH_OF_DOCUMENT  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@interface KLDataBase ()

@property (nonatomic, strong) FMDatabaseQueue * dbQueue;

@end

static NSString * const DEFAULT_DB = @"database.db";

static NSString * const UserDB = @"UserDB";

static NSString * const CREATE_TABLE_SQL =
@"CREATE TABLE IF NOT EXISTS %@ ( \
id TEXT NOT NULL, \
json TEXT NOT NULL, \
createdTime TEXT NOT NULL, \
PRIMARY KEY(id)) \
";
static NSString *const UPDATE_ITEM_SQL = @"REPLACE INTO %@ (id, json, createdTime) values (?, ?, ?)";

static NSString *const QUERY_IFEM_SQL = @"SELECT json, createdTime from %@ where id = ? Limit 1";

static NSString *const SELECT_ALL_SQL = @"SELECT * from %@";

static NSString *const CLEAR_ALL_SQL = @"DELETE from %@";

static NSString *const DELETE_ITEM_SQL = @"DELETE from %@ where id = ?";

static NSString *const DELETE_ITEMS_SQL = @"DELETE from %@ where id in ( %@ )";

static NSString *const DELETE_ITEMS_WITH_PREFIX_SQL = @"DELETE from %@ where id like ? ";

@implementation KLDataBase

+ (instancetype)shareManager{
    return [[self alloc] init];
}

- (BOOL)checkTableName:(NSString *)tableName{
    if (tableName == nil || tableName.length == 0 || [tableName rangeOfString:@" "].location != NSNotFound) {
        NSAssert(tableName.length != 0, @"ERROR, table name: %@ format error.",tableName);
        return NO;
    }
    return YES;
}

- (instancetype)init{
    return [self initDBWithName:DEFAULT_DB];
}

- (instancetype)initDBWithName:(NSString *)dbName
{
    self = [super init];
    if (self) {
        NSString * dbPath = [PATH_OF_DOCUMENT stringByAppendingPathComponent:dbName];
        DLog(@"dbPath = %@", dbPath);
        if (_dbQueue) {
            [self close];
        }
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        [self createTableWithName:UserDB];
    }
    return self;
}

- (instancetype)initWithDBWithPath:(NSString *)dbPath
{
    self = [super init];
    if (self) {
        DLog(@"dbPath = %@", dbPath);
        if (_dbQueue) {
            [self close];
        }
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    }
    return self;
}

- (void)createTableWithName:(NSString *)tableName
{
    if (![[self class] checkTableName:tableName]) {
        return ;
    }
    NSString * sql = [NSString stringWithFormat:CREATE_TABLE_SQL, tableName];
    __block BOOL result;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql];
    }];
    if (!result) {
        DLog(@"ERROR, failed to create table: %@", tableName);
    }
}

- (BOOL)isTableExists:(NSString *)tableName
{
    if ([[self class] checkTableName:tableName] == NO) {
        return NO;
    }
    __block BOOL result;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        result = [db tableExists:tableName];
    }];
    if (!result) {
        DLog(@"ERROR, table: %@ not exists in current DB", tableName);
    }
    return result;
}

- (void)clearTable:(NSString *)tableName{
    if (![[self class] checkTableName:tableName]) {
        return ;
    }
    NSString * sql = [NSString stringWithFormat:CLEAR_ALL_SQL, tableName];
    __block BOOL result ;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql];
    }];
    if (!result) {
        DLog(@"ERROR, failed to clear table: %@", tableName);
    }
    
}

- (void)putObject:(id)object withId:(NSString *)objectId intoTable:(NSString *)tableName
{
    if (![[self class] checkTableName:tableName]) {
        return ;
    }
    NSError * error;
    NSData * data = [NSJSONSerialization dataWithJSONObject:object options:0 error:&error];
    if (error) {
        DLog(@"ERROR, failed to get json data");
        return ;
    }
    
    NSString * jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDate * createdTime = [NSDate date];
    NSString * sql = [NSString stringWithFormat:UPDATE_ITEM_SQL, tableName];
    __block BOOL result;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql, objectId, jsonString, createdTime];
    }];
    if (!result) {
        DLog(@"ERROR, failed to insert/replace into table: %@", tableName);
    }
    
}

- (id)getObjectById:(NSString *)objectId fromTable:(NSString *)tableName
{
    KeyValueItem * item = [self getKeyValueItemById:objectId fromTable:tableName];
    if (item) {
        return item.itemObject;
    }else{
        return nil;
    }
}

- (KeyValueItem *)getKeyValueItemById:(NSString *)objectId fromTable:(NSString *)tableName
{
    if (![[self class] checkTableName:tableName]) {
        return  nil;
    }
    NSString * sql = [NSString stringWithFormat:QUERY_IFEM_SQL, tableName];
    __block NSString * json = nil;
    __block NSDate * createTime = nil;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet * rs = [db executeQuery:sql, objectId];
        if ([rs next]) {
            json = [rs stringForColumn:@"json"];
            createTime = [rs dateForColumn:@"createdTime"];
        }
        [rs close];
    }];
    if (json) {
        NSError * error;
        id result = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            DLog(@"ERROR, failed to prase to json");
            return nil;
        }
        KeyValueItem * item = [[KeyValueItem alloc] init];
        item.itemId = objectId;
        item.itemObject = result;
        item.createdTime = createTime;
        return item;
    }else{
        return nil;
    }
}

- (void)putString:(NSString *)string withId:(NSString *)stringId intoTable:(NSString *)tableName
{
    if (string == nil) {
        DLog(@"ERROR, string is nil");
        return ;
    }
    [self putObject:@[string] withId:stringId intoTable:tableName];
}

- (NSString *)getStringById:(NSString *)stringId fromTable:(NSString *)tableName
{
    NSArray * array = [self getObjectById:stringId fromTable:tableName];
    if (array && [array isKindOfClass:[NSArray class]]) {
        return array[0];
    }
    return nil;
}

- (void)putNumber:(NSNumber *)number withId:(NSString *)numberId intoTable:(NSString *)tableName
{
    if (number == nil) {
        DLog(@"ERROR, number is nil");
        return ;
    }
    [self putObject:@[number] withId:numberId intoTable:tableName];
}

- (NSNumber *)getNumberById:(NSString *)numberId fromTable:(NSString *)tableName
{
    NSArray * array = [self getObjectById:numberId fromTable:tableName];
    if (array && [array isKindOfClass:[NSArray class]]) {
        return array[0];
    }
    return nil;
}

- (NSArray *)getAllItemsFromTable:(NSString *)tableName
{
    if (![[self class] checkTableName:tableName]) {
        return nil;
    }
    NSString * sql = [NSString stringWithFormat:SELECT_ALL_SQL, tableName];
    __block NSMutableArray * result = [NSMutableArray array];
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            KeyValueItem * item = [[KeyValueItem alloc] init];
            item.itemId = [rs stringForColumn:@"id"];
            item.itemObject = [rs stringForColumn:@"json"];
            item.createdTime = [rs dateForColumn:@"createdTime"];
            [result addObject:item];
        }
        [rs close];
    }];
    NSError * error;
    for (KeyValueItem * item in result) {
        error = nil;
        id object = [NSJSONSerialization JSONObjectWithData:[item.itemObject dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            DLog(@"ERROR, failed to prase to json.");
        }else{
            item.itemObject = object;
        }
    }
    return result;
}

- (void)deleteObjectById:(NSString *)objectId fromTable:(NSString *)tableName
{
    if (![[self class] checkTableName:tableName]) {
        return ;
    }
    NSString * sql = [NSString stringWithFormat:DELETE_ITEM_SQL, tableName];
    __block BOOL result;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql, objectId];
    }];
    if (!result) {
        DLog(@"ERROR, failed to delete item from table: %@", tableName);
    }
}

- (void)deleteObjectsByIdArray:(NSArray *)objectIdArray fromTable:(NSString *)tableName
{
    if (![[self class] checkTableName:tableName]) {
        return ;
    }
    NSMutableString * stringBuiler = [NSMutableString string];
    for (id objectId in objectIdArray) {
        NSString * item = [NSString stringWithFormat:@" '%@' ", objectId];
        if (stringBuiler.length == 0) {
            [stringBuiler appendString:item];
        }else{
            [stringBuiler appendString:@","];
            [stringBuiler appendString:item];
        }
    }
    NSString * sql = [NSString stringWithFormat:DELETE_ITEMS_SQL, tableName, stringBuiler];
    __block BOOL result;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql];
    }];
    if (!result) {
        DLog(@"ERROR, failed to delete items by ids from table: %@", tableName);
    }
}

- (void)deleteObjectsByIdPrefix:(NSString *)objectIdPrefix fromTable:(NSString *)tableName
{
    if (![[self class] checkTableName:tableName]) {
        return ;
    }
    NSString * sql = [NSString stringWithFormat:DELETE_ITEMS_WITH_PREFIX_SQL, tableName];
    NSString * prefixArgument = [NSString stringWithFormat:@"%@%%", objectIdPrefix];
    __block BOOL result;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql, prefixArgument];
    }];
    if (!result) {
        DLog(@"ERROR, failed to delete items by id prefix from table: %@", tableName);
    }
}

- (void)close{
    [_dbQueue close];
    _dbQueue = nil;
}

@end

@implementation KeyValueItem


@end
