#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import <sys/utsname.h>
// 获取手机设备 型号  尺寸 版本
@interface SDiPhoneVersion : NSObject

typedef NS_ENUM(NSInteger, DeviceVersion){
    iPhone4 = 3,
    iPhone4S = 4,
    iPhone5 = 5,
    iPhone5C = 5,
    iPhone5S = 6,
    iPhone6 = 7,
    iPhone6Plus = 8,
    Simulator = 0
};

typedef NS_ENUM(NSInteger, DeviceSize){
    iPhone35inch = 1,
    iPhone4inch = 2,
    iPhone47inch = 3,
    iPhone55inch = 4
};
/**
 获取型号
 */
+(DeviceVersion)deviceVersion;
/**
 获取尺寸
 */
+(DeviceSize)deviceSize;
/**
 获取设备名称
 */
+(NSString*)deviceName;

@end
