//
//  HXVersion.h
//
//  Created by RockerHX
//  Copyright (c) Andy Shaw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SCSystemVersion) {
    SCSystemVersionUnknow,
    SCSystemVersionTooOld,
    SCSystemVersionTooNew,
    SCSystemVersionIOS4,
    SCSystemVersionIOS5,
    SCSystemVersionIOS6,
    SCSystemVersionIOS7,
    SCSystemVersionIOS8,
    SCSystemVersionIOS9
};

typedef NS_ENUM(NSUInteger, SCDeviceType) {
    SCDeviceTypeUnknow,
    SCDeviceTypeIPhone,
    SCDeviceTypeIPad,
    SCDeviceTypeIPhoneSimulator,
    SCDeviceTypeIPadSimulator
};

typedef NS_ENUM(NSUInteger, SCDeviceModelType) {
    SCDeviceModelTypeUnknow,
    SCDeviceModelTypeIPad,
    SCDeviceModelTypeIphone4_4S,
    SCDeviceModelTypeIphone5_5S,
    SCDeviceModelTypeIphone5SPrior,
    SCDeviceModelTypeIphone6,
    SCDeviceModelTypeIphone6Plus
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
+ (SCSystemVersion)systemVersion;

/**
 *  获取当前设备类型
 *
 *  @return 设备类型
 */
+ (SCDeviceType)deviceType;

/**
 *  获取当前机型
 *
 *  @return 设备机型
 */
+ (SCDeviceModelType)currentModel;

/**
 *  当前设备是否是5S及其以前的设备
 */
+ (BOOL)isIPhone5SPrior;

@end
