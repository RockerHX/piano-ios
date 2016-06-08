//
//  HXWatchLiveLandscapeViewController.m
//  Piano
//
//  Created by miaios on 16/6/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXWatchLiveLandscapeViewController.h"
#import "HXWatchLiveBottomBar.h"
#import "HXUserSession.h"
#import "HXModalTransitionDelegate.h"
#import "HXLiveCommentViewController.h"
#import "HXLiveGiftLandscapeViewController.h"
#import "HXLiveRewardLandscapeViewController.h"
#import "HXLiveAnchorView.h"
#import "UIImage+Extrude.h"
#import <UMengSocialCOM/UMSocial.h>
#import "HXAppConstants.h"


@interface HXWatchLiveLandscapeViewController ()
@end


@implementation HXWatchLiveLandscapeViewController {
    HXModalTransitionDelegate *_modalTransitionDelegate;
    HXModalTransitionDelegate *_rightModalTransitionDelegate;
}

#pragma mark - Class Methods
+ (NSString *)navigationControllerIdentifier {
    return @"HXWatchLiveLandscapeNavigationController";
}

#pragma mark - Orientations Methods
- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _modalTransitionDelegate = [HXModalTransitionDelegate new];
    _rightModalTransitionDelegate = [HXModalTransitionDelegate instanceWithDirection:HXModalDirectionRight];
}

#pragma mark - HXWatchLiveBottomBarDelegate Methods
- (void)bottomBar:(HXWatchLiveBottomBar *)bar takeAction:(HXWatchBottomBarAction)action {
    if ([HXUserSession session].state == HXUserStateLogout) {
        [self showLoginSence];
        return;
    }
    
    switch (action) {
        case HXWatchBottomBarActionComment: {
            HXLiveCommentViewController *commentViewController = [HXLiveCommentViewController instance];
            commentViewController.roomID = self.roomID;
            commentViewController.modalPresentationStyle = UIModalPresentationCustom;
            commentViewController.transitioningDelegate = _modalTransitionDelegate;
            [self presentViewController:commentViewController animated:YES completion:nil];
            break;
        }
        case HXWatchBottomBarActionShare: {
            HXLiveModel *model     = self.viewModel.model;
            NSString *shareTitle   = model.shareTitle;
            NSString *shareContent = model.shareContent;
            NSString *shareURL     = model.shareUrl;
            UIImage *shareImage    = [UIImage scaleToSize:[self.anchorView.avatar imageForState:UIControlStateNormal] maxWidthOrHeight:100] ;
            
            //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
            [UMSocialData defaultData].extConfig.title = shareTitle;
            [UMSocialData defaultData].extConfig.wechatSessionData.url = shareURL;
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareURL;
            [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeWeb url:shareURL];
            [UMSocialSnsService presentSnsIconSheetView:self
                                                 appKey:UMengAPPKEY
                                              shareText:shareContent
                                             shareImage:shareImage
                                        shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina]
                                               delegate:nil];
            break;
        }
        case HXWatchBottomBarActionGift: {
            HXLiveGiftLandscapeViewController *giftViewController = [HXLiveGiftLandscapeViewController instance];
            giftViewController.roomID = self.roomID;
            giftViewController.modalPresentationStyle = UIModalPresentationCustom;
            giftViewController.transitioningDelegate = _rightModalTransitionDelegate;
            [self presentViewController:giftViewController animated:YES completion:nil];
            break;
        }
    }
}

#pragma mark - HXLiveAlbumViewDelegate Methods
- (void)liveAlbumsViewTaped:(HXLiveAlbumView *)albumsView {
    if ([HXUserSession session].state == HXUserStateLogout) {
        [self showLoginSence];
        return;
    }
    
    HXAlbumModel *album = self.viewModel.model.album;
    if (album) {
        HXLiveRewardLandscapeViewController *rewardViewController = [HXLiveRewardLandscapeViewController instance];
        rewardViewController.roomID = self.roomID;
        rewardViewController.album = album;
        rewardViewController.modalPresentationStyle = UIModalPresentationCustom;
        rewardViewController.transitioningDelegate = _rightModalTransitionDelegate;
        [self presentViewController:rewardViewController animated:YES completion:nil];
    }
}

@end
