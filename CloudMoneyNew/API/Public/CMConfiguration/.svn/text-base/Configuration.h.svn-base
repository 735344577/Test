//
//  Configuration.h
//  HxForexApp
//
//  Created by guochong on 12-12-3.
//
//

#import <Foundation/Foundation.h>

//添加提醒标识
#define isJingPinRemind @"isJingPinRemind"
#define isSanBiaoRemind @"isSanBiaoRemind"
#define JingPinRemind   @"JingPinRemind"
#define SanBiaoRemind   @"SanBiaoRemind"

//信贷添加提醒标识
#define XinDaiRemind    @"XinDaiRemind"
#define isXinDaiRemind  @"isXinDaiRemind"

//线下标  东方红  和  任逍遥  添加提醒标识
#define XianXiaRemind   @"isXianXiaRemind"
#define isXianXiaRemind @"isXianXiaRemind"


@interface Configuration : NSObject

//创建配置文件，返回配置文件的路径参数
+ (NSString *) creatCofigurationFile;
//创建配置文件，返回配置文件的路径参数(创建文件夹)
+ (NSString *) creatCofigurationFiles:(NSString *)str;
//创建配置文件，返回配置文件的路径参数(创建文件)
+ (NSString *) creatCofigurationFile:(NSString *)str;


//得到本地配置文件参数，返回数组实例
+ (NSMutableDictionary *)getLocalConfigurationFile:(NSString *)str;
+ (NSMutableDictionary *)getLocalConfigurationFile;
//第一次运行时赋予原始默认数据
+ (void)setConfigInfo;
+ (void)setConfigWithObj:(id)obj key:(id)key;
+ (id)getConfig:(id)key;
@end
