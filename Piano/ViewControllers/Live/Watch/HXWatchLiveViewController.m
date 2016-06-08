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
#import "MIAProfileViewController.h"


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
}

- (void)viewConfigure {
    ZegoLiveApi *zegoLiveApi = [HXZegoAVKitManager manager].zegoLiveApi;
    
    bool v = [zegoLiveApi setRemoteView:RemoteViewIndex_First view:_liveView];
    assert(v);
    v = [zegoLiveApi setRemoteViewMode:RemoteViewIndex_First mode:ZegoVideoViewModeScaleAspectFill];
    assert(v);
    
    //设置回调代理
    [zegoLiveApi setDelegate:self];
}

- (void)signalLink {
    @weakify(self)
    [_viewModel.barragesSignal subscribeNext:^(NSArray *barrages) {
        _barrageContainer.barrages = barrages;
    }];
    [_viewModel.exitSignal subscribeNext:^(id x) {
        @strongify(self)
        [self endLive];
    }];
    [_viewModel.rewardSignal subscribeNext:^(id x) {
        @strongify(self)
        [self updateAlbumView];
    }];
    [_viewModel.giftSignal subscribeNext:^(HXGiftModel *gift) {
        @strongify(self)
        if (gift.type == HXGiftTypeStatic) {
            [self.staticGiftView animationWithGift:gift];
        } else if (gift.type == HXGiftTypeDynamic) {
            [self.dynamicGiftView animationWithGift:gift];
        }
    }];
    
    RACSignal *enterRoomSiganl = [_viewModel.enterRoomCommand execute:nil];
    [enterRoomSiganl subscribeError:^(NSError *error) {
        @strongify(self)
        if (![error.domain isEqualToString:RACCommandErrorDomain]) {
            [self showBannerWithPrompt:error.domain];
        }
    } completed:^{
        @strongify(self)
        [self fetchDataFinfished];
    }];
}

#pragma mark - Event Response
- (IBAction)reportButtonPressed {
    [self reportAnchorWithID:_viewModel.model.uID];
}

- (IBAction)closeButtonPressed {
    [self dismiss];
}

#pragma mark - Private Methods
- (void)shouldSteady:(BOOL)steady {
    [[UIApplication sharedApplication] setIdleTimerDisabled:steady];
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
    liveEndViewController.isLive = NO;
    liveEndViewController.liveModel = _viewModel.model;
    [self presentViewController:liveEndViewController animated:YES completion:nil];
}

- (void)fetchDataFinfished {
    [self roomConfigure];
    [self updateAnchorView];
    [self updateAlbumView];
}

- (void)roomConfigure {
    ZegoLiveApi *zegoLiveApi = [HXZegoAVKitManager manager].zegoLiveApi;
    
    //进入频道
    ZegoUser *user = [ZegoUser new];
    user.userID = [HXUserSession session].uid;
    user.userName = [HXUserSession session].nickName;
    
    bool ret = [zegoLiveApi loginChannel:_viewModel.model.channelID user:user];
    assert(ret);
    NSLog(@"%s, ret: %d", __func__, ret);
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
    _albumView.hidden = album ? NO : YES;
    [_albumView updateWithAlbum:album];
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
    NSLog(@"%s, err: %u", __func__, error);
    if (error == 0) {
        ZegoLiveApi *zegoLiveApi = [HXZegoAVKitManager manager].zegoLiveApi;
        
        int ret = [zegoLiveApi setAVConfig:[HXSettingSession session].configure];
        assert(ret == 0);
        
        bool b = [zegoLiveApi startPlayStream:_viewModel.model.streamAlias viewIndex:RemoteViewIndex_First];
        assert(b);
        NSLog(@"%s, ret: %d", __func__, ret);
    }
}

- (void)onDisconnected:(uint32)err channel:(NSString *)channel {
    NSString *msg = [NSString stringWithFormat:@"Channel %@ Connection Broken, ERROR: %u.", channel, err];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disconnected!" message:msg delegate:nil cancelButtonTitle:@"YES" otherButtonTitles:nil];
    [alert show];
}

- (void)onReconnected:(NSString *)channel {
    NSString *msg = [NSString stringWithFormat:@"Channel %@ Reconnected.", channel];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reconnected!" message:msg delegate:nil cancelButtonTitle:@"YES" otherButtonTitles:nil];
    [alert show];
}

- (void)onPublishSucc:(NSString *)streamID channel:(NSString *)channel playUrl:(NSString *)playUrl {
    NSLog(@"%s, stream: %@", __func__, streamID);
}

- (void)onPublishStop:(uint32)err stream:(NSString *)streamID channel:(NSString *)channel {
    NSLog(@"%s, stream: %@, err: %u", __func__, streamID, err);
}

- (void)onPlaySucc:(NSString *)streamID channel:(NSString *)channel {
    NSLog(@"%s, stream: %@", __func__, streamID);
}

- (void)onPlayStop:(uint32)err streamID:(NSString *)streamID channel:(NSString *)channel {
    NSLog(@"%s, err: %u, stream: %@", __func__, err, streamID);
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
                MIAProfileViewController *profileViewController = [MIAProfileViewController new];
                [profileViewController setUid:watcher.ID];
                [self.navigationController pushViewController:profileViewController animated:YES];
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
        rewardViewController.album = album;
        rewardViewController.transitioningDelegate = _modalTransitionDelegate;
        rewardViewController.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:rewardViewController animated:YES completion:nil];
    }
}

@end
