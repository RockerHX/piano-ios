//
//  HXUserSession.m
//  Piano
//
//  Created by miaios on 16/3/22.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXUserSession.h"
#import "NSString+MD5.h"
#import "MiaAPIHelper.h"
#import "HXPathManager.h"


NSString *const kClearNotifyNotifacation = @"kClearNotifyNotifacation";

static NSString *UserDataRelativePath = @"/User/";
static NSString *UserDataFileName = @"User.data";

typedef void(^SuccessBlock)(HXUserSession *, NSString *);
typedef void(^FailureBlock)(NSString *);


@implementation HXUserSession {
    SuccessBlock _successBlock;
    FailureBlock _failureBlock;
}

#pragma mark - Class Methods
+ (instancetype)session {
    static HXUserSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [[HXUserSession alloc] init];
    });
    return session;
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
    _user = [self unArchiveUser];
}

#pragma mark - Property
- (BOOL)notify {
    return (_user.notifyCount > 0);
}

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
    return (_user.uID && _user.token);
}

- (NSString *)uid {
	if (self.state == HXUserStateLogout) {
		return _guest.uID;
	} else {
		return _user.uID;
	}
}
- (NSString *)nickName {
	if (self.state == HXUserStateLogout) {
		return _guest.nickName;
	} else {
		return _user.nickName;
	}
}

- (NSString *)token {
    return _user.token;
}

#pragma mark - Public Methods
- (void)updateUserWithData:(NSDictionary *)data {
    HXUserModel *user = [HXUserModel mj_objectWithKeyValues:data];
    [self updateUser:user];
}

- (void)updateUser:(nonnull HXUserModel *)user {
    _user = user;
    [self archiveUser:user];
}

- (void)updateGuest:(HXGuestModel *)user {
	_guest = user;
}

- (void)sysnc {
    [self updateUser:_user];
}

- (void)clearNotify {
    _user.notifyAvatar = nil;
    _user.notifyCount = 0;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kClearNotifyNotifacation object:nil];
}

- (void)logout {
    [self updateUser:[HXUserModel new]];
    [self clearNotify];
}

#pragma mark - Private Methods
- (HXUserModel *)archiveUserWithUserInfo:(NSDictionary *)userInfo {
    HXUserModel *user = [HXUserModel mj_objectWithKeyValues:userInfo];
    return [self archiveUser:user];
}

- (HXUserModel *)archiveUser:(HXUserModel *)user {
    NSString *path = [[HXPathManager manager] storePathWithRelativePath:UserDataRelativePath fileName:UserDataFileName];
    [NSKeyedArchiver archiveRootObject:user toFile:path];
    return user;
}

- (HXUserModel *)unArchiveUser {
    NSString *path = [[HXPathManager manager] storePathWithRelativePath:UserDataRelativePath fileName:UserDataFileName];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

- (void)requestSuccessHandleData:(NSDictionary *)data {
    _user = [self archiveUserWithUserInfo:data];
    
    if (_user) {
        if (_successBlock) {
            _successBlock(self, @"登录成功");
        }
    } else {
        [self handelError:DataParseErrorPrompt];
    }
}

- (void)handelError:(NSString *)error {
    if (error.length) {
        if (_failureBlock) {
            _failureBlock(error);
        }
    } else {
        if (_failureBlock) {
            _failureBlock(UnknowErrorPrompt);
        }
    }
}

- (void)requestTimeOut {
    if (_failureBlock) {
        _failureBlock(TimtOutPrompt);
    }
}

@end
