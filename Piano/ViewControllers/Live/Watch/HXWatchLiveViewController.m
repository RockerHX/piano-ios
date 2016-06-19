//
//  HXWatchLiveViewController.m
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXWatchLiveViewController.h"
#import "HXZegoAVKitManager.h"
#import "HXLiveBarrageContainerViewController.h"
#import "HXLiveEndViewController.h"
#import "HXLiveCommentViewController.h"
#import "HXLiveAnchorView.h"
#import "HXWatchLiveBottomBar.h"
#import "HXLiveUserBoard.h"
#import "HXSettingSession.h"
#import "UIButton+WebCache.h"
#import "HXUserSession.h"
#import "HXLiveAlbumView.h"
#import "HXLiveGiftViewController.h"
#import "HXLiveRewardViewController.h"
#import "MIAPaymentViewController.h"
#import "BlocksKit+UIKit.h"
#import "MiaAPIHelper.h"
#import "HXDynamicGiftView.h"
#import "HXModalTransitionDelegate.h"
#import "HXStaticGiftView.h"
#import "UIImage+Extrude.h"
#import <UMengSocialCOM/UMSocial.h>
#import "HXAppConstants.h"
#import "UIConstants.h"
#import "MIAInfoLog.h"
#import "BFRadialWaveHUD.h"
#import "FileLog.h"
#import "MIARedEnvelopeView.h"
#import "MIAProfileNavigationController.h"


@interface HXWatchLiveViewController () <
ZegoLiveApiDelegate,
HXLiveAnchorViewDelegate,
HXWatchLiveBottomBarDelegate,
HXLiveBarrageContainerViewControllerDelegate,
HXLiveEndViewControllerDelegate,
HXLiveAlbumViewDelegate
>
@end


@implementation HXWatchLiveViewController {
    HXLiveBarrageContainerViewController *_barrageContainer;
    HXModalTransitionDelegate *_modalTransitionDelegate;
    
    BFRadialWaveHUD *_hud;
}

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameLive;
}

+ (NSString *)navigationControllerIdentifier {
    return @"HXWatchLiveNavigationController";
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    __kindof UIViewController *destinationViewController = segue.destinationViewController;
    if ([destinationViewController isKindOfClass:[HXLiveBarrageContainerViewController class]]) {
        _barrageContainer = destinationViewController;
        _barrageContainer.delegate = self;
    }
}

#pragma mark - View Controller Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self shouldSteady:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self shouldSteady:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    
    _modalTransitionDelegate = [HXModalTransitionDelegate new];
    _viewModel = [[HXWatchLiveViewModel alloc] initWithRoomID:_roomID];
    [self signalLink];
    
    __weak __typeof__(self)weakSelf = self;
    [_anchorView bk_whenTouches:1 tapped:5 handler:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [[HXZegoAVKitManager manager].zegoLiveApi uploadLog];
        [MIAInfoLog uploadInfoLogWithRoomID:strongSelf.roomID streamID:strongSelf->_viewModel.model.streamAlias];
    }];
}

- (void)viewConfigure {
    ZegoLiveApi *zegoLiveApi = [HXZegoAVKitManager manager].zegoLiveApi;
    
    bool v = [zegoLiveApi setRemoteView:RemoteViewIndex_First view:_liveView];
    assert(v);
    v = [zegoLiveApi setRemoteViewMode:RemoteViewIndex_First mode:ZegoVideoViewModeScaleAspectFill];
    assert(v);
    
    //设置回调代理
    [zegoLiveApi setDelegate:self];
    
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    [self.view addGestureRecognizer:leftSwipeGesture];
    [self.view addGestureRecognizer:rightSwipeGesture];
    
    [self showLoadingHUD];
}

