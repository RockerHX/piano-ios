//
//  HXLoginViewModel.m
//  Piano
//
//  Created by miaios on 16/3/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLoginViewModel.h"
#import "MiaAPIHelper.h"


@implementation HXLoginViewModel

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
    _account = [HXAccountModel new];
    
    @weakify(self)
    _enableLoginSignal = [RACSignal combineLatest:@[RACObserve(_account, mobile), RACObserve(_account, password)] reduce:^id(NSString *mobile, NSString *password) {
        return @(mobile.length && password.length);
    }];
    
    _weixinLoginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self startWeiXinLoginAuthorizeWithSubscriber:subscriber];
            return nil;
        }];
    }];
    
    _normalLoginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self startNormalLoginRequestWithSubscriber:subscriber];
            return nil;
        }];
    }];
}

#pragma mark - Private Methods
- (BOOL)checkMobile:(NSString *)mobile {
    if (mobile.length == 11
        && [mobile rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]].location != NSNotFound) {
        return YES;
    }
    return NO;
}

- (void)startWeiXinLoginAuthorizeWithSubscriber:(id<RACSubscriber>)subscriber {
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        switch (state) {
            case SSDKResponseStateBegin: {
                break;
            }
            case SSDKResponseStateSuccess: {
                _account.sdkUser = user;
                [self startWeiXinLoginRequestWithSubscriber:subscriber];
                break;
            }
            case SSDKResponseStateFail: {
                [subscriber sendError:error];
                break;
            }
            case SSDKResponseStateCancel: {
                [subscriber sendError:[NSError errorWithDomain:@"用户取消" code:0 userInfo:nil]];
                break;
            }
        }
    }];
}

- (void)startWeiXinLoginRequestWithSubscriber:(id<RACSubscriber>)subscriber {
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
//             [subscriber sendNext:userInfo[MiaAPIKey_Values]];
//             [subscriber sendCompleted];
//         } else {
//             [subscriber sendError:userInfo[MiaAPIKey_Values][MiaAPIKey_Error]];
//         }
//     } timeoutBlock:^(MiaRequestItem *requestItem) {
//         [subscriber sendError:TimtOutPrompt];
//     }];
}

- (void)startNormalLoginRequestWithSubscriber:(id<RACSubscriber>)subscriber {
    if ([self checkMobile:_account.mobile]) {
//        [MiaAPIHelper loginWithPhoneNum:mobile
//                           passwordHash:[NSString md5HexDigest:password]
//                          completeBlock:
//         ^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
//             if (success) {
//                 [subscriber sendNext:userInfo[MiaAPIKey_Values]];
//                 [subscriber sendCompleted];
//             } else {
//                 [subscriber sendError:userInfo[MiaAPIKey_Values][MiaAPIKey_Error]];
//             }
//         } timeoutBlock:^(MiaRequestItem *requestItem) {
//             [subscriber sendError:TimtOutPrompt];
//         }];
    } else {
        [subscriber sendError:[NSError errorWithDomain:MobileErrorPrompt code:0 userInfo:nil]];
    }
}

@end
