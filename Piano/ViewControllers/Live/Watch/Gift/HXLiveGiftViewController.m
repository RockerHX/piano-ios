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
#import "HXLiveGiftContainerViewController.h"


@interface HXLiveGiftViewController ()
@end


@implementation HXLiveGiftViewController {
    NSArray *_giftList;
    
    HXLiveGiftContainerViewController *_container;
}

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameLive;
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _container = segue.destinationViewController;
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
            [self parseGiftListWithLists:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
        }
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        [self showBannerWithPrompt:TimtOutPrompt];
    }];
    [[MIAMCoinManage shareMCoinManage] updateMCoinWithMCoinSuccess:^{
        [self updateControlContainer];
    } mCoinFailed:nil];
}

#pragma mark - Event Response
- (IBAction)giveGiftButtonPressed {
    if (_giftList.count) {
        HXGiftModel *gift = _giftList[_container.selectedIndex];
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
- (void)parseGiftListWithLists:(NSArray *)lists {
    NSMutableArray *giftList = @[].mutableCopy;
    for (NSDictionary *data in lists) {
        HXGiftModel *gift = [HXGiftModel mj_objectWithKeyValues:data];
        [giftList addObject:gift];
    }
    _giftList = [giftList copy];
    _conianerHeightConstraint.constant = _container.contianerHeight;
    _container.gifts = _giftList;
}

- (void)updateControlContainer {
    _balanceCountLabel.text = [MIAMCoinManage shareMCoinManage].mCoin;
}

- (void)popUp {
    _bottomConstraint.constant = _containerView.height + _container.contianerHeight - 200.0f;
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