- (void)signalLink {
    @weakify(self)
    [_viewModel.barragesSignal subscribeNext:^(NSArray *barrages) {
        _anchorView.countLabel.text = _viewModel.onlineCount;
        _barrageContainer.barrages = barrages;
    }];
    [_viewModel.exitSignal subscribeNext:^(id x) {
        @strongify(self)
        [self endLive];
    }];
    [_viewModel.rewardSignal subscribeNext:^(HXGiftModel *gift) {
        @strongify(self)
        [self updateAlbumView];
        [self.dynamicGiftView animationWithGift:gift];
    }];
    [_viewModel.giftSignal subscribeNext:^(HXGiftModel *gift) {
        @strongify(self)
        if (gift.type == HXGiftTypeStatic) {
            [self.staticGiftView animationWithGift:gift];
        } else if (gift.type == HXGiftTypeDynamic) {
            [self.dynamicGiftView animationWithGift:gift];
        }
    }];
    
    [[FileLog standard] log:@"Enter Room"];
    RACSignal *enterRoomSiganl = [_viewModel.enterRoomCommand execute:nil];
    [enterRoomSiganl subscribeError:^(NSError *error) {
        @strongify(self)
        if (![error.domain isEqualToString:RACCommandErrorDomain]) {
            [self showBannerWithPrompt:error.domain];
        }
        [self hiddenLoadingHUD];
        [[FileLog standard] log:@"Enter Room Error:%@", error.domain];
    } completed:^{
        @strongify(self)
        [self fetchDataFinfished];
        [[FileLog standard] log:@"Enter Room Success"];
    }];
}

#pragma mark - Event Response
- (IBAction)reportButtonPressed {
    [self reportAnchorWithID:_viewModel.model.uID];
}

- (IBAction)closeButtonPressed {
    [[FileLog standard] log:@"Close Room"];
    [self dismiss];
}

