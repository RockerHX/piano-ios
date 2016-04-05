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


@interface HXDiscoveryViewController () <
HXDiscoveryContainerViewControllerDelegate
>
@end


@implementation HXDiscoveryViewController {
    HXDiscoveryContainerViewController *_containerViewController;
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
    if ([model.uID isEqualToString:[HXUserSession session].uid]) {
        return;
    }
    
    if (model) {
        UINavigationController *modalNavigationController = nil;
        switch (model.type) {
            case HXDiscoveryTypeLive: {
                modalNavigationController = [HXWatchLiveViewController navigationControllerInstance];
                HXWatchLiveViewController *watchLiveViewController = [modalNavigationController.viewControllers firstObject];
                watchLiveViewController.roomID = model.ID;
                break;
            }
            case HXDiscoveryTypeReplay: {
//                modalNavigationController = [HXReplayViewController navigationControllerInstance];
//                HXReplayViewController *replayViewController = [modalNavigationController.viewControllers firstObject];
//                replayViewController.model = model;
                break;
            }
            case HXDiscoveryTypeNewEntry: {
//                modalNavigationController = [HXRecordLiveViewController navigationControllerInstance];
//                HXRecordLiveViewController *recordLiveViewController = [modalNavigationController.viewControllers firstObject];
//                recordLiveViewController.model = model;
                break;
            }
            case HXDiscoveryTypeVideo: {
//                modalNavigationController = [HXRecordLiveViewController navigationControllerInstance];
//                HXRecordLiveViewController *recordLiveViewController = [modalNavigationController.viewControllers firstObject];
//                recordLiveViewController.model = model;
                break;
            }
        }
        [self presentViewController:modalNavigationController animated:YES completion:nil];
    }
}

- (void)container:(HXDiscoveryContainerViewController *)container showAnchorByModel:(HXDiscoveryModel *)model {
    HXProfileViewController *profileViewController = [HXProfileViewController instance];
    profileViewController.uid = model.uID;
    [self.navigationController pushViewController:profileViewController animated:YES];
}

@end
