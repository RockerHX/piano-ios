//
//  HXDiscoveryViewController.m
//  Piano
//
//  Created by miaios on 16/3/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDiscoveryViewController.h"
#import "HXDiscoveryContainerViewController.h"
#import "HXWatchLiveViewController.h"
#import "HXReplayViewController.h"
#import "HXRecordLiveViewController.h"
#import "HXPlayViewController.h"
#import "HXUserSession.h"
#import "HXProfileViewController.h"
#import "HXAlbumsViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MusicMgr.h"
#import "HXDiscoveryTopBar.h"
#import "HXLoadingView.h"
#import "HXDiscoveryViewModel.h"
#import "UIImageView+WebCache.h"
#import "FXBlurView.h"


@interface HXDiscoveryViewController () <
HXDiscoveryTopBarDelegate,
HXDiscoveryContainerViewControllerDelegate
>
@end


@implementation HXDiscoveryViewController {
    HXDiscoveryContainerViewController *_containerViewController;
    
    HXDiscoveryViewModel *_viewModel;
    
    NSInteger _itemCount;
    HXLoadingView *_loadingView;
    
    BOOL _shouldHiddenNavigationBar;
}

#pragma mark - Segue Methods
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
    _itemCount = 20;
    
    _viewModel = [[HXDiscoveryViewModel alloc] init];
    _containerViewController.viewModel = _viewModel;
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

- (void)restoreDisplay {
    [self showMaskContainer:YES];
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

- (void)showMaskContainer:(BOOL)show {
    _coverView.hidden = !show;
    _maskView.hidden = !show;
}

#pragma mark - HXDiscoveryTopBarDelegate
- (void)topBar:(HXDiscoveryTopBar *)bar takeAction:(HXDiscoveryTopBarAction)action {
    switch (action) {
        case HXDiscoveryTopBarActionProfile: {
            if (_delegate && [_delegate respondsToSelector:@selector(discoveryViewControllerHandleMenu:)]) {
                
                [self showMaskContainer:NO];
                [_delegate discoveryViewControllerHandleMenu:self];
            }
            break;
        }
        case HXDiscoveryTopBarActionMusic: {
            if ([MusicMgr standard].playList.count) {
                UINavigationController *playNavigationController = [HXPlayViewController navigationControllerInstance];
                [self presentViewController:playNavigationController animated:YES completion:nil];
            }
            break;
        }
    }
}

#pragma mark - HXDiscoveryContainerViewControllerDelegate Methods
- (void)container:(HXDiscoveryContainerViewController *)container takeAction:(HXDiscoveryContainerAction)action model:(HXDiscoveryModel *)model {
    switch (action) {
        case HXDiscoveryContainerActionScroll: {
            [self showCoverWithCoverUrl:model.coverUrl];
            break;
        }
        case HXDiscoveryContainerActionStartLive: {
            ;
            break;
        }
        case HXDiscoveryContainerActionShowLive: {
            ;
            break;
        }
        case HXDiscoveryContainerActionShowStation: {
            if (_delegate && [_delegate respondsToSelector:@selector(discoveryViewControllerHiddenNavigationBar:)]) {
                [_delegate discoveryViewControllerHiddenNavigationBar:self];
            }
            
            HXProfileViewController *profileViewController = [HXProfileViewController instance];
            profileViewController.uid = model.uID;
            [self.navigationController pushViewController:profileViewController animated:YES];
            break;
        }
    }
}

- (void)container:(HXDiscoveryContainerViewController *)container showLiveByModel:(HXDiscoveryModel *)model {
////    if ([model.uID isEqualToString:[HXUserSession session].uid]) {
////        return;
////    }
//    
//    _shouldHiddenNavigationBar = NO;
//    if (model) {
//        switch (model.type) {
//            case HXDiscoveryTypeLive: {
//                UINavigationController *watchLiveNavigationController = [HXWatchLiveViewController navigationControllerInstance];
//                HXWatchLiveViewController *watchLiveViewController = [watchLiveNavigationController.viewControllers firstObject];
//                watchLiveViewController.roomID = model.ID;
//                [self presentViewController:watchLiveNavigationController animated:YES completion:nil];
//                break;
//            }
//            case HXDiscoveryTypeReplay: {
//                UINavigationController *replayNaviagtionController = [HXReplayViewController navigationControllerInstance];
//                HXReplayViewController *replayViewController = [replayNaviagtionController.viewControllers firstObject];
//                replayViewController.model = model;
//                [self presentViewController:replayNaviagtionController animated:YES completion:nil];
//                break;
//            }
//            case HXDiscoveryTypeNewAlbum: {
//                _shouldHiddenNavigationBar = YES;
//                HXAlbumsViewController *albumsViewController = [HXAlbumsViewController instance];
////                albumsViewController.albumID = model.ID;
//                albumsViewController.albumID = @"1";
//                [self.navigationController pushViewController:albumsViewController animated:YES];
//                break;
//            }
//            case HXDiscoveryTypeVideo: {
//                NSURL *url = [NSURL URLWithString:model.videoUrl];
//                MPMoviePlayerViewController *videoViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
//                [self presentViewController:videoViewController animated:YES completion:nil];
//                break;
//            }
//        }
//    }
}

@end
