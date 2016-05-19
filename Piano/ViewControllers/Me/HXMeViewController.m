//
//  HXMeViewController.m
//  Piano
//
//  Created by miaios on 16/3/22.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMeViewController.h"
#import "HXMeContainerViewController.h"
#import "HXSettingViewController.h"
#import "HXWatchLiveViewController.h"
#import "HXUserSession.h"
#import "UIImageView+WebCache.h"
#import "FXBlurView.h"
#import "MIAProfileViewController.h"
#import "MIAPaymentViewController.h"


@interface HXMeViewController () <
HXMeContainerViewControllerDelegate
>
@end


@implementation HXMeViewController {
    HXMeContainerViewController *_containerViewController;
    HXMeViewModel *_viewModel;
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _containerViewController = segue.destinationViewController;
    _containerViewController.delegate = self;
}

#pragma mark - View Controller Life Cycle
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
        [self updateUI];
    }];
}

#pragma mark - Private Methods
- (void)updateUI {
    [self hiddenHUD];
    
    __weak __typeof__(self)weakSelf = self;
    [_coverView sd_setImageWithURL:[NSURL URLWithString:_viewModel.model.avatarUrl] completed:
     ^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        __strong __typeof__(self)strongSelf = weakSelf;
         strongSelf.coverView.image = [image blurredImageWithRadius:5.0f iterations:5 tintColor:[UIColor whiteColor]];
    }];
    [self->_containerViewController refresh];
}

#pragma mark - HXMeContainerViewControllerDelegate Methods
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
        MIAProfileViewController *profileViewController = [MIAProfileViewController new];
        [profileViewController setUid:model.uID];
        [self.navigationController pushViewController:profileViewController animated:YES];
    }
}

- (void)container:(HXMeContainerViewController *)container takeAction:(HXMeContainerAction)action {
    switch (action) {
        case HXMeContainerActionAvatarTaped: {
            if ([HXUserSession session].role == HXUserRoleAnchor) {
                MIAProfileViewController *profileViewController = [MIAProfileViewController new];
                [profileViewController setUid:_viewModel.model.uid];
                [self.navigationController pushViewController:profileViewController animated:YES];
            }
            break;
        }
        case HXMeContainerActionNickNameTaped: {
            ;
            break;
        }
        case HXMeContainerActionSignatureTaped: {
            ;
            break;
        }
        case HXMeContainerActionRecharge: {
            if (_delegate && [_delegate respondsToSelector:@selector(meViewControllerHiddenNavigationBar:)]) {
                [_delegate meViewControllerHiddenNavigationBar:self];
            }
            MIAPaymentViewController *paymentViewController = [MIAPaymentViewController new];
            [self.navigationController pushViewController:paymentViewController animated:YES];
            break;
        }
        case HXMeContainerActionPurchaseHistory: {
            ;
            break;
        }
    }
}

@end
