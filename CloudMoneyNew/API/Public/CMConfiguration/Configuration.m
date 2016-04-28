//
//  Configuration.m
//  HxForexApp
//
//  Created by guochong on 12-12-3.
//
//

#import "Configuration.h"
#define configFile @"config.plist"

@implementation Configuration

//创建配置文件，返回配置文件的路径参数
+ (NSString *) creatCofigurationFile {
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSString *filename = [documentsDirectory stringByAppendingPathComponent:configFile];
    //	NSLog(@"path=%@",filename);
	//不存在文件则创建
	NSFileManager *filemanager = [NSFileManager defaultManager];
	
	if (![filemanager fileExistsAtPath:filename]) {
		
		[filemanager  createFileAtPath:filename contents:nil attributes:nil];
        
	}
	return filename;
}

//创建配置文件，返回配置文件的路径参数(创建文件夹)
+ (NSString *) creatCofigurationFiles:(NSString *)str {
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSString *filename = [documentsDirectory stringByAppendingPathComponent:str];
    //	NSLog(@"path=%@",filename);
	//不存在文件则创建
	NSFileManager *filemanager = [NSFileManager defaultManager];
	
	if (![filemanager fileExistsAtPath:filename]) {
		
        //		[filemanager  createFileAtPath:filename contents:nil attributes:nil];
        [filemanager createDirectoryAtPath:filename withIntermediateDirectories:YES attributes:nil error:nil];
	}
	return filename;
}

//创建配置文件，返回配置文件的路径参数(创建文件)
+ (NSString *) creatCofigurationFile:(NSString *)str {
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSString *filename = [documentsDirectory stringByAppendingPathComponent:str];
    //	NSLog(@"path=%@",filename);
	//不存在文件则创建
	NSFileManager *filemanager = [NSFileManager defaultManager];
	
	if (![filemanager fileExistsAtPath:filename]) {
		
        [filemanager  createFileAtPath:filename contents:nil attributes:nil];
	}
	return filename;
}

//得到本地配置文件参数，返回数组实例
+ (NSMutableDictionary *)getLocalConfigurationFile {
	
	return [[NSMutableDictionary alloc] initWithContentsOfFile:[self creatCofigurationFile]] ;
    
}
+ (NSMutableDictionary *)getLocalConfigurationFile:(NSString *)str{
	
	return [[NSMutableDictionary alloc] initWithContentsOfFile:[self creatCofigurationFile:str]];
    
}

//初始化设置
+ (void)setConfigInfo
{
	
	NSMutableDictionary* localData = [self getLocalConfigurationFile];
	if (localData == nil || [localData count] == 0) {
    
        BOOL isFirstRun = [[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstFile"];
        if (!isFirstRun) {
            //第一次运行
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstFile"];
            localData =[[NSMutableDictionary alloc]init];
            [localData setObject:[NSString stringWithFormat:@"%d",NO] forKey:isJingPinRemind];
            [localData setObject:[NSString stringWithFormat:@"%d",NO] forKey:isSanBiaoRemind];
            [localData setObject:[NSString stringWithFormat:@"%d",NO] forKey:isXinDaiRemind];
            [localData setObject:[NSString stringWithFormat:@"%d",NO] forKey:isXianXiaRemind];
            [localData setObject:[NSString stringWithFormat:@"%d",YES] forKey:@"isPush"];
            [localData setObject:[NSString stringWithFormat:@"%d",NO] forKey:@"isPrivate"];
            [localData writeToFile:[self creatCofigurationFile] atomically:YES];
        }
    }
}

+ (void)setConfigWithObj:(id)obj key:(id)key
{
    NSMutableDictionary *dic  = [self getLocalConfigurationFile];
    if (key == nil || [key isEqualToString:@""]) {
        NSLog(@"配置参数的key为空");
        return;
    }
    if ([[dic allKeys]containsObject:key])
    {
        [dic removeObjectForKey:key];
        [dic setObject:obj forKey:key];
    }else
    {
        [dic setObject:obj forKey:key];
    }
     [dic writeToFile:[self creatCofigurationFile] atomically:YES];
}

+ (id)getConfig:(id)key
{
    NSMutableDictionary *dic  = [self getLocalConfigurationFile];
    if (key == nil || [key isEqualToString:@""]) {
        NSLog(@"配置参数的key为空");
        return nil;
    }
    if ([[dic allKeys]containsObject:key])
    {
        return [dic objectForKey:key];
    }
    return nil;
}
@end
