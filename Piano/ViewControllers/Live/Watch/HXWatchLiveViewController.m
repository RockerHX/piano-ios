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
#import "HXWatcherBoard.h"
#import "HXWatchLiveViewModel.h"
#import "HXSettingSession.h"
#import "UIButton+WebCache.h"
#import "HXUserSession.h"
#import "HXLiveAlbumView.h"
#import "HXLiveGiftViewController.h"
#import "HXLiveRewardViewController.h"
#import "MIAPaymentViewController.h"
#import <ShareSDKUI/ShareSDKUI.h>
#import "BlocksKit+UIKit.h"
#import "MiaAPIHelper.h"
#import "HXDynamicGiftView.h"
#import "HXModalTransitionDelegate.h"
#import "HXStaticGiftView.h"


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
    HXWatchLiveViewModel *_viewModel;
    
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
    NSString *identifier = segue.identifier;
    if ([identifier isEqualToString:NSStringFromClass([HXLiveBarrageContainerViewController class])]) {
        _barrageContainer = segue.destinationViewController;
        _barrageContainer.delegate = self;
    }
}

#pragma mark - Status Bar
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
    [_viewModel.barragesSignal subscribeNext:^(NSArray *barrages) {
        _barrageContainer.barrages = barrages;
    }];
    [_viewModel.exitSignal subscribeNext:^(id x) {
        [self endLive];
    }];
    [_viewModel.rewardSignal subscribeNext:^(id x) {
        [self updateAlbumView];
    }];
    [_viewModel.giftSignal subscribeNext:^(HXGiftModel *gift) {
        if (gift.type == HXGiftTypeStatic) {
            [_staticGiftView animationWithGift:gift];
        } else if (gift.type == HXGiftTypeDynamic) {
            [_dynamicGiftView animationWithGift:gift];
        }
    }];
    
    RACSignal *enterRoomSiganl = [_viewModel.enterRoomCommand execute:nil];
    [enterRoomSiganl subscribeError:^(NSError *error) {
        if (![error.domain isEqualToString:RACCommandErrorDomain]) {
            [self showBannerWithPrompt:error.domain];
        }
    } completed:^{
        [self fetchDataFinfished];
    }];
}

#pragma mark - Event Response
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
            self->_anchorView.attented = state.boolValue;
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
            ;
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
            NSURL *shareURL        = [NSURL URLWithString:model.shareUrl];
            UIImage *shareImage    = [_anchorView.avatar imageForState:UIControlStateNormal];
            
            NSMutableDictionary *shareParams = @{}.mutableCopy;
            [shareParams SSDKSetupShareParamsByText:shareContent
                                             images:shareImage
                                                url:shareURL
                                              title:shareTitle
                                               type:SSDKContentTypeAuto];
//            [shareParams SSDKSetupWeChatParamsByText:shareContent title:shareTitle url:shareURL thumbImage:nil image:shareImage musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatSession];
//            [shareParams SSDKSetupSinaWeiboShareParamsByText:shareContent title:shareTitle image:shareImage url:shareURL latitude:0 longitude:0 objectID:nil type:SSDKContentTypeAuto];
            [ShareSDK showShareActionSheet:self.view items:nil shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                switch (state) {
                    case SSDKResponseStateSuccess: {
                        [UIAlertView bk_showAlertViewWithTitle:@"分享成功" message:nil cancelButtonTitle:@"确定" otherButtonTitles:nil handler:nil];
                        [MiaAPIHelper sharePostWithRoomID:_viewModel.roomID completeBlock:nil timeoutBlock:nil];
                        break;
                    }
                    case SSDKResponseStateFail: {
                        [UIAlertView bk_showAlertViewWithTitle:@"分享失败" message:nil cancelButtonTitle:@"确定" otherButtonTitles:nil handler:nil];
                        break;
                    }
                    default:
                        break;
                }
            }];
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
    ;
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
