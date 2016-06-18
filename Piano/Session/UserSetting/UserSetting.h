//
//  UserSetting.h
//  mia
//
//  Created by linyehui on 2015/09/08.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const UserDefaultsKey_PlayWith3G;
extern NSString * const UserDefaultsKey_AutoPlay;

extern NSString * const k3GPlayTitle;
extern NSString * const k3GPlayMessage;
extern NSString * const k3GPlayAllow;
extern NSString * const k3GPlayCancel;

@interface UserSetting : NSObject

+ (void)registerUserDefaults;

+ (BOOL)playWith3G;
+ (void)setPlayWith3G:(BOOL)value;

+ (BOOL)autoPlay;
+ (void)setAutoPlay:(BOOL)value;

+ (BOOL)isAllowedToPlayNowWithURL:(NSString *)url;

+ (BOOL)isLocalFilePrefix:(NSString *)path;
+ (NSString *)pathWithPrefix:(NSString *)orgPath;
+ (NSString *)pathWithoutPrefix:(NSString *)orgPath;

@end
