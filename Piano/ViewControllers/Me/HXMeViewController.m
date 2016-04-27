//
//  HXMeViewController.m
//  Piano
//
//  Created by miaios on 16/3/22.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMeViewController.h"
#import "HXMeNavigationBar.h"
#import "HXMeContainerViewController.h"
#import "HXSettingViewController.h"
#import "HXWatchLiveViewController.h"
#import "HXProfileViewController.h"
#import "HXUserSession.h"


@interface HXMeViewController () <
HXMeNavigationBarDelegate,
HXMeContainerViewControllerDelegate
>
@end


@implementation HXMeViewController {
    HXMeContainerViewController *_containerViewController;
    HXMeViewModel *_viewModel;
    
    BOOL _shouldHideNavigationBar;
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _containerViewController = segue.destinationViewController;
    _containerViewController.delegate = self;
}

#pragma mark - View Controller Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self refresh];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
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
    _containerViewController.viewModel = self.viewModel;
}

- (void)viewConfigure {
    [self showHUD];
}

#pragma mark - Property
- (HXMeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [HXMeViewModel new];
    }
    return _viewModel;
}

#pragma mark - Public Methods
- (void)refresh {
    @weakify(self)
    RACSignal *fetchSignal = [self.viewModel.fetchCommand execute:nil];
    [fetchSignal subscribeError:^(NSError *error) {
        @strongify(self)
        if (![error.domain isEqualToString:RACCommandErrorDomain]) {
            [self showBannerWithPrompt:error.domain];
        }
    } completed:^{
        @strongify(self)
        [self hiddenHUD];
        [self->_containerViewController refresh];
    }];
}

#pragma mark - HXMeNavigationBarDelegate Methods
- (void)navigationBar:(HXMeNavigationBar *)bar action:(HXMeNavigationBarAction)action {
    switch (action) {
        case HXMeNavigationBarActionSetting: {
            _shouldHideNavigationBar = NO;
            HXSettingViewController *settingViewController = [HXSettingViewController instance];
            [self.navigationController pushViewController:settingViewController animated:YES];
            break;
        }
    }
}

#pragma mark - HXMeContainerViewControllerDelegate Methods
- (void)container:(HXMeContainerViewController *)container scrollOffset:(CGFloat)offset {
    [_navigationBar showBottomLine:((offset > 0) ? YES : NO)];
}

- (void)container:(HXMeContainerViewController *)container hanleAttentionAnchor:(HXAttentionModel *)model {
    if (model.live) {
        if (!model.roomID) {
            [self showBannerWithPrompt:@"直播已结束"];
            return;
        }
        
        UINavigationController *watchLiveNavigationController = [HXWatchLiveViewController navigationControllerInstance];
        HXWatchLiveViewController *watchLiveViewController = [watchLiveNavigationController.viewControllers firstObject];
        watchLiveViewController.roomID = model.roomID;
        [self presentViewController:watchLiveNavigationController animated:YES completion:nil];
    } else {
        _shouldHideNavigationBar = YES;
        HXProfileViewController *profileViewController = [HXProfileViewController instance];
        profileViewController.uid = model.uID;
        [self.navigationController pushViewController:profileViewController animated:YES];
    }
}

- (void)container:(HXMeContainerViewController *)container takeAction:(HXMeContainerAction)action {
    switch (action) {
        case HXMeContainerActionAvatarTaped: {
            if ([HXUserSession session].role == HXUserRoleAnchor) {
                _shouldHideNavigationBar = YES;
                HXProfileViewController *profileViewController = [HXProfileViewController instance];
                profileViewController.uid = _viewModel.model.uid;
                [self.navigationController pushViewController:profileViewController animated:YES];
            }
            break;
        }
        case HXMeContainerActionNickNameTaped: {
            ;
            break;
        }
        case HXMeContainerActionSummaryTaped: {
            ;
            break;
        }
    }
}

@end
