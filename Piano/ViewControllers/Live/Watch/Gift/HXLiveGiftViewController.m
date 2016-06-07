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
#import "KxMenu.h"
#import "HXGiftManager.h"
#import "MIAPaymentViewController.h"


@interface HXLiveGiftViewController ()
@end


@implementation HXLiveGiftViewController {
    HXLiveGiftContainerViewController *_container;
    
    NSArray <HXGiftModel *>*_giftList;
    NSString *_giftCount;
}

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameRewardGift;
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _container = segue.destinationViewController;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    _giftConianerHeightConstraint.constant = _container.contianerHeight;
    [[HXGiftManager manager] fetchGiftList:^(HXGiftManager *manager) {
        _giftList = manager.giftList;
        _container.gifts = _giftList;
    } failure:^(NSString *prompt) {
        [self showBannerWithPrompt:prompt];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    _giftCount = @"1";
    
    __weak __typeof__(self)weakSelf = self;
    [_tapView bk_whenTapped:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf dismiss];
    }];
    
    [_rechargeContainer bk_whenTapped:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf showRechargeSence];
    }];
    
    [_countContainer bk_whenTapped:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf popCountMenu];
    }];
}

- (void)viewConfigure {
    [[MIAMCoinManage shareMCoinManage] updateMCoinWithMCoinSuccess:^{
        [self updateControlContainer];
    } mCoinFailed:nil];
}

#pragma mark - Event Response
- (IBAction)giveGiftButtonPressed {
    NSInteger selectedIndex = _container.selectedIndex;
    if ((_giftList.count) && (selectedIndex >= 0)) {
        HXGiftModel *gift = _giftList[selectedIndex];
        NSInteger rewardCount = gift.mcoin;
        NSInteger balanceCount = [MIAMCoinManage shareMCoinManage].mCoin.integerValue;
        if (balanceCount < rewardCount) {
            [self showBannerWithPrompt:@"余额不足，请充值！"];
            return;
        }
        
        [self showHUD];
        [[MIAMCoinManage shareMCoinManage] sendGiftWithGiftID:gift.ID giftCount:_giftCount roomID:_roomID success:^{
            [self hiddenHUD];
            [self showBannerWithPrompt:@"打赏成功！"];
            [self dismiss];
        } failed:^(NSString *failed) {
            [self hiddenHUD];
            [self showBannerWithPrompt:failed];
        } mCoinSuccess:nil mCoinFailed:nil];
    } else {
        [self showBannerWithPrompt:@"请先选择要打赏的礼物！"];
    }
}

- (void)countChanged:(KxMenuItem *)item {
    NSString *count = item.title;
    _countLabel.text = count;
    _giftCount = count;
}

#pragma mark - Private Methods
- (void)updateControlContainer {
    _balanceCountLabel.text = [MIAMCoinManage shareMCoinManage].mCoin;
}

- (void)dismiss {
    [_giftList enumerateObjectsUsingBlock:^(HXGiftModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = NO;
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showRechargeSence {
    MIAPaymentViewController *paymentViewController = [MIAPaymentViewController new];
    paymentViewController.present = YES;
    [self presentViewController:paymentViewController animated:YES completion:nil];
}

- (void)popCountMenu {
    NSArray *countList = @[@99, @66, @20, @10, @1];
    NSMutableArray *menuItems = @[].mutableCopy;
    [countList enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        KxMenuItem *item = [KxMenuItem menuItem:obj.stringValue image:nil target:self action:@selector(countChanged:)];
        item.alignment = NSTextAlignmentCenter;
        [menuItems addObject:item];
    }];
    CGRect frame = [_countContainer.superview convertRect:_countContainer.frame toView:self.view];
    [KxMenu setTintColor:[UIColor colorWithWhite:0.2f alpha:0.6f]];
    [KxMenu setTitleFont:[UIFont systemFontOfSize:15.0f]];
    [KxMenu showMenuInView:self.view fromRect:frame menuItems:menuItems.copy];
    
    __block UIView *overlay = nil;
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([NSStringFromClass([obj class]) isEqualToString:@"KxMenuOverlay"]) {
            overlay = obj;
            *stop = YES;
        }
    }];
    UIView *menuView = [overlay.subviews firstObject];
    [[menuView.subviews firstObject].subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subView, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([subView isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView = (UIImageView *)subView;
                imageView.image = nil;
            } else if ([subView isKindOfClass:[UILabel class]]) {
                CGPoint center = subView.center;
                center.x = view.center.x;
                subView.center = center;
            }
        }];
    }];
}

@end
