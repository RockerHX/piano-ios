//
//  HXZegoAVKitManager.h
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ZegoAVKit2/ZegoLiveApi.h>


@interface HXZegoAVKitManager : NSObject

@property (nonatomic, assign, readonly) NSString *appID;
@property (nonatomic, strong, readonly)   NSData *signKey;

@property (nonatomic, strong, readonly) NSString *server;
@property (nonatomic, strong, readonly) NSString *port;
@property (nonatomic, strong, readonly) NSString *url;

@property (nonatomic, strong, readonly) ZegoLiveApi *zegoLiveApi;

+ (instancetype)manager;
+ (instancetype)shareWithAppID:(NSString *)appID signKey:(NSData *)signKey;

- (void)setAppID:(NSString *)appID signKey:(NSData *)signKey;
- (void)setServer:(NSString *)server port:(NSString *)port url:(NSString *)url;

- (void)fetchShowList:(void(^)(HXZegoAVKitManager *manager, BOOL success))completed failure:(void(^)(HXZegoAVKitManager *manager, NSString *message))failure;
- (void)fetchReplayList:(void(^)(HXZegoAVKitManager *manager, BOOL success))completed failure:(void(^)(HXZegoAVKitManager *manager, NSString *message))failure;

@end
