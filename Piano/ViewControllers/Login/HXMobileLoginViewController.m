//
//  HXMobileLoginViewController.m
//  Piano
//
//  Created by miaios on 16/5/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMobileLoginViewController.h"


@interface HXMobileLoginViewController ()
@end


@implementation HXMobileLoginViewController

#pragma mark - View Controller Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self loadConfigure];
//    [self viewConfigure];
}

#pragma mark - Configure Methods
//- (void)loadConfigure {
//    _viewModel = [HXLoginViewModel new];
//    
//    RAC(_viewModel.account, mobile) = _mobileTextField.rac_textSignal;
//    RAC(_viewModel.account, password) = _passWordTextField.rac_textSignal;
//    RAC(_loginButton, enabled) = [RACSignal combineLatest:@[RACObserve(self, loginAction) , _viewModel.enableLoginSignal] reduce:^id(NSNumber *action, NSNumber *enabled) {
//        HXLoginAction loginAction = action.boolValue;
//        switch (loginAction) {
//            case HXLoginActionCancel: {
//                return @(YES);
//                break;
//            }
//            case HXLoginActionLogin: {
//                return @(enabled.boolValue);
//                break;
//            }
//        }
//    }];
//}
//
//- (void)viewConfigure {
//    [_mobileTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
//    [_passWordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
//}

@end
