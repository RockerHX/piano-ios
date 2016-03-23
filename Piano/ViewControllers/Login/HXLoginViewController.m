//
//  HXLoginViewController.m
//  mia
//
//  Created by miaios on 15/11/26.
//  Copyright © 2015年 Mia Music. All rights reserved.
//

#import "HXLoginViewController.h"
#import "HXLoginViewModel.h"
#import "HXUserSession.h"
#import "HXAlertBanner.h"

typedef NS_ENUM(BOOL, HXLoginAction) {
    HXLoginActionCancel = NO,
    HXLoginActionLogin = YES
};

@interface HXLoginViewController ()
@end

@implementation HXLoginViewController {
    BOOL _shouldHideNavigationBar;
    HXLoginAction _loginAction;
    
    HXLoginViewModel *_viewModel;
}

#pragma mark - View Controller Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:_shouldHideNavigationBar animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

+ (NSString *)navigationControllerIdentifier {
    return @"HXLoginNavigationController";
}

+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameLogin;
}

#pragma mark - Segue Methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _shouldHideNavigationBar = NO;
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    _viewModel = [HXLoginViewModel new];
    
    RAC(_viewModel.account, mobile) = _mobileTextField.rac_textSignal;
    RAC(_viewModel.account, password) = _passWordTextField.rac_textSignal;
}

- (void)viewConfigure {
    [_mobileTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_passWordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
}

#pragma mark - Event Response
- (IBAction)backButtonPressed {
    _shouldHideNavigationBar = YES;
    switch (_loginAction) {
        case HXLoginActionLogin: {
            [self showAnimation];
            break;
        }
        case HXLoginActionCancel: {
            if (_delegate && [_delegate respondsToSelector:@selector(loginViewController:takeAction:)]) {
                [_delegate loginViewController:self takeAction:HXLoginViewControllerActionDismiss];
            }
            break;
        }
    }
}

- (IBAction)weixinButtonPressed {
    _shouldHideNavigationBar = YES;
    
    __weak __typeof__(self)weakSelf = self;
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        __strong __typeof__(self)strongSelf = weakSelf;
        switch (state) {
            case SSDKResponseStateBegin: {
                break;
            }
            case SSDKResponseStateSuccess: {
                [strongSelf startWeiXinLoginRequestWithUser:user];
                break;
            }
            case SSDKResponseStateFail: {
                [HXAlertBanner showWithMessage:error.description tap:nil];
                break;
            }
            case SSDKResponseStateCancel: {
                [HXAlertBanner showWithMessage:@"用户取消" tap:nil];
                break;
            }
        }
    }];
}

- (IBAction)loginButtonPressed {
    [self.view endEditing:YES];
    _shouldHideNavigationBar = YES;
    
    NSString *mobile = _mobileTextField.text;
    NSString *password = _passWordTextField.text;
    
    switch (_loginAction) {
        case HXLoginActionLogin: {
            if ([self checkPhoneNumber]) {
                if (!password.length) {
                    [self showToastWithMessage:@"请输入登录密码"];
                } else {
                    [self startLoginRequestWithMobile:mobile password:password];
                }
            }
            break;
        }
        case HXLoginActionCancel: {
            [self hiddenAnimation];
            break;
        }
    }
}

#pragma mark - Private Methods
- (void)hiddenAnimation {
    __weak __typeof__(self)weakSelf = self;
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf hiddenOperationWithAction:HXLoginActionLogin];
    } completion:^(BOOL finished) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf hiddenAnimationCompletedWithAction:HXLoginActionLogin];
        [strongSelf loginButtonMoveUpAnimation];
    }];
}

- (void)showAnimation {
    __weak __typeof__(self)weakSelf = self;
    [self loginButtonMoveDownAnimationWithCompletion:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf hiddenAnimationCompletedWithAction:HXLoginActionCancel];
        [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            __strong __typeof__(self)strongSelf = weakSelf;
            [strongSelf hiddenOperationWithAction:HXLoginActionCancel];
        } completion:nil];
    }];
}

