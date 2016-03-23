//
//  HXUserSession.m
//  Piano
//
//  Created by miaios on 16/3/22.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXUserSession.h"


@implementation HXUserSession

#pragma mark - Class Methods
+ (instancetype)session {
    static HXUserSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [[HXUserSession alloc] init];
    });
    return session;
}

#pragma mark - Init Methods
- (instancetype)init {
    self = [super init];
    if (self) {
        ;
    }
    return self;
}

#pragma mark - Property
- (HXRole)role {
    HXRole role;
    switch (self.state) {
        case HXUserStateLogout: {
            role = HXRoleUser;
            break;
        }
        case HXUserStateLogin: {
            ;
            break;
        }
    }
    return role;
}

- (HXUserState)state {
    return HXUserStateLogout;
}

@end
