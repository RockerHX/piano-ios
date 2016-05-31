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
#import "HXMobileLoginViewController.h"


@interface HXLoginViewController ()
@end


@implementation HXLoginViewController {
    BOOL _shouldHideNavigationBar;
    
    HXLoginViewModel *_viewModel;
}

#pragma mark - Class Methods
+ (NSString *)navigationControllerIdentifier {
    return @"HXLoginNavigationController";
}

+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameLogin;
}

#pragma mark - Segue Methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _shouldHideNavigationBar = [segue.destinationViewController isKindOfClass:[HXMobileLoginViewController class]];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    ;
}

- (void)viewConfigure {
    ;
}

#pragma mark - Event Response
- (IBAction)weixinButtonPressed {
    [self startWeiXinLoginRequest];
}

#pragma mark - Private Methods
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
