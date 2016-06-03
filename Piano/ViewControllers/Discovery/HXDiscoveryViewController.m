//
//  HXDiscoveryViewController.m
//  Piano
//
//  Created by miaios on 16/3/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDiscoveryViewController.h"
#import "HXDiscoveryContainerViewController.h"
#import "HXRecordLiveViewController.h"
#import "HXWatchLiveViewController.h"
#import "HXReplayViewController.h"
#import "HXPlayViewController.h"
#import "HXUserSession.h"
#import "HXAlbumsViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MusicMgr.h"
#import "HXDiscoveryTopBar.h"
#import "HXLoadingView.h"
#import "HXDiscoveryViewModel.h"
#import "UIImageView+WebCache.h"
#import "FXBlurView.h"
#import "MIAProfileViewController.h"
#import "HXHostProfileViewController.h"
#import "UIButton+WebCache.h"
#import "MiaAPIHelper.h"
#import "HXLiveModel.h"


@interface HXDiscoveryViewController () <
HXDiscoveryTopBarDelegate,
HXDiscoveryContainerDelegate
>
@end


@implementation HXDiscoveryViewController {
    HXDiscoveryContainerViewController *_containerViewController;
    
    HXDiscoveryViewModel *_viewModel;
    
    NSInteger _itemCount;
    HXLoadingView *_loadingView;
}

#pragma mark - Segue Methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _containerViewController = segue.destinationViewController;
    _containerViewController.delegate = self;
}

#pragma mark - View Controller Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _topBar.musicButton.hidden = ![MusicMgr standard].playList.count;
    [_topBar.profileButton sd_setImageWithURL:[NSURL URLWithString:[HXUserSession session].user.avatarUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"D-ProfileEntryIcon"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    _itemCount = 20;
    
    _viewModel = [[HXDiscoveryViewModel alloc] init];
    _containerViewController.viewModel = _viewModel;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startFetchList) name:UIApplicationDidBecomeActiveNotification object:nil];
}
 
- (void)viewConfigure {
    _loadingView = [HXLoadingView new];
    [_loadingView showOnViewController:self];
}

#pragma mark - Public Methods
- (void)startFetchList {
    @weakify(self)
    RACSignal *requestSiganl = [_viewModel.fetchCommand execute:nil];
    [requestSiganl subscribeError:^(NSError *error) {
        @strongify(self)
        if (![error.domain isEqualToString:RACCommandErrorDomain]) {
            [self showBannerWithPrompt:error.domain];
        }
        self->_loadingView.loadState = HXLoadStateError;
    } completed:^{
        @strongify(self)
        [self fetchCompleted];
    }];
}

- (void)recoveryLive {
    [self hiddenNavigationBar];
    
    [MiaAPIHelper refetchLiveWithCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            HXLiveModel *model = [HXLiveModel mj_objectWithKeyValues:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
            UINavigationController *recordLiveNavigationController = [HXRecordLiveViewController navigationControllerInstance];
            HXRecordLiveViewController *recordLiveViewController = [recordLiveNavigationController.viewControllers firstObject];
            [recordLiveViewController recoveryLive:model];
            [self presentViewController:recordLiveNavigationController animated:YES completion:nil];
        }
    } timeoutBlock:nil];
}

#pragma mark - Private Methods
- (void)fetchCompleted {
    [_containerViewController displayDiscoveryList];
    [_loadingView setLoadState:HXLoadStateSuccess];
    
    [self showCoverWithCoverUrl:[_viewModel.discoveryList firstObject].coverUrl];
}

- (void)showCoverWithCoverUrl:(NSString *)coverUrl {
    __weak __typeof__(self)weakSelf = self;
    [_coverView sd_setImageWithURL:[NSURL URLWithString:coverUrl] completed:
     ^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         __strong __typeof__(self)strongSelf = weakSelf;
         strongSelf.coverView.image = [image blurredImageWithRadius:5.0f iterations:5 tintColor:[UIColor whiteColor]];
     }];
}

- (void)hiddenNavigationBar {
    if (_delegate && [_delegate respondsToSelector:@selector(discoveryViewController:takeAction:)]) {
        [_delegate discoveryViewController:self takeAction:HXDiscoveryViewControllerActionHiddenNavigationBar];
    }
}

- (void)pauseMusic {
    MusicMgr *musicMgr = [MusicMgr standard];
    if (musicMgr.isPlaying) {
        [[MusicMgr standard] pause];
    }
}

#pragma mark - HXDiscoveryTopBarDelegate
- (void)topBar:(HXDiscoveryTopBar *)bar takeAction:(HXDiscoveryTopBarAction)action {
    [self hiddenNavigationBar];
    switch (action) {
        case HXDiscoveryTopBarActionProfile: {
            [self.navigationController pushViewController:[HXHostProfileViewController instance] animated:YES];
            break;
        }
        case HXDiscoveryTopBarActionMusic: {
            UINavigationController *playNavigationController = [HXPlayViewController navigationControllerInstance];
            [self presentViewController:playNavigationController animated:YES completion:nil];
            break;
        }
    }
}

#pragma mark - HXDiscoveryContainerDelegate Methods
- (void)container:(HXDiscoveryContainerViewController *)container takeAction:(HXDiscoveryContainerAction)action model:(HXDiscoveryModel *)model {
    [container stopPreviewVideo];
    switch (action) {
        case HXDiscoveryContainerActionRefresh: {
            [self startFetchList];
            break;
        }
        case HXDiscoveryContainerActionScroll: {
            [self showCoverWithCoverUrl:model.coverUrl];
            break;
        }
        case HXDiscoveryContainerActionStartLive: {
            [self hiddenNavigationBar];
            [self pauseMusic];
            UINavigationController *recordLiveNavigationController = [HXRecordLiveViewController navigationControllerInstance];
            [self presentViewController:recordLiveNavigationController animated:YES completion:nil];
            break;
        }
        case HXDiscoveryContainerActionShowLive: {
            [self hiddenNavigationBar];
            [self pauseMusic];
            UINavigationController *watchLiveNavigationController = [HXWatchLiveViewController navigationControllerInstance];
            HXWatchLiveViewController *watchLiveViewController = [watchLiveNavigationController.viewControllers firstObject];
            watchLiveViewController.roomID = model.roomID;
            [self presentViewController:watchLiveNavigationController animated:YES completion:nil];
            break;
        }
        case HXDiscoveryContainerActionShowStation: {
            [self hiddenNavigationBar];
            MIAProfileViewController *profileViewController = [MIAProfileViewController new];
            [profileViewController setUid:model.uID];
            [self.navigationController pushViewController:profileViewController animated:YES];
            break;
        }
    }
}

@end
