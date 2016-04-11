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


@interface HXDiscoveryViewController () <
HXDiscoveryContainerViewControllerDelegate
>
@end


@implementation HXDiscoveryViewController {
    HXDiscoveryContainerViewController *_containerViewController;
    
    BOOL _shouldHiddenNavigationBar;
}

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameDiscovery;
}

+ (NSString *)navigationControllerIdentifier {
    return @"HXDiscoveryNavigationController";
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _containerViewController = segue.destinationViewController;
    _containerViewController.delegate = self;
}

#pragma mark - View Controller Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self viewConfigure];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:_shouldHiddenNavigationBar animated:YES];
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
- (IBAction)musicButtonPressed {
    UINavigationController *playNavigationController = [HXPlayViewController navigationControllerInstance];
//    HXPlayViewController *playViewController = [playNavigationController.viewControllers firstObject];
    [self presentViewController:playNavigationController animated:YES completion:nil];
}

#pragma mark - Public Methods
- (void)startFetchList {
    [_containerViewController startFetchDiscoveryList];
}

#pragma mark - HXDiscoveryContainerViewControllerDelegate Methods
- (void)container:(HXDiscoveryContainerViewController *)container showLiveByModel:(HXDiscoveryModel *)model {
//    if ([model.uID isEqualToString:[HXUserSession session].uid]) {
//        return;
//    }
    
    _shouldHiddenNavigationBar = NO;
    if (model) {
        switch (model.type) {
            case HXDiscoveryTypeLive: {
                UINavigationController *watchLiveNavigationController = [HXWatchLiveViewController navigationControllerInstance];
                HXWatchLiveViewController *watchLiveViewController = [watchLiveNavigationController.viewControllers firstObject];
                watchLiveViewController.roomID = model.ID;
                [self presentViewController:watchLiveNavigationController animated:YES completion:nil];
                break;
            }
            case HXDiscoveryTypeReplay: {
                UINavigationController *replayNaviagtionController = [HXReplayViewController navigationControllerInstance];
                HXReplayViewController *replayViewController = [replayNaviagtionController.viewControllers firstObject];
                replayViewController.model = model;
                [self presentViewController:replayNaviagtionController animated:YES completion:nil];
                break;
            }
            case HXDiscoveryTypeNewAlbum: {
                _shouldHiddenNavigationBar = YES;
                HXAlbumsViewController *albumsViewController = [HXAlbumsViewController instance];
//                albumsViewController.albumID = model.ID;
                albumsViewController.albumID = @"1";
                [self.navigationController pushViewController:albumsViewController animated:YES];
                break;
            }
            case HXDiscoveryTypeVideo: {
                NSURL *url = [NSURL URLWithString:model.videoUrl];
                MPMoviePlayerViewController *videoViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
                [self presentViewController:videoViewController animated:YES completion:nil];
                break;
            }
        }
    }
}

- (void)container:(HXDiscoveryContainerViewController *)container showAnchorByModel:(HXDiscoveryModel *)model {
    HXProfileViewController *profileViewController = [HXProfileViewController instance];
    profileViewController.uid = model.uID;
    [self.navigationController pushViewController:profileViewController animated:YES];
}

@end
