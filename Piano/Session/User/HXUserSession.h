//
//  HXUserSession.h
//  Piano
//
//  Created by miaios on 16/3/22.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, HXRole) {
    HXRoleUser,
    HXRoleAnchor,
};

typedef NS_ENUM(BOOL, HXUserState) {
    HXUserStateLogout,
    HXUserStateLogin,
};


@interface HXUserSession : NSObject

@property (nonatomic, assign)      HXRole  role;
@property (nonatomic, assign) HXUserState  state;

+ (instancetype)session;

@end
