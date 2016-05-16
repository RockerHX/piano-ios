//
//  HXZegoAVKitManager.m
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXZegoAVKitManager.h"


@interface HXZegoAVKitManager ()
@end


@implementation HXZegoAVKitManager

#pragma mark - Singleton Methods
+ (instancetype)manager {
    static HXZegoAVKitManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HXZegoAVKitManager alloc] init];
    });
    return manager;
}

+ (instancetype)shareWithAppID:(NSString *)appID signKey:(NSData *)signKey {
    HXZegoAVKitManager *manager = [self manager];
    [manager setAppID:appID signKey:signKey];
    return manager;
}

#pragma mark - Initialize Methods
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initConfigure];
    }
    return self;
}

#pragma mark - Configure Methods
- (void)initConfigure {
//    _zegoLiveApi = [[ZegoLiveApi alloc] initWithAppID:1 appSignature:[self zegoAppSignFromServer]];
    _zegoLiveApi = [[ZegoLiveApi alloc] initWithAppID:1533641591 appSignature:[self zegoAppSignFromServer]];
    [ZegoLiveApi setLogLevel:4];
}

#pragma mark - Public Methods
- (void)setAppID:(NSString *)appID signKey:(NSData *)signKey {
    _appID = appID;
    _signKey = signKey;
}

- (void)setServer:(NSString *)server port:(NSString *)port url:(NSString *)url {
    _server = server;
    _port = port;
    _url = url;
}

- (void)fetchShowList:(void(^)(HXZegoAVKitManager *manager, BOOL success))completed failure:(void(^)(HXZegoAVKitManager *manager, NSString *message))failure {
    ;
}

- (void)fetchReplayList:(void(^)(HXZegoAVKitManager *manager, BOOL success))completed failure:(void(^)(HXZegoAVKitManager *manager, NSString *message))failure {
    ;
}

#pragma mark - Private Methods
- (NSData *)zegoAppSignFromServer {
    //!! Demo 把signKey先写到代码中
    //!! 规范用法：这个signKey需要从server下发到App，避免在App中存储，防止盗用
    
//    Byte signkey[] = {0x91,0x93,0xcc,0x66,0x2a,0x1c,0xe,0xc1,
//                      0x35,0xec,0x71,0xfb,0x7,0x19,0x4b,0x38,
//                      0x15,0xf1,0x43,0xf5,0x7c,0xd2,0xb5,0x9a,
//                      0xe3,0xdd,0xdb,0xe0,0xf1,0x74,0x36,0xd};
    Byte signkey[] = {0x6b,0xdf,0x57,0x6,0x6,0xc5,0xa6,0x69,
                      0xf5,0xf3,0x4b,0xc,0x8e,0xf3,0xd0,0x1c,
                      0x96,0x98,0x5e,0x7c,0x5f,0x53,0xc5,0xaf,
                      0xef,0x0,0x5b,0xd2,0xbd,0xa0,0x3d,0xa7};
    NSData * appSign = [[NSData alloc] initWithBytes:signkey length:32];
    
    return appSign;
}

@end