- (void)swipeGesture:(UISwipeGestureRecognizer *)gesure {
    switch (gesure.direction) {
        case UISwipeGestureRecognizerDirectionRight: {
            self.containerLeftConstraint.constant = SCREEN_WIDTH;
            break;
        }
        case UISwipeGestureRecognizerDirectionLeft: {
            self.containerLeftConstraint.constant = 0.0f;
            break;
        }
        default: {
            break;
        }
    }
    [UIView animateWithDuration:0.4f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

#pragma mark - Private Methods
- (void)shouldSteady:(BOOL)steady {
    [[UIApplication sharedApplication] setIdleTimerDisabled:steady];
}

- (void)showLoadingHUD {
    if (!_hud) {
        _hud = [[BFRadialWaveHUD alloc] initWithView:_liveView
                                          fullScreen:YES
                                             circles:BFRadialWaveHUD_DefaultNumberOfCircles
                                         circleColor:nil
                                                mode:BFRadialWaveHUDMode_Default
                                         strokeWidth:BFRadialWaveHUD_DefaultCircleStrokeWidth];
        [_hud setBlurBackground:YES];
    }
    [_hud show];
}

- (void)showErrorLoading {
    [_hud showErrorWithCompletion:^(BOOL finished) {
        [_hud dismiss];
    }];
}

- (void)hiddenLoadingHUD {
    [_hud dismissAfterDelay:0.5f];
}

- (void)dismiss {
    [_albumView stopAlbumAnmation];
    [self leaveRoom];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)leaveRoom {
    [_viewModel.leaveRoomCommand execute:nil];
    [[HXZegoAVKitManager manager].zegoLiveApi logoutChannel];
}

- (void)endLive {
    [self leaveRoom];
    
    HXLiveEndViewController *liveEndViewController = [HXLiveEndViewController instance];
    liveEndViewController.delegate = self;
    liveEndViewController.isAnchor = NO;
    liveEndViewController.liveModel = _viewModel.model;
    [self presentViewController:liveEndViewController animated:YES completion:nil];
    
    if (_delegate && [_delegate respondsToSelector:@selector(watchLiveViewControllerLiveEnded:)]) {
        [_delegate watchLiveViewControllerLiveEnded:self];
    }
}

- (void)fetchDataFinfished {
    [self roomConfigure];
    [self updateAnchorView];
    [self updateAlbumView];
    
    HXCouponModel *coupon = _viewModel.model.coupon;
    if (coupon) {
        MIARedEnvelopeView *redEvenlopeView = [MIARedEnvelopeView new];
        [redEvenlopeView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [redEvenlopeView setTitle:coupon.title tip:coupon.content];
        [redEvenlopeView showInView:self.view receiveHandler:^{
            [redEvenlopeView hidden];
        }];
    }
}

- (void)roomConfigure {
    ZegoLiveApi *zegoLiveApi = [HXZegoAVKitManager manager].zegoLiveApi;
    
    //进入频道
    ZegoUser *user = [ZegoUser new];
    user.userID = [HXUserSession session].uid;
    user.userName = [HXUserSession session].nickName;
    
    bool ret = [zegoLiveApi loginChannel:_viewModel.model.channelID user:user];
    [[FileLog standard] log:@"%s, ret: %d", __func__, ret];
}

- (void)updateAnchorView {
    [_anchorView.avatar sd_setImageWithURL:[NSURL URLWithString:_viewModel.anchorAvatar] forState:UIControlStateNormal];
    _anchorView.nickNameLabel.text = _viewModel.anchorNickName;
    _anchorView.countLabel.text = _viewModel.onlineCount;
    _anchorView.ownside = [[HXUserSession session].uid isEqualToString:_viewModel.model.uID];
    
    if ([HXUserSession session].state == HXUserStateLogin) {
        @weakify(self)
        RACSignal *checkAttentionStateSiganl = [_viewModel.checkAttentionStateCommand execute:nil];
        [checkAttentionStateSiganl subscribeNext:^(NSNumber *state) {
            @strongify(self)
            self.anchorView.attented = state.boolValue;
        } error:^(NSError *error) {
            @strongify(self)
            if (![error.domain isEqualToString:RACCommandErrorDomain]) {
                [self showBannerWithPrompt:error.domain];
            }
        }];
    }
}

- (void)updateAlbumView {
    HXAlbumModel *album = _viewModel.model.album;
    if (album) {
        _albumView.hidden = NO;
        [_albumView updateWithAlbum:album];
    } else {
        _albumView.hidden = YES;
        _albumWidthConstraint.constant = 0.0f;
        _albumRightConstraint.constant = 0.0f;
    }
}

- (void)reportAnchorWithID:(NSString *)uid {
    [MiaAPIHelper reportWithType:@"resport_anchor" content:uid completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        [self showBannerWithPrompt:@"举报成功"];
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        [self showBannerWithPrompt:@"网络超时，举报失败"];
    }];
}

#pragma mark - ZegoLiveApiDelegate
- (void)onLoginChannel:(NSString *)channel error:(uint32)error {
    [[FileLog standard] log:@"%s, err: %u", __func__, error];
    if (error == 0) {
        ZegoLiveApi *zegoLiveApi = [HXZegoAVKitManager manager].zegoLiveApi;
        int ret = [zegoLiveApi setAVConfig:[HXSettingSession session].configure];
        [zegoLiveApi startPlayStream:_viewModel.model.streamAlias viewIndex:RemoteViewIndex_First];
        [[FileLog standard] log:@"%s, ret: %d", __func__, ret];
    } else {
        [self hiddenLoadingHUD];
    }
}

- (void)onDisconnected:(uint32)err channel:(NSString *)channel {
    [[FileLog standard] log:@"Channel %@ Connection Broken, ERROR: %u.", channel, err];
}

- (void)onReconnected:(NSString *)channel {
    [[FileLog standard] log:@"Channel %@ Reconnected.", channel];
}

- (void)onPublishSucc:(NSString *)streamID channel:(NSString *)channel playUrl:(NSString *)playUrl {
    [[FileLog standard] log:@"%s, stream: %@", __func__, streamID];
    [self hiddenLoadingHUD];
}

- (void)onPublishStop:(uint32)err stream:(NSString *)streamID channel:(NSString *)channel {
    [[FileLog standard] log:@"%s, stream: %@, err: %u", __func__, streamID, err];
    [self hiddenLoadingHUD];
}

- (void)onPlaySucc:(NSString *)streamID channel:(NSString *)channel {
    [[FileLog standard] log:@"%s, stream: %@", __func__, streamID];
    [self hiddenLoadingHUD];
}

- (void)onPlayStop:(uint32)err streamID:(NSString *)streamID channel:(NSString *)channel {
    [[FileLog standard] log:@"%s, err: %u, stream: %@", __func__, err, streamID];
    [self hiddenLoadingHUD];
}

- (void)onVideoSizeChanged:(NSString *)streamID width:(uint32)width height:(uint32)height {}
- (void)onCaptureVideoSizeChangedToWidth:(uint32)width height:(uint32)height {}
- (void)onTakeRemoteViewSnapshot:(CGImageRef)img view:(RemoteViewIndex)index {}
- (void)onTakeLocalViewSnapshot:(CGImageRef)img {}

#pragma mark - HXLiveAnchorViewDelegate Methods
- (void)anchorView:(HXLiveAnchorView *)anchorView takeAction:(HXLiveAnchorViewAction)action {
    switch (action) {
        case HXLiveAnchorViewActionShowAnchor: {
            HXWatcherModel *watcher = [HXWatcherModel instanceWithLiveModel:_viewModel.model];
            [HXLiveUserBoard showWithWatcher:watcher showProfile:^(HXWatcherModel *watcher) {
                MIAProfileNavigationController *profileNavigationController = [MIAProfileNavigationController profileNavigationInstanceWithUID:watcher.ID];
                [self presentViewController:profileNavigationController animated:YES completion:nil];
            } report:^(HXWatcherModel *watcher) {
                [self reportAnchorWithID:watcher.ID];
            } gaged:nil closed:nil];
            break;
        }
        case HXLiveAnchorViewActionAttention: {
            if ([HXUserSession session].state == HXUserStateLogout) {
                [self showLoginSence];
                return;
            }
            
            @weakify(self)
            RACSignal *takeAttentionSiganl = [_viewModel.takeAttentionCommand execute:nil];
            [takeAttentionSiganl subscribeNext:^(NSNumber *state) {
                anchorView.attented = state.boolValue;
            } error:^(NSError *error) {
                @strongify(self)
                if (![error.domain isEqualToString:RACCommandErrorDomain]) {
                    [self showBannerWithPrompt:error.domain];
                }
            }];
            break;
        }
    }
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
            commentViewController.roomID = _roomID;
            commentViewController.transitioningDelegate = _modalTransitionDelegate;
            commentViewController.modalPresentationStyle = UIModalPresentationCustom;
            [self presentViewController:commentViewController animated:YES completion:nil];
            break;
        }
        case HXWatchBottomBarActionShare: {
            HXLiveModel *model     = _viewModel.model;
            NSString *shareTitle   = model.shareTitle;
            NSString *shareContent = model.shareContent;
            NSString *shareURL     = model.shareUrl;
            UIImage *shareImage    = [UIImage scaleToSize:[_anchorView.avatar imageForState:UIControlStateNormal] maxWidthOrHeight:100] ;
            
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
            HXLiveGiftViewController *giftViewController = [HXLiveGiftViewController instance];
            giftViewController.roomID = _roomID;
            giftViewController.streamID = _viewModel.model.streamAlias;
            giftViewController.transitioningDelegate = _modalTransitionDelegate;
            giftViewController.modalPresentationStyle = UIModalPresentationCustom;
            [self presentViewController:giftViewController animated:YES completion:nil];
            break;
        }
    }
}