- (void)hiddenOperationWithAction:(HXLoginAction)action {
    _loginAction = action;
    
    CGFloat alpha = action ? 0.0f : 1.0f;
    _logoView.alpha = alpha;
    _weixinButton.alpha = alpha;
    _registerView.alpha = alpha;
}

- (void)hiddenAnimationCompletedWithAction:(HXLoginAction)action {
    _loginAction = action;
    
    BOOL hidden = action;
    CGFloat alpha = action ? 1.0f : 0.0f;
    _logoView.hidden = hidden;
    _logoView.alpha = alpha;
    
    _weixinButton.hidden = hidden;
    _weixinButton.alpha = alpha;
    
    _registerView.hidden = hidden;
    _registerView.alpha = alpha;
}

- (void)loginButtonMoveUpAnimation {
    _loginButtonBottomConstraint.constant = 200.0f;
    
    __weak __typeof__(self)weakSelf = self;
    [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf loginButtonMoveOperationWithAction:HXLoginActionLogin];
    } completion:^(BOOL finished) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf loginButtonMoveOperationCompletedWithAction:HXLoginActionLogin];
    }];
}

- (void)loginButtonMoveDownAnimationWithCompletion:(void(^)())completion {
    _loginButtonBottomConstraint.constant = 60.0f;
    
    __weak __typeof__(self)weakSelf = self;
    [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf loginButtonMoveOperationWithAction:HXLoginActionCancel];
    } completion:^(BOOL finished) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf loginButtonMoveOperationCompletedWithAction:HXLoginActionCancel];
        completion();
    }];
}

- (void)loginButtonMoveOperationWithAction:(HXLoginAction)action {
    _loginView.hidden = action ? NO : YES;
    [_loginButton setTitle:(action ? @"登录" : @"Mia账号登录") forState:UIControlStateNormal];
    [self.view layoutIfNeeded];
}

- (void)loginButtonMoveOperationCompletedWithAction:(HXLoginAction)action {
    __weak __typeof__(self)weakSelf = self;
    [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        strongSelf.loginView.alpha = action ? 1.0f : 0.0f;
    } completion:nil];
}

- (BOOL)checkPhoneNumber {
    NSString *str = _mobileTextField.text;
    if (str.length == 11
        && [str rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]].location != NSNotFound) {
        return YES;
    }
    [HXAlertBanner showWithMessage:@"手机号码不符合规范，请重新输入" tap:nil];
    return NO;
}

- (void)startWeiXinLoginRequestWithUser:(SSDKUser *)user {
    [self showHUD];
    [[HXUserSession session] loginWithSDKUser:user success:^(HXUserSession *session, NSString *prompt) {
        [self loginSuccessHandleWithPrompt:prompt];
    } failure:^(NSString *prompt) {
        [self loginFailureHanleWithPrompt:prompt];
    }];
}

- (void)startLoginRequestWithMobile:(NSString *)mobile password:(NSString *)password {
    [self showHUD];
    [[HXUserSession session] loginWithMobile:mobile password:password success:^(HXUserSession *session, NSString *prompt) {
        [self loginSuccessHandleWithPrompt:prompt];
    } failure:^(NSString *prompt) {
        [self loginFailureHanleWithPrompt:prompt];
    }];
}

- (void)loginSuccessHandleWithPrompt:(NSString *)prompt {
    [self hiddenHUD];
    [self showBannerWithPrompt:prompt];
    
    if (_delegate && [_delegate respondsToSelector:@selector(loginViewController:takeAction:)]) {
        [_delegate loginViewController:self takeAction:HXLoginViewControllerActionLoginSuccess];
    }
}

- (void)loginFailureHanleWithPrompt:(NSString *)prompt {
    [self showBannerWithPrompt:prompt];
    [self hiddenHUD];
}

@end
