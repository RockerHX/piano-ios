//
//  HXOnlineViewController.m
//  Piano
//
//  Created by miaios on 16/3/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXOnlineViewController.h"
#import "HXOnlineContainerViewController.h"
#import "HXWatchLiveViewController.h"
#import "HXReplayViewController.h"


@interface HXOnlineViewController () <
HXOnlineContainerViewControllerDelegate
>
@end


@implementation HXOnlineViewController {
    HXOnlineContainerViewController *_containerViewController;
}

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameOnline;
}

+ (NSString *)navigationControllerIdentifier {
    return @"HXOnlineNavigationController";
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

#pragma mark - Public Methods
- (void)startFetchList {
    [_containerViewController startFetchOnlineList];
}

#pragma mark - HXOnlineContainerViewControllerDelegate Methods
- (void)container:(HXOnlineContainerViewController *)container showLiveByLiveModel:(HXLiveModel *)model {
    if (model) {
        UINavigationController *modalNavigationController = nil;
        switch (model.type) {
            case HXLiveTypeWatchLive: {
                modalNavigationController = [HXWatchLiveViewController navigationControllerInstance];
                HXWatchLiveViewController *watchLiveViewController = [modalNavigationController.viewControllers firstObject];
                watchLiveViewController.model = model;
                break;
            }
            case HXLiveTypeReplay: {
                modalNavigationController = [HXReplayViewController navigationControllerInstance];
                HXReplayViewController *replayViewController = [modalNavigationController.viewControllers firstObject];
                replayViewController.model = model;
                break;
            }
            case HXLiveTypeLive: {
                ;
                break;
            }
        }
        [self presentViewController:modalNavigationController animated:YES completion:nil];
    }
}

@end
