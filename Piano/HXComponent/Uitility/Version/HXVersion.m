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

+ (HXSystemVersion)systemVersion {
    CGFloat version = [self currentSystemVersion];
    if (version >= 10.0f) {
        return HXSystemVersionTooNew;
    } else if (version >= 9.0f && version < 10.0f) {
        return HXSystemVersionIOS9;
    } else if (version >= 8.0f && version < 9.0f) {
        return HXSystemVersionIOS8;
    } else if (version >= 7.0f && version < 8.0f) {
        return HXSystemVersionIOS7;
    } else if (version >= 6.0f && version < 7.0f) {
        return HXSystemVersionIOS6;
    } else if (version >= 5.0f && version < 6.0f) {
        return HXSystemVersionIOS5;
    } else if (version >= 4.0f && version < 5.0f) {
        return HXSystemVersionIOS4;
    } else {
        return HXSystemVersionTooOld;
    }
}

+ (HXDeviceType)deviceType {
    NSString *type = [UIDevice currentDevice].model;
    if ([type isEqualToString:@"iPhone"]) {
        return HXDeviceTypeIPhone;
    } else if ([type isEqualToString:@"iPhone Simulator"]) {
        return HXDeviceTypeIPhoneSimulator;
    } else if ([type isEqualToString:@"iPad"]) {
        return HXDeviceTypeIPad;
    } else if ([type isEqualToString:@"iPad Simulator"]) {
        return HXDeviceTypeIPadSimulator;
    }
    return HXDeviceTypeUnknow;
}

+ (HXDeviceModelType)currentModel {
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    HXDeviceType deviceType = [self deviceType];
    if ((deviceType == HXDeviceTypeIPhone) || (deviceType == HXDeviceTypeIPhoneSimulator)) {
        if (fabs(screenHeight - 480.0f) < __DBL_EPSILON__) {
            return HXDeviceModelTypeIphone4_4S;
        } else if (fabs(screenHeight - 568.0f) < __DBL_EPSILON__) {
            return HXDeviceModelTypeIphone5_5S;
        } else if (fabs(screenHeight - 667.0f) < __DBL_EPSILON__) {
            return HXDeviceModelTypeIphone6;
        } else if (fabs(screenHeight - 736.0f) < __DBL_EPSILON__) {
            return HXDeviceModelTypeIphone6Plus;
        } else {
            return HXDeviceModelTypeUnknow;
        }
    }
    return HXDeviceModelTypeIPad;
}

+ (BOOL)isIPhone5SPrior {
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    HXDeviceType deviceType = [self deviceType];
    if ((deviceType == HXDeviceTypeIPhone) || (deviceType == HXDeviceTypeIPhoneSimulator)) {
        if ((fabs(screenHeight - 480.0f) < __DBL_EPSILON__) || (fabs(screenHeight - 568.0f) < __DBL_EPSILON__)) return YES;
    }
    return NO;
}

@end
