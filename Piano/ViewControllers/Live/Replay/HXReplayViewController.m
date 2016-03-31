//
//  HXReplayViewController.m
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXReplayViewController.h"
#import "HXCommentContainerViewController.h"
#import "HXLiveAnchorView.h"
#import "HXReplayBottomBar.h"
#import "HXWatcherBoard.h"


@interface HXReplayViewController () <
HXCommentContainerViewControllerDelegate,
HXLiveAnchorViewDelegate,
HXReplayBottomBarDelegate
>
@end


@implementation HXReplayViewController {
    HXCommentContainerViewController *_containerViewController;
}

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameLive;
}

+ (NSString *)navigationControllerIdentifier {
    return @"HXReplayNavigationController";
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _containerViewController = segue.destinationViewController;
    _containerViewController.delegate = self;
}

#pragma mark - View Controller Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}

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
- (IBAction)closeButtonPressed {
    [self dismiss];
}

#pragma mark - Private Methods
- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - HXCommentContainerViewControllerDelegate Methods
- (void)container:(HXCommentContainerViewController *)container shouldShowWatcher:(id)watcher {
    [HXWatcherBoard showWithWatcher:watcher closed:^{
        ;
    }];
}

#pragma mark - HXLiveAnchorViewDelegate Methods
- (void)anchorView:(HXLiveAnchorView *)anchorView takeAction:(HXLiveAnchorViewAction)action {
    ;
}

#pragma mark - HXReplayBottomBarDelegate Methods
- (void)bottomBar:(HXReplayBottomBar *)bar takeAction:(HXReplayBottomBarAction)action {
    ;
}

@end