#pragma mark - HXLiveBarrageContainerViewControllerDelegate Methods
- (void)barrageContainer:(HXLiveBarrageContainerViewController *)container shouldShowBarrage:(HXBarrageModel *)barrage {
    if (barrage.type == HXBarrageTypeComment) {
        HXWatcherModel *watcher = [HXWatcherModel instanceWithComment:barrage.comment];
        [HXLiveUserBoard showWithWatcher:watcher showProfile:nil report:^(HXWatcherModel *watcher) {
            ;
        } gaged:^(HXWatcherModel *watcher) {
            [MiaAPIHelper reportWithType:@"resport_anchor" content:watcher.ID completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                [self showBannerWithPrompt:@"举报成功"];
            } timeoutBlock:^(MiaRequestItem *requestItem) {
                [self showBannerWithPrompt:@"网络超时，举报失败"];
            }];
        } closed:nil];
    }
}

#pragma mark - HXLiveEndViewControllerDelegate Methods
- (void)endViewControllerWouldLikeExitRoom:(HXLiveEndViewController *)viewController {
    ;
}

#pragma mark - HXLiveAlbumViewDelegate Methods
- (void)liveAlbumsViewTaped:(HXLiveAlbumView *)albumsView {
    if ([HXUserSession session].state == HXUserStateLogout) {
        [self showLoginSence];
        return;
    }
    
    HXAlbumModel *album = _viewModel.model.album;
    if (album) {
        HXLiveRewardViewController *rewardViewController = [HXLiveRewardViewController instance];
        rewardViewController.roomID = _roomID;
        rewardViewController.streamID = _viewModel.model.streamAlias;
        rewardViewController.album = album;
        rewardViewController.transitioningDelegate = _modalTransitionDelegate;
        rewardViewController.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:rewardViewController animated:YES completion:nil];
    }
}

@end
