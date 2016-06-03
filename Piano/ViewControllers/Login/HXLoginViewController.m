//
//  HXLoginViewController.m
//  mia
//
//  Created by miaios on 15/11/26.
//  Copyright © 2015年 Mia Music. All rights reserved.
//

#import "HXLoginViewController.h"
#import "HXUserSession.h"
#import "HXMobileLoginViewController.h"


@interface HXLoginViewController () <
HXMobileLoginViewControllerDelegate
>
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
    if ([segue.destinationViewController isKindOfClass:[HXMobileLoginViewController class]]) {
        _shouldHideNavigationBar = YES;
        
        HXMobileLoginViewController *mobileLoginViewController = segue.destinationViewController;
        mobileLoginViewController.delegate = self;
        mobileLoginViewController.bgImage = _bgView.image;
        mobileLoginViewController.viewModel = _viewModel;
    } else {
        _shouldHideNavigationBar = NO;
    }
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
    _viewModel = [HXLoginViewModel new];
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

#pragma mark - HXMobileLoginViewControllerDelegate Methods
- (void)loginSuccessHandleWithData:(NSDictionary *)data {
    [[HXUserSession session] updateUserWithData:data];
    
    if (_delegate && [_delegate respondsToSelector:@selector(loginViewController:takeAction:)]) {
        [_delegate loginViewController:self takeAction:HXLoginViewControllerActionLoginSuccess];
    }
    [self hiddenHUD];
    [self showBannerWithPrompt:@"登录成功"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loginFailureHanleWithPrompt:(NSString *)prompt {
    [self showBannerWithPrompt:prompt];
    [self hiddenHUD];
}

@end
