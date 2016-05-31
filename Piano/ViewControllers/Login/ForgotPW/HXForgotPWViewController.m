//
//  HXForgotPWViewController.m
//  Mia
//
//  Created by miaios on 16/1/5.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXForgotPWViewController.h"
#import "HXCaptchButton.h"
#import "HXUserSession.h"
#import "MiaAPIHelper.h"
#import "NSString+MD5.h"

static NSString *CaptchApi = @"/user/pauth";
static NSString *ResetPWApi = @"/user/pauth";

@interface HXForgotPWViewController ()
@end

@implementation HXForgotPWViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    __weak __typeof__(self)weakSelf = self;
    [_captchaButton timingStart:^BOOL(HXCaptchButton *button) {
        __strong __typeof__(self)strongSelf = weakSelf;
        NSString *mobile = strongSelf.mobileTextField.text;

		if ([self checkPhoneNumber]) {
            [strongSelf sendCaptchaRequesetWithMobile:mobile];
			return YES;
		} else {
			return NO;
		}
    } end:nil];
}

- (void)viewConfigure {
    ;
}

#pragma mark - Event Response
- (IBAction)resetButtonPressed {
    if ([self checkPhoneNumber]) {
        if (_captchaTextField.text.length < 4) {
            [self showToastWithMessage:@"请输入正确验证码"];
        } else if (!_passWordTextField.text.length) {
            [self showToastWithMessage:@"请输入登录密码"];
        } else if (![_passWordTextField.text isEqualToString:_confirmTextField.text]) {
            [self showToastWithMessage:@"亲，您输入的两次密码不相同噢"];
        } else {
            [self startResetPWRequestWithMobile:_mobileTextField.text
                                        captcha:_captchaTextField.text
                                       password:_passWordTextField.text];
        }
    }
}

#pragma mark - Private Methods
- (BOOL)checkPhoneNumber {
    NSString *str = _mobileTextField.text;
    if (str.length == 11
        && [str rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]].location != NSNotFound) {
        return YES;
    }
    [self showBannerWithPrompt:@"手机号码不符合规范，请重新输入"];
    return NO;
}

- (void)sendCaptchaRequesetWithMobile:(NSString *)mobile {
    [MiaAPIHelper getVerificationCodeWithType:1
                                  phoneNumber:mobile
                                completeBlock:
     ^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
         if (success) {
             [self showBannerWithPrompt:@"验证码已经发送"];
         } else {
             NSString *error = userInfo[MiaAPIKey_Values][MiaAPIKey_Error];
             [self showBannerWithPrompt:error];
             [_captchaButton stop];
         }
     } timeoutBlock:^(MiaRequestItem *requestItem) {
         [self showBannerWithPrompt:TimtOutPrompt];
         [_captchaButton stop];
     }];
}

- (void)startResetPWRequestWithMobile:(NSString *)mobile captcha:(NSString *)captcha password:(NSString *)password {
    [self showHUD];
    [MiaAPIHelper resetPasswordWithPhoneNum:mobile
                               passwordHash:[NSString md5HexDigest:password]
                                      scode:captcha
                              completeBlock:
     ^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
         if (success) {
             [self resetSuccess];
         } else {
             NSString *error = userInfo[MiaAPIKey_Values][MiaAPIKey_Error];
             [self showBannerWithPrompt:error];
         }

         [self hiddenHUD];
     } timeoutBlock:^(MiaRequestItem *requestItem) {
         [self showBannerWithPrompt:TimtOutPrompt];
         [self hiddenHUD];
     }];
}

- (void)resetSuccessWithData:(NSDictionary *)data {
    [self resetSuccess];
}

- (void)resetSuccess {
    [self showBannerWithPrompt:@"修改密码成功"];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
