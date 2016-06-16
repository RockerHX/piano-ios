//
//  UserSetting.m
//  mia
//
//  Created by linyehui on 2015/09/08.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//
//

#import "UserSetting.h"
#import "UserDefaultsUtils.h"
#import "WebSocketMgr.h"
#import "MusicMgr.h"

NSString * const UserDefaultsKey_PlayWith3G			= @"PlayWith3G";
NSString * const UserDefaultsKey_AutoPlay			= @"AutoPlay";
NSString * const kLocalFilePrefix 					= @"file://";

NSString * const k3GPlayTitle	 					= @"网络连接提醒";
NSString * const k3GPlayMessage	 					= @"您现在使用的是运营商网络，继续播放会产生流量费用。是否允许在2G/3G/4G网络下播放？";
NSString * const k3GPlayAllow		 				= @"允许播放";
NSString * const k3GPlayCancel		 				= @"取消";

@interface UserSetting()

@end

@implementation UserSetting {
}

+ (void)registerUserDefaults {
	NSDictionary *defaultValues = [NSDictionary dictionaryWithObjectsAndKeys:
								   [NSNumber numberWithBool:NO], UserDefaultsKey_PlayWith3G,
								   [NSNumber numberWithBool:YES], UserDefaultsKey_AutoPlay,
								   nil];
	[[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
}

+ (BOOL)playWith3G {
	return [UserDefaultsUtils boolValueWithKey:UserDefaultsKey_PlayWith3G];
}

+ (void)setPlayWith3G:(BOOL)value {
	[UserDefaultsUtils saveBoolValue:value withKey:UserDefaultsKey_PlayWith3G];
}

+ (BOOL)autoPlay {
	return [UserDefaultsUtils boolValueWithKey:UserDefaultsKey_AutoPlay];
}

+ (void)setAutoPlay:(BOOL)value {
	[UserDefaultsUtils saveBoolValue:value withKey:UserDefaultsKey_AutoPlay];
}

+ (BOOL)isAllowedToPlayNowWithURL:(NSString *)url {
	if ([self playWith3G]) {
		return YES;
	}

	if ([[WebSocketMgr standard] isWifiNetwork]) {
		return YES;
	}

	if ([self isLocalFilePrefix:url]) {
		return YES;
	}

	if ([[MusicMgr standard] isPlayWith3GOnceTime]) {
		return YES;
	}

	return NO;
}

+ (BOOL)isLocalFilePrefix:(NSString *)path {
	if ([path hasPrefix:kLocalFilePrefix]) {
		return YES;
	} else {
		return NO;
	}
}

+ (NSString *)pathWithPrefix:(NSString *)orgPath {
	return [NSString stringWithFormat:@"file://%@", orgPath];
}

+ (NSString *)pathWithoutPrefix:(NSString *)orgPath {
	if (![self isLocalFilePrefix:orgPath]) {
		return orgPath;
	}

	NSMutableString *result = [[NSMutableString alloc]initWithString:orgPath];
	[result deleteCharactersInRange:NSMakeRange(0, [kLocalFilePrefix length])];
	return result;
}

@end


