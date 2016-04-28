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


@interface HXDiscoveryViewController () <
HXDiscoveryTopBarDelegate
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
        [self->_containerViewController displayDiscoveryList];
        self->_loadingView.loadState = HXLoadStateSuccess;
    }];
}

#pragma mark - HXDiscoveryTopBarDelegate
- (void)topBar:(HXDiscoveryTopBar *)bar takeAction:(HXDiscoveryTopBarAction)action {
    switch (action) {
        case HXDiscoveryTopBarActionProfile: {
            if (_delegate && [_delegate respondsToSelector:@selector(discoveryViewControllerHandleMenu:)]) {
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
//- (void)container:(HXDiscoveryContainerViewController *)container showLiveByModel:(HXDiscoveryModel *)model {
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
//}
//
//- (void)container:(HXDiscoveryContainerViewController *)container showAnchorByModel:(HXDiscoveryModel *)model {
//    HXProfileViewController *profileViewController = [HXProfileViewController instance];
//    profileViewController.uid = model.uID;
//    [self.navigationController pushViewController:profileViewController animated:YES];
//}

@end
