//
//  HXUserSession.h
//  Piano
//
//  Created by miaios on 16/3/22.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXUserModel.h"
#import "ReactiveCocoa.h"


NS_ASSUME_NONNULL_BEGIN


FOUNDATION_EXPORT NSString *const kClearNotifyNotifacation;


typedef NS_ENUM(NSUInteger, HXRole) {
    HXRoleUser,
    HXRoleAnchor,
};

typedef NS_ENUM(BOOL, HXUserState) {
    HXUserStateLogout,
    HXUserStateLogin,
};


@interface HXUserSession : NSObject

@property (nonatomic, assign, readonly)        BOOL  notify;
@property (nonatomic, assign, readonly)      HXRole  role;
@property (nonatomic, assign, readonly) HXUserState  state;

@property (nonatomic, strong, readonly)       NSString *uid;
@property (nonatomic, strong, readonly)       NSString *token;
@property (nonatomic, strong, readonly)    HXUserModel *user;

+ (instancetype)session;

- (void)updateUserWithData:(NSDictionary *)data;
- (void)updateUser:(HXUserModel *)user;
- (void)sysnc;
- (void)clearNotify;

- (void)logout;

@end


NS_ASSUME_NONNULL_END
