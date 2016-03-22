//
//  HXVersion.h
//
//  Created by RockerHX
//  Copyright (c) Andy Shaw. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, HXSystemVersion) {
    HXSystemVersionUnknow,
    HXSystemVersionTooOld,
    HXSystemVersionTooNew,
    HXSystemVersionIOS4,
    HXSystemVersionIOS5,
    HXSystemVersionIOS6,
    HXSystemVersionIOS7,
    HXSystemVersionIOS8,
    HXSystemVersionIOS9
};

typedef NS_ENUM(NSUInteger, HXDeviceType) {
    HXDeviceTypeUnknow,
    HXDeviceTypeIPhone,
    HXDeviceTypeIPad,
    HXDeviceTypeIPhoneSimulator,
    HXDeviceTypeIPadSimulator
};

typedef NS_ENUM(NSUInteger, HXDeviceModelType) {
    HXDeviceModelTypeUnknow,
    HXDeviceModelTypeIPad,
    HXDeviceModelTypeIphone4_4S,
    HXDeviceModelTypeIphone5_5S,
    HXDeviceModelTypeIphone5SPrior,
    HXDeviceModelTypeIphone6,
    HXDeviceModelTypeIphone6Plus
};


@interface HXVersion : NSObject

/**
 *  获取App主版本号
 *
 *  @return 主版本号
 */
+ (NSString *)appVersion;

/**
 *  获取App构建版本号
 *
 *  @return 构建版本号
 */
+ (NSString *)appBuildVersion;

/**
 *  获取当前系统版本
 *
 *  @return 系统版本号
 */
+ (CGFloat)currentSystemVersion;

/**
 *  获取当前系统大版本
 *
 *  @return 系统大版本号
 */
+ (HXSystemVersion)systemVersion;

/**
 *  获取当前设备类型
 *
 *  @return 设备类型
 */
+ (HXDeviceType)deviceType;

/**
 *  获取当前机型
 *
 *  @return 设备机型
 */
+ (HXDeviceModelType)currentModel;

/**
 *  当前设备是否是5S及其以前的设备
 */
+ (BOOL)isIPhone5SPrior;

@end
