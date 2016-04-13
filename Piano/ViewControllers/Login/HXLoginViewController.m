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
    HXLoginActionCancel,
    HXLoginActionLogin,
};


@interface HXLoginViewController ()
@property (nonatomic, assign) HXLoginAction  loginAction;
@end


@implementation HXLoginViewController {
    BOOL _shouldHideNavigationBar;
    
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
    RAC(_loginButton, enabled) = [RACSignal combineLatest:@[RACObserve(self, loginAction) , _viewModel.enableLoginSignal] reduce:^id(NSNumber *action, NSNumber *enabled) {
        HXLoginAction loginAction = action.boolValue;
        switch (loginAction) {
            case HXLoginActionCancel: {
                return @(YES);
                break;
            }
            case HXLoginActionLogin: {
                return @(enabled.boolValue);
                break;
            }
        }
    }];
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
            [self dismissLoginSence];
            if (_delegate && [_delegate respondsToSelector:@selector(loginViewController:takeAction:)]) {
                [_delegate loginViewController:self takeAction:HXLoginViewControllerActionDismiss];
            }
            break;
        }
    }
}

- (IBAction)weixinButtonPressed {
    _shouldHideNavigationBar = YES;
    
    [self startWeiXinLoginRequest];
}

- (IBAction)loginButtonPressed {
    [self.view endEditing:YES];
    _shouldHideNavigationBar = YES;
    
    switch (_loginAction) {
        case HXLoginActionLogin: {
            [self startNormalLoginRequest];
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
    self.loginAction = action;
    
    CGFloat alpha = action ? 0.0f : 1.0f;
    _logoView.alpha = alpha;
    _weixinButton.alpha = alpha;
    _registerView.alpha = alpha;
}

- (void)hiddenAnimationCompletedWithAction:(HXLoginAction)action {
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

- (void)startWeiXinLoginRequest {
    [self showHUD];
    
    @weakify(self)
    RACSignal *weixinLoginSignal = [_viewModel.weixinLoginCommand execute:nil];
    [weixinLoginSignal subscribeNext:^(NSDictionary *data) {
        @strongify(self)
        [self loginSuccessHandleWithData:data];
    } error:^(NSError *error) {
        @strongify(self)
        [self loginFailureHanleWithPrompt:error.domain];
    } completed:^{
        ;
    }];
}

- (void)startNormalLoginRequest {
    [self showHUD];
    
    @weakify(self)
    RACSignal *normalLoginSignal = [_viewModel.normalLoginCommand execute:nil];
    [normalLoginSignal subscribeNext:^(NSDictionary *data) {
        @strongify(self)
        [self loginSuccessHandleWithData:data];
    } error:^(NSError *error) {
        @strongify(self)
        [self loginFailureHanleWithPrompt:error.domain];
    } completed:^{
        ;
    }];
}

- (void)loginSuccessHandleWithData:(NSDictionary *)data {
    [self hiddenHUD];
    
    [[HXUserSession session] updateUserWithData:data];
    
    [self dismissLoginSence];
    if (_delegate && [_delegate respondsToSelector:@selector(loginViewController:takeAction:)]) {
        [_delegate loginViewController:self takeAction:HXLoginViewControllerActionLoginSuccess];
    }
}

- (void)loginFailureHanleWithPrompt:(NSString *)prompt {
    [self hiddenHUD];
    [self showBannerWithPrompt:prompt];
}

@end
