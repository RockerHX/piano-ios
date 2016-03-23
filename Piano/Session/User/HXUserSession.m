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

#pragma mark - Init Methods
- (instancetype)init {
    self = [super init];
    if (self) {
        ;
    }
    return self;
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
    return (_user.uid && _user.token);
}

- (NSString *)uid {
    return _user.uid;
}

#pragma mark - Configure Methods
- (void)initConfigure {
    _user = [self unArchiveUser];
}

#pragma mark - Public Methods
- (void)loginWithSDKUser:(SSDKUser *)user success:(nullable void(^)(HXUserSession *, NSString *))success failure:(nullable void(^)(NSString *))failure {
    _successBlock = success;
    _failureBlock = failure;
    
    [self startWeiXinLoginRequestWithUser:user];
}

- (void)loginWithMobile:(NSString *)mobile password:(NSString *)password success:(nullable void(^)(HXUserSession *, NSString *))success failure:(nullable void(^)(NSString *))failure {
    _successBlock = success;
    _failureBlock = failure;
    
    [self startLoginRequestWithMobile:mobile password:password];
}

- (void)updateUser:(nonnull HXUserModel *)user {
    _user = user;
    [self archiveUser:user];
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

- (void)startWeiXinLoginRequestWithUser:(SSDKUser *)user {
//    NSDictionary *credential = user.credential.rawData;
//    NSString *openID = credential[@"openid"];
//    NSString *unionID = credential[@"unionid"];
//    NSString *token = user.credential.token;
//    NSString *nickName = user.nickname;
//    NSString *avatar = user.icon;
//    NSString *sex = ((user.gender == SSDKGenderUnknown) ? @"0" : @(user.gender + 1).stringValue);
//    
//    [MiaAPIHelper thirdLoginWithOpenID:openID
//                               unionID:unionID
//                                 token:token
//                              nickName:nickName
//                                   sex:sex
//                                  type:@"WEIXIN"
//                                avatar:avatar
//                         completeBlock:
//     ^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
//         if (success) {
//             [self requestSuccessHandleData:userInfo[MiaAPIKey_Values]];
//         } else {
//             [self handelError:userInfo[MiaAPIKey_Values][MiaAPIKey_Error]];
//         }
//     } timeoutBlock:^(MiaRequestItem *requestItem) {
//         [self requestTimeOut];
//     }];
}

- (void)startLoginRequestWithMobile:(NSString *)mobile password:(NSString *)password {
//    [MiaAPIHelper loginWithPhoneNum:mobile
//                       passwordHash:[NSString md5HexDigest:password]
//                      completeBlock:
//     ^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
//         if (success) {
//             [self requestSuccessHandleData:userInfo[MiaAPIKey_Values]];
//         } else {
//             [self handelError:userInfo[MiaAPIKey_Values][MiaAPIKey_Error]];
//         }
//     } timeoutBlock:^(MiaRequestItem *requestItem) {
//         [self requestTimeOut];
//     }];
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
