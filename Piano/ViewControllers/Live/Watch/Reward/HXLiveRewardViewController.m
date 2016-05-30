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
#import "MIAMCoinManage.h"
#import "HexColors.h"


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
    
    [_rechargeContainer bk_whenTapped:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf showRechargeSence];
    }];
}

- (void)viewConfigure {
    _sectorSlider.arcColor = [UIColor hx_colorWithHexRGBAString:@"272A2F"];
    _sectorSlider.sliderColor = [UIColor hx_colorWithHexRGBAString:@"B59B7A"];
    
    [self updateAlbumContainer];
    [[MIAMCoinManage shareMCoinManage] updateMCoinWithMCoinSuccess:^{
        [self updateControlContainer];
    } mCoinFailed:nil];
}

#pragma mark - Event Response
- (IBAction)rewardButtonPressed {
    NSInteger rewardCount = _rewardCountLabel.text.integerValue;
    NSInteger balanceCount = [MIAMCoinManage shareMCoinManage].mCoin.integerValue;
    if (balanceCount < rewardCount) {
        [self showBannerWithPrompt:@"余额不足，请充值！"];
        return;
    }
    
    [self showHUD];
    [[MIAMCoinManage shareMCoinManage] rewardAlbumWithMCoin:_rewardCountLabel.text albumID:_album.ID roomID:_roomID success:^{
        [self hiddenHUD];
        [self showBannerWithPrompt:@"打赏成功！"];
        [self dismiss];
    } failed:^(NSString *failed) {
        [self hiddenHUD];
        [self showBannerWithPrompt:@"打赏失败，请检查网络！"];
    } mCoinSuccess:nil mCoinFailed:nil];
}

#pragma mark - Private Methods
- (void)updateAlbumContainer {
    [_albumCover sd_setImageWithURL:[NSURL URLWithString:_album.coverUrl]];
    _albumTitleLabel.text = _album.title;
    _artistNameLabel.text = _album.nickName;
    _rewardPersonCountLabel.text = @(_album.rewardTotal).stringValue;
}

- (void)updateControlContainer {
    _balanceCountLabel.text = [MIAMCoinManage shareMCoinManage].mCoin;
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showRechargeSence {
    if (_rechargeDelegate && [_rechargeDelegate respondsToSelector:@selector(shouldShowRechargeSence)]) {
        [_rechargeDelegate shouldShowRechargeSence];
    }
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
