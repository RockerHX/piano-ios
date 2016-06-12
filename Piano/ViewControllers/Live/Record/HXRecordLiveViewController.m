//
//  HXRecordLiveViewController.m
//  Piano
//
//  Created by miaios on 16/3/18.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXRecordLiveViewController.h"
#import "HXZegoAVKitManager.h"
#import "HXSettingSession.h"
#import "HXUserSession.h"
#import "HXRecordAnchorView.h"
#import "HXRecordBottomBar.h"
#import "HXPreviewLiveViewController.h"
#import "HXLiveEndViewController.h"
#import "HXLiveBarrageContainerViewController.h"
#import "HXLiveCommentViewController.h"
#import "HXRecordLiveViewModel.h"
#import "UIButton+WebCache.h"
#import "HXLiveUserBoard.h"
#import "MiaAPIHelper.h"
#import "HXLiveRewardTopListViewController.h"
#import "HXLiveAlbumView.h"
#import "BlocksKit+UIKit.h"
#import "HXModalTransitionDelegate.h"
#import "UIImage+Extrude.h"
#import <UMengSocialCOM/UMSocial.h>
#import "HXAppConstants.h"
#import "HXDynamicGiftView.h"
#import "HXStaticGiftView.h"


@interface HXRecordLiveViewController () <
ZegoLiveApiDelegate,
HXRecordAnchorViewDelegate,
HXRecordBottomBarDelegate,
HXPreviewLiveViewControllerDelegate,
HXLiveEndViewControllerDelegate,
HXLiveBarrageContainerViewControllerDelegate,
HXLiveAlbumViewDelegate
>
@end


@implementation HXRecordLiveViewController {
    HXPreviewLiveViewController *_previewViewController;
    HXLiveBarrageContainerViewController *_barrageContainer;
    
    NSString *_roomTitle;
    
    HXRecordLiveViewModel *_viewModel;
    HXLiveModel *_liveModel;
    BOOL _frontCamera;
    BOOL _microEnable;
    BOOL _beauty;
    
    HXModalTransitionDelegate *_modalTransitionDelegate;
}

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameLive;
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    __kindof UIViewController *destinationViewController = segue.destinationViewController;
    if ([destinationViewController isKindOfClass:[HXPreviewLiveViewController class]]) {
        _previewViewController = destinationViewController;
        _previewViewController.delegate = self;
    } else if ([destinationViewController isKindOfClass:[HXLiveBarrageContainerViewController class]]) {
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
    
    _frontCamera = YES;
	_beauty = YES;
    _microEnable = YES;
}

- (void)viewConfigure {
    //设置回调代理
    HXZegoAVKitManager *manager = [HXZegoAVKitManager manager];
    [manager.zegoLiveApi setDelegate:self];
    
    [manager startPreview];
    [self startPreview];
    if (_liveModel) {
        [self previewControllerHandleFinishedShouldStartLive:nil liveModel:_liveModel frontCamera:_frontCamera beauty:_beauty];
    }
}

