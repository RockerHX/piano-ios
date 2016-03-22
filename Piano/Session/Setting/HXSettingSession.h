//
//  HXSettingSession.h
//  Piano
//
//  Created by miaios on 16/3/17.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <ZegoAVKit/ZegoAVConfig.h>


@interface HXSettingSession : NSObject

@property (nonatomic, assign, readonly)          ZegoAVConfigPreset  configPreset;
@property (nonatomic, assign, readonly) ZegoAVConfigVideoResolution  resolution;
@property (nonatomic, assign, readonly)        ZegoAVConfigVideoFps  fps;
@property (nonatomic, assign, readonly)    ZegoAVConfigVideoBitrate  bitrate;

@property (nonatomic, assign, readonly) NSInteger  customResolution;
@property (nonatomic, assign, readonly) NSInteger  customFPS;
@property (nonatomic, assign, readonly) NSInteger  customBitrate;

+ (instancetype)share;

- (void)updateConfigPreset:(ZegoAVConfigPreset)preset;

- (void)updateResolution:(ZegoAVConfigVideoResolution)resolution;
- (void)updateFPS:(ZegoAVConfigVideoFps)fps;
- (void)updateBitrate:(ZegoAVConfigVideoBitrate)bitrate;
- (void)updateParametersWithResolution:(ZegoAVConfigVideoResolution)resolution fps:(ZegoAVConfigVideoFps)fps bitrate:(ZegoAVConfigVideoBitrate)bitrate;

- (void)updateCustomResolution:(NSInteger)resolution;
- (void)updateCustomFPS:(NSInteger)fps;
- (void)updateCustomBitrate:(NSInteger)bitrate;
- (void)updateCustomParametersWithResolution:(NSInteger)resolution fps:(NSInteger)fps bitrate:(NSInteger)bitrate;

- (BOOL)isCustomConfigure;

@end
