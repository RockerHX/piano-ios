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
    [[HXGiftManager manager] fetchGiftList:^(HXGiftManager *manager) {
        _giftList = manager.giftList;
        _conianerHeightConstraint.constant = _container.contianerHeight;
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

- (void)countChanged:(KxMenuItem *)item {
    NSLog(@"%@", item.title);
}

#pragma mark - Private Methods
- (void)updateControlContainer {
    _balanceCountLabel.text = [MIAMCoinManage shareMCoinManage].mCoin;
}

- (void)popUp {
    _bottomConstraint.constant = _controlContainerHeightConstraint.constant + _container.contianerHeight;
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
