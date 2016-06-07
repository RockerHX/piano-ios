//
//  JOFDeviceInfo.m
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/10/26.
//  Copyright © 2015年 刘维. All rights reserved.
//
//对应的查看对照表
//https://www.theiphonewiki.com/wiki/Models

#import "JOFDeviceInfo.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation JOFDeviceInfo

+ (DeviceType)deviceType{

    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return DeviceType_Iphone2G;
    if ([platform isEqualToString:@"iPhone1,2"]) return DeviceType_Iphone3G;
    if ([platform isEqualToString:@"iPhone2,1"]) return DeviceType_Iphone3GS;
    if ([platform isEqualToString:@"iPhone3,1"]) return DeviceType_Iphone4;
    if ([platform isEqualToString:@"iPhone3,2"]) return DeviceType_Iphone4;
    if ([platform isEqualToString:@"iPhone3,3"]) return DeviceType_Iphone4;
    if ([platform isEqualToString:@"iPhone4,1"]) return DeviceType_Iphone4s;
    if ([platform isEqualToString:@"iPhone5,1"]) return DeviceType_Iphone5;
    if ([platform isEqualToString:@"iPhone5,2"]) return DeviceType_Iphone5;
    if ([platform isEqualToString:@"iPhone5,3"]) return DeviceType_Iphone5c;
    if ([platform isEqualToString:@"iPhone5,4"]) return DeviceType_Iphone5c;
    if ([platform isEqualToString:@"iPhone6,1"]) return DeviceType_Iphone5s;
    if ([platform isEqualToString:@"iPhone6,2"]) return DeviceType_Iphone5s;
    if ([platform isEqualToString:@"iPhone7,1"]) return DeviceType_Iphone6plus;
    if ([platform isEqualToString:@"iPhone7,2"]) return DeviceType_Iphone6;
    if ([platform isEqualToString:@"iPhone8,1"]) return DeviceType_Iphone6s;
    if ([platform isEqualToString:@"iPhone8,2"]) return DeviceType_Iphone6splus;
    if ([platform isEqualToString:@"iPhone8,4"]) return DeviceType_Iphonese;
    
    if ([platform isEqualToString:@"iPod1,1"])   return DeviceType_Ipod1G;
    if ([platform isEqualToString:@"iPod2,1"])   return DeviceType_Ipod2G;
    if ([platform isEqualToString:@"iPod3,1"])   return DeviceType_Ipod3G;
    if ([platform isEqualToString:@"iPod4,1"])   return DeviceType_Ipod4G;
    if ([platform isEqualToString:@"iPod5,1"])   return DeviceType_Ipod5G;
    if ([platform isEqualToString:@"iPod7,1"])   return DeviceType_Ipod6G;
    
    if ([platform isEqualToString:@"iPad1,1"])   return DeviceType_Ipad1;
    
    if ([platform isEqualToString:@"iPad2,1"])   return DeviceType_Ipad2;
    if ([platform isEqualToString:@"iPad2,2"])   return DeviceType_Ipad2;
    if ([platform isEqualToString:@"iPad2,3"])   return DeviceType_Ipad2;
    if ([platform isEqualToString:@"iPad2,4"])   return DeviceType_Ipad2;
    if ([platform isEqualToString:@"iPad2,5"])   return DeviceType_IpadMini1;
    if ([platform isEqualToString:@"iPad2,6"])   return DeviceType_IpadMini1;
    if ([platform isEqualToString:@"iPad2,7"])   return DeviceType_IpadMini1;
    
    if ([platform isEqualToString:@"iPad3,1"])   return DeviceType_Ipad3;
    if ([platform isEqualToString:@"iPad3,2"])   return DeviceType_Ipad3;
    if ([platform isEqualToString:@"iPad3,3"])   return DeviceType_Ipad3;
    if ([platform isEqualToString:@"iPad3,4"])   return DeviceType_Ipad4;
    if ([platform isEqualToString:@"iPad3,5"])   return DeviceType_Ipad4;
    if ([platform isEqualToString:@"iPad3,6"])   return DeviceType_Ipad4;
    
    if ([platform isEqualToString:@"iPad4,1"])   return DeviceType_IpadAir;
    if ([platform isEqualToString:@"iPad4,2"])   return DeviceType_IpadAir;
    if ([platform isEqualToString:@"iPad4,3"])   return DeviceType_IpadAir;
    if ([platform isEqualToString:@"iPad5,3"])   return DeviceType_IpadAir2;
    if ([platform isEqualToString:@"iPad5,4"])   return DeviceType_IpadAir2;
    
    if ([platform isEqualToString:@"iPad6,3"])   return DeviceType_IpadPro;
    if ([platform isEqualToString:@"iPad6,4"])   return DeviceType_IpadPro;
    if ([platform isEqualToString:@"iPad6,7"])   return DeviceType_IpadPro;
    if ([platform isEqualToString:@"iPad6,8"])   return DeviceType_IpadPro;
    
    if ([platform isEqualToString:@"iPad4,4"])   return DeviceType_IpadMini2;
    if ([platform isEqualToString:@"iPad4,5"])   return DeviceType_IpadMini2;
    if ([platform isEqualToString:@"iPad4,6"])   return DeviceType_IpadMini2;
    
    if ([platform isEqualToString:@"iPad4,7"])   return DeviceType_IpadMini3;
    if ([platform isEqualToString:@"iPad4,8"])   return DeviceType_IpadMini3;
    if ([platform isEqualToString:@"iPad4,9"])   return DeviceType_IpadMini3;
    
    if ([platform isEqualToString:@"iPad5,1"])   return DeviceType_IpadMini4;
    if ([platform isEqualToString:@"iPad5,2"])   return DeviceType_IpadMini4;
    
    if ([platform isEqualToString:@"i386"])      return DeviceType_Simulator;
    if ([platform isEqualToString:@"x86_64"])    return DeviceType_Simulator;
    
    return DeviceType_Unknown;
    
}

