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
#import "HXLiveBarrageViewController.h"
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
#import "HXShowRechargeDelegate.h"
#import "MIAPaymentViewController.h"
#import <ShareSDKUI/ShareSDKUI.h>
#import "BlocksKit+UIKit.h"
#import "MiaAPIHelper.h"


@interface HXWatchLiveViewController () <
ZegoLiveApiDelegate,
HXLiveAnchorViewDelegate,
HXWatchLiveBottomBarDelegate,
HXLiveBarrageContainerViewControllerDelegate,
HXLiveEndViewControllerDelegate,
HXLiveAlbumViewDelegate,
HXShowRechargeDelegate
>
@end


@implementation HXWatchLiveViewController {
    HXLiveBarrageContainerViewController *_barrageContainer;
    HXLiveEndViewController *_endViewController;
    HXWatchLiveViewModel *_viewModel;
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
    } else if ([segue.identifier isEqualToString:NSStringFromClass([HXLiveEndViewController class])]) {
        _endViewController = segue.destinationViewController;
        _endViewController.delegate = self;
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
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
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
        [[HXZegoAVKitManager manager].zegoLiveApi takeRemoteViewSnapshot:RemoteViewIndex_First];
    }];
    [_viewModel.rewardSignal subscribeNext:^(NSNumber *rewardTotal) {
        [self updateAlbumView];
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

- (void)endLiveWithSnapShotImage:(UIImage *)image {
    self->_endViewController.isLive = NO;
    self->_endViewController.liveModel = _viewModel.model;
    
    _endViewController.snapShotImage = image;
    self.endCountContainer.hidden = NO;
    
    [self leaveRoom];
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
    _anchorView.countLabel.text = _viewModel.viewCount;
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
- (void)onLoginChannel:(uint32)error {
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

- (void)onPublishSucc:(NSString *)streamID {
    NSLog(@"%s, stream: %@", __func__, streamID);
}

- (void)onPublishStop:(uint32)err stream:(NSString *)streamID {
    NSLog(@"%s, stream: %@, err: %u", __func__, streamID, err);
}

- (void)onPlaySucc:(NSString *)streamID {
    NSLog(@"%s, stream: %@", __func__, streamID);
}

- (void)onPlayStop:(uint32)err streamID:(NSString *)streamID {
    NSLog(@"%s, err: %u, stream: %@", __func__, err, streamID);
}

- (void)onVideoSizeChanged:(NSString *)streamID width:(uint32)width height:(uint32)height {
    NSLog(@"%s", __func__);
}

- (void)onTakeRemoteViewSnapshot:(CGImageRef)img view:(RemoteViewIndex)index {
    UIImage *snapShotImage = [UIImage imageWithCGImage:img];
    [self endLiveWithSnapShotImage:snapShotImage];
}

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
            HXLiveBarrageViewController *commentViewController = [HXLiveBarrageViewController instance];
            commentViewController.roomID = _roomID;
            [self addChildViewController:commentViewController];
            [self.view addSubview:commentViewController.view];
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
            giftViewController.rechargeDelegate = self;
            giftViewController.roomID = _roomID;
            [self addChildViewController:giftViewController];
            [self.view addSubview:giftViewController.view];
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
    [self dismissViewControllerAnimated:YES completion:nil];
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
        rewardViewController.rechargeDelegate = self;
        rewardViewController.roomID = _roomID;
        rewardViewController.album = album;
        [rewardViewController showOnViewController:self];
    }
}

#pragma mark - HXShowRechargeDelegate Methods
- (void)shouldShowRechargeSence {
    MIAPaymentViewController *paymentViewController = [MIAPaymentViewController new];
    paymentViewController.present = YES;
    [self presentViewController:paymentViewController animated:YES completion:nil];
}

@end
