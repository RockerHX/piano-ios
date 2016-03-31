//
//  HXLiveEndViewController.m
//  Piano
//
//  Created by miaios on 16/3/30.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveEndViewController.h"


@interface HXLiveEndViewController ()
@end


@implementation HXLiveEndViewController

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameLive;
}

#pragma mark - Status Bar
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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

#pragma mark - Private Methods
- (IBAction)exitRoomButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(liveEndViewControllerWouldLikeExitRoom:)]) {
        [_delegate liveEndViewControllerWouldLikeExitRoom:self];
    }
}

@end