+ (NSString *)deviceName{

    NSString *deviceName = @"未知设备";
    
    switch ([JOFDeviceInfo deviceType]) {
        case DeviceType_Iphone2G:
            deviceName = @"iPhone2G";
            break;
        case DeviceType_Iphone3G:
            deviceName = @"iPhone3G";
            break;
        case DeviceType_Iphone3GS:
            deviceName = @"iPhone3GS";
            break;
        case DeviceType_Iphone4:
            deviceName = @"iPhone4";
            break;
        case DeviceType_Iphone4s:
            deviceName = @"iPhone4S";
            break;
        case DeviceType_Iphone5:
            deviceName = @"iPhone5";
            break;
        case DeviceType_Iphone5c:
            deviceName = @"iPhone5C";
            break;
        case DeviceType_Iphone5s:
            deviceName = @"iPhone5S";
            break;
        case DeviceType_Iphonese:
            deviceName = @"iPhoneSE";
            break;
        case DeviceType_Iphone6:
            deviceName = @"iPhone6";
            break;
        case DeviceType_Iphone6plus:
            deviceName = @"iPhone6Plus";
            break;
        case DeviceType_Iphone6s:
            deviceName = @"iPhone6S";
            break;
        case DeviceType_Iphone6splus:
            deviceName = @"iPhone6SPlus";
            break;
        case DeviceType_Ipod1G:
            deviceName = @"iPod1G";
            break;
        case DeviceType_Ipod2G:
            deviceName = @"iPod2G";
            break;
        case DeviceType_Ipod3G:
            deviceName = @"iPod3G";
            break;
        case DeviceType_Ipod4G:
            deviceName = @"iPod4G";
            break;
        case DeviceType_Ipod5G:
            deviceName = @"iPod5G";
            break;
        case DeviceType_Ipod6G:
            deviceName = @"iPod6G";
            break;
        case DeviceType_Ipad1:
            deviceName = @"iPad1";
            break;
        case DeviceType_Ipad2:
            deviceName = @"iPad2";
            break;
        case DeviceType_Ipad3:
            deviceName = @"iPad3";
            break;
        case DeviceType_Ipad4:
            deviceName = @"iPad4";
            break;
        case DeviceType_IpadAir:
            deviceName = @"iPadAir";
            break;
        case DeviceType_IpadAir2:
            deviceName = @"iPadAir2";
            break;
        case DeviceType_IpadMini1:
            deviceName = @"iPadMini";
            break;
        case DeviceType_IpadMini2:
            deviceName = @"iPadMini2";
            break;
        case DeviceType_IpadMini3:
            deviceName = @"iPadMini3";
            break;
        case DeviceType_IpadMini4:
            deviceName = @"iPadMini4";
            break;
        case DeviceType_IpadPro:
            deviceName = @"iPadPro";
            break;
        case DeviceType_Simulator:
            deviceName = @"Simulator";
            break;
        default:
            break;
    }
    
    return deviceName;
}

//+ (BOOL)deviceOveriPhone5s{
//
//    if ([JOFDeviceInfo deviceType] == DeviceType_Iphone6 ||
//        [JOFDeviceInfo deviceType] == DeviceType_Iphone6s ||
//        [JOFDeviceInfo deviceType] == DeviceType_Iphone6plus ||
//        [JOFDeviceInfo deviceType] == DeviceType_Iphone6splus) {
//        return NO;
//    }
//}

+ (CGFloat)currentSystemVersion{

    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (SystemVersion)systemVersion{

    CGFloat version = [JOFDeviceInfo currentSystemVersion];
    
    if (version < 4.0)                      return IOS_Low;
    if (version > 4.0 && version < 5.0)     return IOS_4;
    if (version > 5.0 && version < 6.0)     return IOS_5;
    if (version > 6.0 && version < 7.0)     return IOS_6;
    if (version > 7.0 && version < 8.0)     return IOS_7;
    if (version > 8.0 && version < 9.0)     return IOS_8;
    if (version > 9.0 && version < 10.0)    return IOS_9;
    if (version >= 10.0)                    return IOS_Height;
    
    return IOS_Low;
    
}

+ (NSString *)deviceUserName{

    return [[UIDevice currentDevice] name];
}

@end
