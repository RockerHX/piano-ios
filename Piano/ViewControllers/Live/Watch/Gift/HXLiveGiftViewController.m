//
//  HXLiveGiftViewController.m
//  Piano
//
//  Created by miaios on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveGiftViewController.h"
#import "BlocksKit+UIKit.h"
#import "UIView+Frame.h"
#import "MIAMCoinManage.h"
#import "MiaAPIHelper.h"
#import "HXGiftModel.h"


@interface HXLiveGiftViewController ()
@end


@implementation HXLiveGiftViewController {
    NSArray *_giftList;
    UIButton *_selectedButton;
}

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
    
    [_rechargeContainer bk_whenTapped:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf showRechargeSence];
    }];
}

- (void)viewConfigure {
    [MiaAPIHelper getGiftListCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            NSMutableArray *giftList = @[].mutableCopy;
            NSArray *lists = userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
            for (NSDictionary *data in lists) {
                HXGiftModel *gift = [HXGiftModel mj_objectWithKeyValues:data];
                [giftList addObject:gift];
            }
            _giftList = [giftList copy];
        }
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        [self showBannerWithPrompt:TimtOutPrompt];
    }];
    [[MIAMCoinManage shareMCoinManage] updateMCoinWithMCoinSuccess:^{
        [self updateControlContainer];
    } mCoinFailed:nil];
}

#pragma mark - Event Response
- (IBAction)giftButtonPressed:(UIButton *)button {
    if (_giftList.count == 4) {
        BOOL selected = YES;
        _selectedButton.selected = !selected;
        button.selected = selected;
        _selectedButton = button;
    }
}

- (IBAction)giveGiftButtonPressed {
    if (_selectedButton) {
        HXGiftModel *gift = _giftList[_selectedButton.tag];
        NSInteger rewardCount = gift.mcoin;
        NSInteger balanceCount = [MIAMCoinManage shareMCoinManage].mCoin.integerValue;
        if (balanceCount < rewardCount) {
            [self showBannerWithPrompt:@"余额不足，请充值！"];
            return;
        }
        
        [self showHUD];
        [[MIAMCoinManage shareMCoinManage] sendGiftWithGiftID:gift.ID roomID:_roomID success:^{
            [self hiddenHUD];
            [self showBannerWithPrompt:@"打赏成功！"];
            [self dismiss];
        } failed:^(NSString *failed) {
            [self hiddenHUD];
            [self showBannerWithPrompt:@"打赏失败，请检查网络！"];
        } mCoinSuccess:nil mCoinFailed:nil];
    } else {
        [self showBannerWithPrompt:@"请先选择要打赏的礼物！"];
    }
}

#pragma mark - Private Methods
- (void)updateGiftList {
    NSInteger count = _giftList.count;
    if (count == 4) {
        
    }
}

- (void)updateControlContainer {
    _balanceCountLabel.text = [MIAMCoinManage shareMCoinManage].mCoin;
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

- (void)showRechargeSence {
    if (_rechargeDelegate && [_rechargeDelegate respondsToSelector:@selector(shouldShowRechargeSence)]) {
        [_rechargeDelegate shouldShowRechargeSence];
    }
}

@end
