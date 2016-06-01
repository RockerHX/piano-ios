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
#import "HXLiveBarrageViewController.h"
#import "HXRecordLiveViewModel.h"
#import "UIButton+WebCache.h"
#import "HXWatcherBoard.h"
#import "MiaAPIHelper.h"
#import "HXLiveRewardTopListViewController.h"
#import "HXLiveAlbumView.h"
#import <ShareSDKUI/ShareSDKUI.h>
#import "BlocksKit+UIKit.h"
#import "HXModalTransitionDelegate.h"


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
    HXLiveEndViewController *_endViewController;
    HXLiveBarrageContainerViewController *_barrageContainer;
    
    NSString *_roomID;
    NSString *_roomTitle;
    
    HXRecordLiveViewModel *_viewModel;
    BOOL _frontCamera;
    BOOL _microEnable;
    BOOL _beauty;
    
    HXModalTransitionDelegate *_modalTransitionDelegate;
}

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameLive;
}

+ (NSString *)navigationControllerIdentifier {
    return @"HXRecordLiveNavigationController";
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:NSStringFromClass([HXPreviewLiveViewController class])]) {
        _previewViewController = segue.destinationViewController;
        _previewViewController.delegate = self;
    } else if ([segue.identifier isEqualToString:NSStringFromClass([HXLiveEndViewController class])]) {
        _endViewController = segue.destinationViewController;
        _endViewController.delegate = self;
    } else if ([segue.identifier isEqualToString:NSStringFromClass([HXLiveBarrageContainerViewController class])]) {
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
    
    _frontCamera = YES;
    _microEnable = YES;
}

- (void)viewConfigure {
    //设置回调代理
    [[HXZegoAVKitManager manager].zegoLiveApi setDelegate:self];
    
    [self startPreview];
}

#pragma mark - Event Response
- (IBAction)closeButtonPressed {
    [_anchorView stopRecordTime];
    [_albumView stopAlbumAnmation];
    
    ZegoLiveApi *zegoLiveApi = [HXZegoAVKitManager manager].zegoLiveApi;
    [zegoLiveApi takeLocalViewSnapshot];
}

#pragma mark - Private Methods
- (void)startPreview {
    ZegoLiveApi *zegoLiveApi = [HXZegoAVKitManager manager].zegoLiveApi;
    [zegoLiveApi setAVConfig:[HXSettingSession session].configure];
    [zegoLiveApi setLocalView:_liveView];
    [zegoLiveApi setLocalViewMode:ZegoVideoViewModeScaleAspectFill];
    [zegoLiveApi setFrontCam:_frontCamera];
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

- (void)endLiveWithSnapShotImage:(UIImage *)image {
    [self leaveRoom];
    
    _endViewController.snapShotImage = image;
    _endCountContainer.hidden = NO;
}

- (void)leaveRoom {
    [_viewModel.leaveRoomCommand execute:nil];
    
    ZegoLiveApi *zegoLiveApi = [HXZegoAVKitManager manager].zegoLiveApi;
    [zegoLiveApi stopPreview];
    [zegoLiveApi logoutChannel];
}

- (void)signalLink {
    [_viewModel.barragesSignal subscribeNext:^(NSArray *barrages) {
        self->_barrageContainer.barrages = barrages;
    }];
    [_viewModel.exitSignal subscribeNext:^(id x) {
        ;
    }];
    [_viewModel.rewardSignal subscribeNext:^(NSNumber *rewardTotal) {
        [self updateAlbumView];
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
        
        b = [zegoLiveApi enableBeautifying:_beauty];
        assert(b);
        
        b = [zegoLiveApi setFilter:ZEGO_FILTER_NONE];
        assert(b);
        
        b = [zegoLiveApi startPublishingWithTitle:_roomTitle streamID:nil];
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

- (void)onVideoSizeChanged:(NSString *)streamID width:(uint32)width height:(uint32)height {
    NSLog(@"%s", __func__);
}

- (void)onTakeRemoteViewSnapshot:(CGImageRef)img view:(RemoteViewIndex)index {}

- (void)onTakeLocalViewSnapshot:(CGImageRef)img {
    UIImage *snapShotImage = [UIImage imageWithCGImage:img];
    [self endLiveWithSnapShotImage:snapShotImage];
}

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
            HXLiveBarrageViewController *commentViewController = [HXLiveBarrageViewController instance];
            commentViewController.roomID = _roomID;
            [self addChildViewController:commentViewController];
            [self.view addSubview:commentViewController.view];
            break;
        }
        case HXRecordBottomBarActionBeauty: {
            _beauty = !_beauty;
            [[HXZegoAVKitManager manager].zegoLiveApi enableBeautifying:_beauty];
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
    }
}

#pragma mark - HXPreviewLiveViewControllerDelegate Methods
- (void)previewControllerHandleFinishedShouldStartLive:(HXPreviewLiveViewController *)viewController liveModel:(HXLiveModel *)model frontCamera:(BOOL)frontCamera beauty:(BOOL)beauty {
    _frontCamera = frontCamera;
    _beauty      = beauty;
    
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

//#pragma mark - HXWatcherContainerViewControllerDelegate Methods
//- (void)watcherContainer:(HXWatcherContainerViewController *)container shouldShowWatcher:(HXWatcherModel *)watcher {
//    [HXWatcherBoard showWithWatcher:watcher gaged:^{
//        [MiaAPIHelper forbidUser:watcher.uID completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
//            if (success) {
//                [self showBannerWithPrompt:[watcher.nickName stringByAppendingString:@"已禁言！"]];
//            } else {
//                [self showBannerWithPrompt:userInfo[MiaAPIKey_Values][MiaAPIKey_Error]];
//            }
//        } timeoutBlock:^(MiaRequestItem *requestItem) {
//            [self showBannerWithPrompt:TimtOutPrompt];
//        }];
//    } closed:^{
//        ;
//    }];
//}

#pragma mark - HXLiveBarrageContainerViewControllerDelegate Methods
- (void)barrageContainer:(HXLiveBarrageContainerViewController *)container shouldShowBarrage:(HXBarrageModel *)barrage {
    ;
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
