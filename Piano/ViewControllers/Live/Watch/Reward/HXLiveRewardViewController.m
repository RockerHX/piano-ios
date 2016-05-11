//
//  HXLiveRewardViewController.m
//  Piano
//
//  Created by miaios on 16/5/11.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveRewardViewController.h"
#import "BlocksKit+UIKit.h"
#import "UIView+Frame.h"


@interface HXLiveRewardViewController ()
@end


@implementation HXLiveRewardViewController

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameLive;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self popUp];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    __weak __typeof__(self)weakSelf = self;
    [_tapView bk_whenTapped:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf dismiss];
    }];
}

- (void)viewConfigure {
    ;
}

#pragma mark - Event Response
- (IBAction)rewardButtonPressed {
    ;
}

#pragma mark - Private Methods
- (void)popUp {
    _bottomConstraint.constant = _containerView.height;
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)dismiss {
    _bottomConstraint.constant = 0.0f;
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

@end
