//
//  HXSettingSession.m
//  Piano
//
//  Created by miaios on 16/3/17.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXSettingSession.h"
#import "MJExtension.h"
#import "HXPathManager.h"


static NSString *SettingRelativePath = @"/Setting/";
static NSString *SettingFileName = @"Setting.data";


@implementation HXSettingSession {
    ZegoAVConfig *_configure;
}

MJCodingImplementation

#pragma mark - Singleton Methods
+ (instancetype)session {
    static HXSettingSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [[HXSettingSession alloc] init];
    });
    return session;
}

#pragma mark - Initialize Methods
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initConfigure];
        
        HXSettingSession *session = [self unArchive];
        if (session) {
            self = session;
        } else {
            if ([self isCustomConfigure]) {
                _configPreset = ZegoAVConfigPreset_Generic;
            }
        }
    }
    return self;
}

#pragma mark - Configure Methods
- (void)initConfigure {
    _configPreset = -1;
    _configure = [ZegoAVConfig new];
}

#pragma mark - Property
- (ZegoAVConfig *)configure {
    if ([self isCustomConfigure]) {
        [_configure setVideoResolution:(int)_customResolution];
        [_configure setVideoFPS:(int)_customFPS];
        [_configure setVideoBitrate:(int)_customBitrate];
    } else {
        _configure = [ZegoAVConfig defaultZegoAVConfig:_configPreset];
    }
    return _configure;
}

#pragma mark - Public Methods
- (void)updateConfigPreset:(ZegoAVConfigPreset)preset {
    _configPreset = preset;
    BOOL archiveSuccess = [self archive];
    if (!archiveSuccess) {
        NSLog(@"Setting Data Archive Failure");
    }
}

- (void)updateResolution:(ZegoAVConfigVideoResolution)resolution {
    _resolution = resolution;
    [self archive];
}

- (void)updateFPS:(ZegoAVConfigVideoFps)fps {
    _fps = fps;
    [self archive];
}

- (void)updateBitrate:(ZegoAVConfigVideoBitrate)bitrate {
    _bitrate = bitrate;
    [self archive];
}

- (void)updateParametersWithResolution:(ZegoAVConfigVideoResolution)resolution fps:(ZegoAVConfigVideoFps)fps bitrate:(ZegoAVConfigVideoBitrate)bitrate {
    _resolution = resolution;
    _fps = fps;
    _bitrate = bitrate;
    [self archive];
}

- (void)updateCustomResolution:(NSInteger)resolution {
    _customResolution = resolution;
    [self archive];
}

- (void)updateCustomFPS:(NSInteger)fps {
    _customFPS = fps;
    [self archive];
}

- (void)updateCustomBitrate:(NSInteger)bitrate {
    _customBitrate = bitrate;
    [self archive];
}

- (void)updateCustomParametersWithResolution:(NSInteger)resolution fps:(NSInteger)fps bitrate:(NSInteger)bitrate {
    _customResolution = resolution;
    _customFPS = fps;
    _customBitrate = bitrate;
    [self archive];
}

- (BOOL)isCustomConfigure {
    switch (_configPreset) {
        case ZegoAVConfigPreset_Verylow:
        case ZegoAVConfigPreset_Low:
        case ZegoAVConfigPreset_Generic:
        case ZegoAVConfigPreset_High:
        case ZegoAVConfigPreset_Veryhigh: {
            return NO;
            break;
        }
            
        default: {
            return YES;
            break;
        }
    }
}

#pragma mark - Private Methods
- (BOOL)archive {
    NSString *path = [[HXPathManager manager] storePathWithRelativePath:SettingRelativePath fileName:SettingFileName];
    return [NSKeyedArchiver archiveRootObject:self toFile:path];
}

- (HXSettingSession *)unArchive {
    NSString *path = [[HXPathManager manager] storePathWithRelativePath:SettingRelativePath fileName:SettingFileName];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

@end
