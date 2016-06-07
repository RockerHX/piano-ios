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


@interface HXWatchLiveLandscapeViewController ()
@end


@implementation HXWatchLiveLandscapeViewController

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameLive;
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
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - HXWatchLiveBottomBarDelegate Methods
- (void)bottomBar:(HXWatchLiveBottomBar *)bar takeAction:(HXWatchBottomBarAction)action {
    if ([HXUserSession session].state == HXUserStateLogout) {
        [self showLoginSence];
        return;
    }
    
//    switch (action) {
//        case HXWatchBottomBarActionComment: {
//            HXLiveCommentViewController *commentViewController = [HXLiveCommentViewController instance];
//            commentViewController.roomID = _roomID;
//            commentViewController.transitioningDelegate = _modalTransitionDelegate;
//            commentViewController.modalPresentationStyle = UIModalPresentationCustom;
//            [self presentViewController:commentViewController animated:YES completion:nil];
//            break;
//        }
//        case HXWatchBottomBarActionShare: {
//            HXLiveModel *model     = _viewModel.model;
//            NSString *shareTitle   = model.shareTitle;
//            NSString *shareContent = model.shareContent;
//            NSString *shareURL     = model.shareUrl;
//            UIImage *shareImage    = [UIImage scaleToSize:[_anchorView.avatar imageForState:UIControlStateNormal] maxWidthOrHeight:100] ;
//            
//            //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
//            [UMSocialData defaultData].extConfig.title = shareTitle;
//            [UMSocialData defaultData].extConfig.wechatSessionData.url = shareURL;
//            [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareURL;
//            [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeWeb url:shareURL];
//            [UMSocialSnsService presentSnsIconSheetView:self
//                                                 appKey:UMengAPPKEY
//                                              shareText:shareContent
//                                             shareImage:shareImage
//                                        shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina]
//                                               delegate:nil];
//            break;
//        }
//        case HXWatchBottomBarActionGift: {
//            HXLiveGiftViewController *giftViewController = [HXLiveGiftViewController instance];
//            giftViewController.roomID = _roomID;
//            giftViewController.transitioningDelegate = _modalTransitionDelegate;
//            giftViewController.modalPresentationStyle = UIModalPresentationCustom;
//            [self presentViewController:giftViewController animated:YES completion:nil];
//            break;
//        }
//    }
}

@end
