//
//  HXDiscoveryViewController.m
//  Piano
//
//  Created by miaios on 16/3/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDiscoveryViewController.h"
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


@interface HXDiscoveryViewController () <
HXDiscoveryTopBarDelegate
>
@end


@implementation HXDiscoveryViewController {
    NSInteger _itemCount;
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
}
 
- (void)viewConfigure {
    ;
}

#pragma mark - Public Methods
- (void)startFetchList {
    ;
}

#pragma mark - HXDiscoveryTopBarDelegate
- (void)topBar:(HXDiscoveryTopBar *)bar takeAction:(HXDiscoveryTopBarAction)action {
    switch (action) {
        case HXDiscoveryTopBarActionProfile: {
            _menuState = !_menuState;
            
            HXDiscoveryViewControllerAction action = HXDiscoveryViewControllerActionMenuClose;
            if (_menuState) {
                action = HXDiscoveryViewControllerActionMenuOpen;
            }
            
            if (_delegate && [_delegate respondsToSelector:@selector(discoveryViewController:action:)]) {
                [_delegate discoveryViewController:self action:action];
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
