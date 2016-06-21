//
//  HXLoginViewModel.m
//  Piano
//
//  Created by miaios on 16/3/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLoginViewModel.h"
#import "MiaAPIHelper.h"
#import "NSString+MD5.h"


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
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    snsPlatform.loginClickHandler(nil, [UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            _account.sdkUser = snsAccount;
            [self startWeiXinLoginRequestWithSubscriber:subscriber];
        } else {
            [subscriber sendNext:response.message];
            [subscriber sendCompleted];
        }
    });
}

- (void)startWeiXinLoginRequestWithSubscriber:(id<RACSubscriber>)subscriber {
    UMSocialAccountEntity *user = _account.sdkUser;
    NSString *openID = user.openId;
    NSString *unionID = user.unionId;
    NSString *token = user.accessToken;
    NSString *nickName = user.userName;
    NSString *avatar = user.iconURL;
    NSString *sex = @"0";

    [MiaAPIHelper thirdLoginWithOpenID:openID
                               unionID:unionID
                                 token:token
                              nickName:nickName
                                   sex:sex
                                  type:@"WEIXIN"
                                avatar:avatar
                         completeBlock:
     ^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
         if (success) {
             _useInfo = userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
             [subscriber sendCompleted];
         } else {
             [subscriber sendNext:userInfo[MiaAPIKey_Values][MiaAPIKey_Error]];
         }
     } timeoutBlock:^(MiaRequestItem *requestItem) {
         [subscriber sendNext:TimtOutPrompt];
     }];
}

- (void)startNormalLoginRequestWithSubscriber:(id<RACSubscriber>)subscriber {
    if ([self checkMobile:_account.mobile]) {
        [MiaAPIHelper loginWithMobile:_account.mobile
                           passwordHash:[NSString md5HexDigest:_account.password]
                          completeBlock:
         ^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
             if (success) {
                 _useInfo = userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
                 [subscriber sendCompleted];
             } else {
                 [subscriber sendNext:userInfo[MiaAPIKey_Values][MiaAPIKey_Error]];
             }
         } timeoutBlock:^(MiaRequestItem *requestItem) {
             [subscriber sendNext:TimtOutPrompt];
         }];
    } else {
        [subscriber sendNext:MobileErrorPrompt];
    }
}

@end
