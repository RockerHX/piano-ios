//
//  JOFDeviceInfo.h
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/10/26.
//  Copyright © 2015年 刘维. All rights reserved.
//

#import "JOFunctionObject.h"

/*设备的类型*/
typedef NS_ENUM(NSInteger, DeviceType){
    
    DeviceType_Simulator,
    
    DeviceType_Iphone2G,
    DeviceType_Iphone3G,
    DeviceType_Iphone3GS,
    DeviceType_Iphone4,
    DeviceType_Iphone4s,
    DeviceType_Iphone5,
    DeviceType_Iphone5c,
    DeviceType_Iphone5s,
    DeviceType_Iphonese,
    DeviceType_Iphone6,
    DeviceType_Iphone6plus,
    DeviceType_Iphone6s,
    DeviceType_Iphone6splus,
    
    DeviceType_Ipod1G,
    DeviceType_Ipod2G,
    DeviceType_Ipod3G,
    DeviceType_Ipod4G,
    DeviceType_Ipod5G,
    DeviceType_Ipod6G,
    
    DeviceType_Ipad1,
    DeviceType_Ipad2,
    DeviceType_Ipad3,
    DeviceType_Ipad4,
    
    DeviceType_IpadAir,
    DeviceType_IpadAir2,
    
    DeviceType_IpadPro,
    
    DeviceType_IpadMini1,
    DeviceType_IpadMini2,
    DeviceType_IpadMini3,
    DeviceType_IpadMini4,
    
    DeviceType_Unknown,
};

typedef NS_ENUM(NSInteger, SystemVersion){
    
    IOS_Low,
    IOS_4,
    IOS_5,
    IOS_6,
    IOS_7,
    IOS_8,
    IOS_9,
    IOS_Height,
};

@interface JOFDeviceInfo : JOFunctionObject

/**
 *  当前设备是5s以上的设备.PS 根据设备的大小来区分,所以SE归到了5s以下的设备下面.
 *
 *  @return 是否是那种的状态值.
 */
//+ (BOOL)deviceOveriPhone5s;

/**
 *  获取设备具体的类型.
 *
 *  @return DeviceType
 */
+ (DeviceType)deviceType;

/**
 *  获取设备的名称.
 *
 *  @return 设备的名称
 */
+ (NSString *)deviceName;

/**
 *  获取当前系统的版本号.
 *
 *  @return 版本号.
 */
+ (CGFloat)currentSystemVersion;

/**
 *  获取系统的大的版本号.
 *
 *  @return SystemVersion
 */
+ (SystemVersion)systemVersion;

/**
 *  获取设备的名字. e.g:***的iphone.
 *
 *  @return 设备的名字.
 */
+ (NSString *)deviceUserName;

@end