#pragma mark - Event Response
- (IBAction)closeButtonPressed {
    HXZegoAVKitManager *manager = [HXZegoAVKitManager manager];
    if (manager.liveState == HXLiveStateLive) {
        [_anchorView stopRecordTime];
        [_albumView stopAlbumAnmation];
        [self closeLive];
    } else {
        [self leaveRoom];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Public Methods
- (void)recoveryLive:(HXLiveModel *)model {
    _liveModel = model;
}

#pragma mark - Private Methods
- (void)startPreview {
    ZegoLiveApi *zegoLiveApi = [HXZegoAVKitManager manager].zegoLiveApi;
    [zegoLiveApi setAVConfig:[HXSettingSession session].configure];
    [zegoLiveApi setLocalView:_liveView];
    [zegoLiveApi setLocalViewMode:ZegoVideoViewModeScaleAspectFill];
    [zegoLiveApi setFrontCam:_frontCamera];
	[zegoLiveApi enableBeautifying:_beauty ? ZEGO_BEAUTIFY_POLISH : ZEGO_BEAUTIFY_NONE];
    [zegoLiveApi startPreview];
}

- (void)shouldSteady:(BOOL)steady {
    [[UIApplication sharedApplication] setIdleTimerDisabled:steady];
}

- (void)startPublish {
    ZegoLiveApi *zegoLiveApi = [HXZegoAVKitManager manager].zegoLiveApi;
    //进入频道
    ZegoUser *user = [ZegoUser new];
    user.userID = [HXUserSession session].uid;
    user.userName = [HXUserSession session].nickName;
    
    bool ret = [zegoLiveApi loginChannel:user.userID user:user];
    assert(ret);
    NSLog(@"%s, ret: %d", __func__, ret);
}

- (void)closeLive {
    [self leaveRoom];
    
    HXLiveEndViewController *liveEndViewController = [HXLiveEndViewController instance];
    liveEndViewController.delegate = self;
    liveEndViewController.isAnchor = YES;
    liveEndViewController.liveModel = _viewModel.model;
    [self presentViewController:liveEndViewController animated:YES completion:nil];
}

- (void)leaveRoom {
    HXZegoAVKitManager *manager = [HXZegoAVKitManager manager];
    [[_viewModel.closeRoomCommand execute:nil] subscribeCompleted:^{
        [manager closeLive];
    }];
    
    ZegoLiveApi *zegoLiveApi = manager.zegoLiveApi;
    [zegoLiveApi stopPreview];
    [zegoLiveApi logoutChannel];
}

- (void)signalLink {
    @weakify(self)
    [_viewModel.barragesSignal subscribeNext:^(NSArray *barrages) {
        _barrageContainer.barrages = barrages;
    }];
    [_viewModel.exitSignal subscribeNext:^(id x) {
        ;
    }];
    [_viewModel.rewardSignal subscribeNext:^(NSNumber *rewardTotal) {
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
}

- (void)updateAnchorView {
    [_anchorView.avatar sd_setImageWithURL:[NSURL URLWithString:_viewModel.anchorAvatar] forState:UIControlStateNormal];
}

static CGFloat AlbumViewLeftSpace = 10.0f;
static CGFloat AlbumViewWidth = 60.0f;
- (void)updateAlbumView {
    HXAlbumModel *album = _viewModel.model.album;
    if (album) {
        _albumView.hidden = NO;
        _albumViewLeftConstraint.constant = AlbumViewLeftSpace;
        _albumViewWidthConstraint.constant = AlbumViewWidth;
        [_albumView updateWithAlbum:album];
    } else {
        _albumView.hidden = YES;
        _albumViewLeftConstraint.constant = 0.0f;
        _albumViewWidthConstraint.constant = 0.0f;
    }
}

#pragma mark - ZegoLiveApiDelegate
- (void)onLoginChannel:(NSString *)channel error:(uint32)error {
    NSLog(@"%s, err: %u", __func__, error);
    if (error == 0) {
        ZegoLiveApi *zegoLiveApi = [HXZegoAVKitManager manager].zegoLiveApi;
        
        int ret = [zegoLiveApi setAVConfig:[HXSettingSession session].configure];
        assert(ret == 0);
        
        bool b = [zegoLiveApi enableMic:_microEnable];
        assert(b);
        
        b = [zegoLiveApi enableBeautifying:_beauty ? ZEGO_BEAUTIFY_POLISH : ZEGO_BEAUTIFY_NONE];
        assert(b);
        
        b = [zegoLiveApi setFilter:ZEGO_FILTER_NONE];
        assert(b);
        
        b = [zegoLiveApi startPublishingWithTitle:_roomTitle streamID:_viewModel.model.streamAlias];
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
    [_anchorView startRecordTime];
    [[HXZegoAVKitManager manager] startLive];
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

#pragma mark - HXRecordAnchorViewDelegate Methods
- (void)anchorView:(HXRecordAnchorView *)anchorView takeAction:(HXRecordAnchorViewAction)action {
    switch (action) {
        case HXRecordAnchorViewActionShowAnchor: {
            ;
            break;
        }
    }
}

#pragma mark - HXRecordBottomBarDelegate Methods
- (void)bottomBar:(HXRecordBottomBar *)bar takeAction:(HXRecordBottomBarAction)action {
    switch (action) {
        case HXRecordBottomBarActionComment: {
            HXLiveCommentViewController *commentViewController = [HXLiveCommentViewController instance];
            commentViewController.roomID = _viewModel.model.roomID;
            commentViewController.transitioningDelegate = _modalTransitionDelegate;
            commentViewController.modalPresentationStyle = UIModalPresentationCustom;
            [self presentViewController:commentViewController animated:YES completion:nil];
            break;
        }
        case HXRecordBottomBarActionBeauty: {
            _beauty = !_beauty;
            [[HXZegoAVKitManager manager].zegoLiveApi enableBeautifying:_beauty];
            
            NSString *prompt = _beauty ? @"已开启" : @"已关闭";
            prompt = [prompt stringByAppendingString:@"美颜功能"];
            [self showBannerWithPrompt:prompt];
            break;
        }
        case HXRecordBottomBarActionChange: {
            _frontCamera = !_frontCamera;
            [[HXZegoAVKitManager manager].zegoLiveApi setFrontCam:_frontCamera];
            break;
        }
        case HXRecordBottomBarActionMute: {
            _microEnable = !_microEnable;
            [[HXZegoAVKitManager manager].zegoLiveApi enableMic:_microEnable];
            break;
        }
        case HXRecordBottomBarActionGift: {
            HXLiveRewardTopListViewController *rewardTopListViewController = [HXLiveRewardTopListViewController instance];
            rewardTopListViewController.type = HXLiveRewardTopListTypeGift;
            rewardTopListViewController.roomID = _viewModel.roomID;
            rewardTopListViewController.transitioningDelegate = _modalTransitionDelegate;
            rewardTopListViewController.modalPresentationStyle = UIModalPresentationCustom;
            [self presentViewController:rewardTopListViewController animated:YES completion:nil];
            break;
        }
        case HXRecordBottomBarActionShare: {
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
    }
}

#pragma mark - HXPreviewLiveViewControllerDelegate Methods
- (void)previewControllerHandleFinishedShouldStartLive:(HXPreviewLiveViewController *)viewController liveModel:(HXLiveModel *)model frontCamera:(BOOL)frontCamera beauty:(BOOL)beauty {
    _frontCamera = frontCamera;
    _beauty      = beauty;
    _bottomBar.beautyButton.selected = !beauty;
    
    [self startPublish];
    
    _viewModel       = [HXRecordLiveViewModel new];
    _viewModel.model = model;
    [self signalLink];
    
    [self updateAnchorView];
    [self updateAlbumView];
    
    _previewContainer.hidden = YES;
    _topBar.hidden           = NO;
    _barragesView.hidden     = NO;
    _bottomBar.hidden        = NO;
    [_previewContainer removeFromSuperview];
    _previewContainer = nil;
}

- (void)previewControllerClosed:(HXPreviewLiveViewController *)viewController {
    [self closeButtonPressed];
}

#pragma mark - HXLiveEndViewControllerDelegate Methods
- (void)endViewControllerWouldLikeExitRoom:(HXLiveEndViewController *)viewController {
    ;
}

#pragma mark - HXLiveBarrageContainerViewControllerDelegate Methods
- (void)barrageContainer:(HXLiveBarrageContainerViewController *)container shouldShowBarrage:(HXBarrageModel *)barrage {
    if (barrage.type == HXBarrageTypeComment) {
        HXWatcherModel *watcher = [HXWatcherModel instanceWithComment:barrage.comment];
        [HXLiveUserBoard showWithWatcher:watcher gaged:^(HXWatcherModel *watcher) {
            [MiaAPIHelper forbidUser:watcher.ID completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                [self showBannerWithPrompt:@"禁言成功"];
            } timeoutBlock:^(MiaRequestItem *requestItem) {
                [self showBannerWithPrompt:@"网络超时，禁言失败"];
            }];
        } closed:nil];
    }
}

#pragma mark - HXLiveAlbumViewDelegate Methods
- (void)liveAlbumsViewTaped:(HXLiveAlbumView *)albumsView {
    HXLiveRewardTopListViewController *rewardTopListViewController = [HXLiveRewardTopListViewController instance];
    rewardTopListViewController.type = HXLiveRewardTopListTypeAlbum;
    rewardTopListViewController.roomID = _viewModel.roomID;
    rewardTopListViewController.transitioningDelegate = _modalTransitionDelegate;
    rewardTopListViewController.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:rewardTopListViewController animated:YES completion:nil];
}

@end
