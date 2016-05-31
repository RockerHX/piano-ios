//
//  HXMobileLoginViewController.m
//  Piano
//
//  Created by miaios on 16/5/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMobileLoginViewController.h"
#import "BlocksKit+UIKit.h"
#import "FXBlurView.h"


@interface HXMobileLoginViewController ()
@end


@implementation HXMobileLoginViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    RAC(_viewModel.account, mobile) = _mobileTextField.rac_textSignal;
    RAC(_viewModel.account, password) = _passWordTextField.rac_textSignal;
    
    @weakify(self)
    [_viewModel.enableLoginSignal subscribeNext:^(NSNumber *x) {
        @strongify(self)
        BOOL enabled = x.boolValue;
        self.loginButton.enabled = enabled;
        [self.loginButton setTitleColor:(enabled ? [UIColor blackColor] : [UIColor grayColor]) forState:UIControlStateNormal];
    }];
    
    [self.view bk_whenTapped:^{
        @strongify(self)
        [self.view endEditing:YES];
    }];
}

- (void)viewConfigure {
    [_mobileTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_passWordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    _bgView.image = [_bgImage blurredImageWithRadius:10.0f iterations:10.0f tintColor:[UIColor blackColor]];
}

#pragma mark - Event Response
- (IBAction)backButtonPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)loginButtonPressed {
    [self.view endEditing:YES];
    [self startNormalLoginRequest];
}

#pragma mark - Private Methods
- (void)startNormalLoginRequest {
    [self showHUD];
    
    @weakify(self)
    RACSignal *normalLoginSignal = [_viewModel.normalLoginCommand execute:nil];
    [normalLoginSignal subscribeNext:^(NSDictionary *data) {
        @strongify(self)
        if (self.delegate && [self.delegate respondsToSelector:@selector(loginSuccessHandleWithData:)]) {
            [self.delegate loginSuccessHandleWithData:data];
        }
        [self hiddenHUD];
    } error:^(NSError *error) {
        @strongify(self)
        if (self.delegate && [self.delegate respondsToSelector:@selector(loginFailureHanleWithPrompt:)]) {
            [self.delegate loginFailureHanleWithPrompt:error.domain];
        }
        [self hiddenHUD];
    } completed:^{
        ;
    }];
}

@end
