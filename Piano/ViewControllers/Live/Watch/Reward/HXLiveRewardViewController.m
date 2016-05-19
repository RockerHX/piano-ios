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
#import "HXSectorSlider.h"
#import "HXAlbumModel.h"
#import "UIImageView+WebCache.h"


@interface HXLiveRewardViewController () <
HXSectorSliderDelegate
>
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
    [self updateAlbumContainer];
}

#pragma mark - Event Response
- (IBAction)rewardButtonPressed {
    ;
}

#pragma mark - Public Methods
- (void)showOnViewController:(UIViewController *)viewController {
    [viewController addChildViewController:self];
    [viewController.view addSubview:self.view];
}

#pragma mark - Private Methods
- (void)updateAlbumContainer {
    [_albumCover sd_setImageWithURL:[NSURL URLWithString:_album.coverUrl]];
    _albumTitleLabel.text = _album.title;
    _artistNameLabel.text = _album.nickName;
    _rewardPersonCountLabel.text = @(_album.rewardTotal).stringValue;
}

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

#pragma mark - HXSectorSliderDelegate Methods
- (void)sectorSlider:(HXSectorSlider *)slider selectedLevel:(HXSectorSliderLevel)level {
    NSInteger rewardCount = 0;
    switch (level) {
        case HXSectorSliderLevelLow: {
            rewardCount = 10;
            break;
        }
        case HXSectorSliderLevelNormal: {
            rewardCount = 20;
            break;
        }
        case HXSectorSliderLevelMedium: {
            rewardCount = 30;
            break;
        }
        case HXSectorSliderLevelHigh: {
            rewardCount = 50;
            break;
        }
        case HXSectorSliderLevelVeryHigh: {
            rewardCount = 100;
            break;
        }
    }
    _rewardCountLabel.text = @(rewardCount).stringValue;
}

@end
