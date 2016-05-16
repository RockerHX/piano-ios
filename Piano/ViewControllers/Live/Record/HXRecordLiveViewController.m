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
#import "HXLiveCommentContainerViewController.h"
#import "HXLiveCommentViewController.h"
#import "HXRecordLiveViewModel.h"
#import "UIButton+WebCache.h"
#import "HXWatcherBoard.h"
#import "MiaAPIHelper.h"


@interface HXRecordLiveViewController () <
ZegoLiveApiDelegate,
HXRecordAnchorViewDelegate,
HXRecordBottomBarDelegate,
HXPreviewLiveViewControllerDelegate,
HXLiveEndViewControllerDelegate,
HXLiveCommentContainerViewControllerDelegate
>
@end


@implementation HXRecordLiveViewController {
    HXPreviewLiveViewController *_previewViewController;
    HXLiveEndViewController *_endViewController;
    HXLiveCommentContainerViewController *_commentContainer;
    
    NSString *_roomID;
    NSString *_roomTitle;
    NSString *_shareUrl;
    
    HXRecordLiveViewModel *_viewModel;
    BOOL _frontCamera;
    BOOL _microEnable;
    BOOL _beauty;
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
    } else if ([segue.identifier isEqualToString:NSStringFromClass([HXLiveCommentContainerViewController class])]) {
        _commentContainer = segue.destinationViewController;
        _commentContainer.delegate = self;
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
    _frontCamera = YES;
    _microEnable = YES;
}

- (void)viewConfigure {
    //设置回调代理
    [[HXZegoAVKitManager manager].zegoLiveApi setDelegate:self];
    
    [self updateAnchorView];
    [self startPreview];
}

#pragma mark - Event Response
- (IBAction)closeButtonPressed {
    [_anchorView stopRecordTime];
    
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
    [[HXZegoAVKitManager manager].zegoLiveApi logoutChannel];
}

- (void)signalLink {
    @weakify(self)
    [_viewModel.barragesSignal subscribeNext:^(NSArray *barrages) {
        @strongify(self)
        self->_commentContainer.comments = barrages;
    }];
    [_viewModel.exitSignal subscribeNext:^(id x) {
        ;
    }];
}

- (void)updateAnchorView {
    [_anchorView.avatar sd_setImageWithURL:[NSURL URLWithString:[HXUserSession session].user.avatarUrl] forState:UIControlStateNormal];
}

#pragma mark - ZegoLiveApiDelegate
- (void)onLoginChannel:(uint32)error {
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

- (void)onPublishSucc:(NSString *)streamID {
    NSLog(@"%s, stream: %@", __func__, streamID);
    [_anchorView startRecordTime];
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

- (void)onTakeRemoteViewSnapshot:(CGImageRef)img view:(RemoteViewIndex)index {}

- (void)onTakeLocalViewSnapshot:(CGImageRef)img {
//    UIImage *snapShotImage = [UIImage imageWithCGImage:img];
//    [self endLiveWithSnapShotImage:snapShotImage];
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
            HXLiveCommentViewController *commentViewController = [HXLiveCommentViewController instance];
            commentViewController.roomID = _roomID;
            [self addChildViewController:commentViewController];
            [self.view addSubview:commentViewController.view];
            break;
        }
        case HXRecordBottomBarActionBeauty: {
            ;
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
            ;
            break;
        }
        case HXRecordBottomBarActionShare: {
            ;
            break;
        }
    }
}

#pragma mark - HXPreviewLiveViewControllerDelegate Methods
- (void)previewControllerHandleFinishedShouldStartLive:(HXPreviewLiveViewController *)viewController roomID:(NSString *)roomID roomTitle:(NSString *)roomTitle shareUrl:(NSString *)shareUrl frontCamera:(BOOL)frontCamera beauty:(BOOL)beauty {
    
    _roomID = roomID;
    _roomTitle = roomTitle;
    _shareUrl = shareUrl;
    _frontCamera = frontCamera;
    _beauty = beauty;
    
    [self startPublish];
    
    _viewModel = [[HXRecordLiveViewModel alloc] initWithRoomID:roomID];
    [self signalLink];
    
    _previewContainer.hidden = YES;
    _topBar.hidden = NO;
    _barragesView.hidden = NO;
    _bottomBar.hidden = NO;
    [_previewContainer removeFromSuperview];
    _previewContainer = nil;
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

#pragma mark - HXLiveCommentContainerViewControllerDelegate Methods
- (void)commentContainer:(HXLiveCommentContainerViewController *)container shouldShowComment:(HXCommentModel *)comment {
    ;
}

@end
