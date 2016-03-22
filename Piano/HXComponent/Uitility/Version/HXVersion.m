//
//  HXVersion.m
//
//  Created by RockerHX
//  Copyright (c) Andy Shaw. All rights reserved.
//

#import "HXVersion.h"

@implementation HXVersion

#pragma mark - Public Methods
+ (NSString *)appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBuildVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (CGFloat)currentSystemVersion {
    return [[UIDevice currentDevice].systemVersion floatValue];
}

+ (SCSystemVersion)systemVersion {
    CGFloat version = [self currentSystemVersion];
    if (version >= 10.0f) {
        return SCSystemVersionTooNew;
    } else if (version >= 9.0f && version < 10.0f) {
        return SCSystemVersionIOS9;
    } else if (version >= 8.0f && version < 9.0f) {
        return SCSystemVersionIOS8;
    } else if (version >= 7.0f && version < 8.0f) {
        return SCSystemVersionIOS7;
    } else if (version >= 6.0f && version < 7.0f) {
        return SCSystemVersionIOS6;
    } else if (version >= 5.0f && version < 6.0f) {
        return SCSystemVersionIOS5;
    } else if (version >= 4.0f && version < 5.0f) {
        return SCSystemVersionIOS4;
    } else {
        return SCSystemVersionTooOld;
    }
}

+ (SCDeviceType)deviceType {
    NSString *type = [UIDevice currentDevice].model;
    if ([type isEqualToString:@"iPhone"]) {
        return SCDeviceTypeIPhone;
    } else if ([type isEqualToString:@"iPhone Simulator"]) {
        return SCDeviceTypeIPhoneSimulator;
    } else if ([type isEqualToString:@"iPad"]) {
        return SCDeviceTypeIPad;
    } else if ([type isEqualToString:@"iPad Simulator"]) {
        return SCDeviceTypeIPadSimulator;
    }
    return SCDeviceTypeUnknow;
}

+ (SCDeviceModelType)currentModel {
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    SCDeviceType deviceType = [self deviceType];
    if ((deviceType == SCDeviceTypeIPhone) || (deviceType == SCDeviceTypeIPhoneSimulator)) {
        if (fabs(screenHeight - 480.0f) < __DBL_EPSILON__) {
            return SCDeviceModelTypeIphone4_4S;
        } else if (fabs(screenHeight - 568.0f) < __DBL_EPSILON__) {
            return SCDeviceModelTypeIphone5_5S;
        } else if (fabs(screenHeight - 667.0f) < __DBL_EPSILON__) {
            return SCDeviceModelTypeIphone6;
        } else if (fabs(screenHeight - 736.0f) < __DBL_EPSILON__) {
            return SCDeviceModelTypeIphone6Plus;
        } else {
            return SCDeviceModelTypeUnknow;
        }
    }
    return SCDeviceModelTypeIPad;
}

+ (BOOL)isIPhone5SPrior {
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    SCDeviceType deviceType = [self deviceType];
    if ((deviceType == SCDeviceTypeIPhone) || (deviceType == SCDeviceTypeIPhoneSimulator)) {
        if ((fabs(screenHeight - 480.0f) < __DBL_EPSILON__) || (fabs(screenHeight - 568.0f) < __DBL_EPSILON__)) return YES;
    }
    return NO;
}

@end
