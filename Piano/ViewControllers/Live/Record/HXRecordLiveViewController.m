//
//  HXRecordLiveViewController.m
//  Piano
//
//  Created by miaios on 16/3/18.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXRecordLiveViewController.h"
#import "HXZegoAVKitManager.h"
#import <ZegoAVKit/ZegoMoviePlayer.h>
#import "HXSettingSession.h"
#import "HXUserSession.h"
#import "HXRecordAnchorView.h"
#import "HXRecordBottomBar.h"
#import "HXPreviewLiveViewController.h"
#import "HXLiveEndViewController.h"
#import "HXWatcherContainerViewController.h"
#import "HXLiveCommentContainerViewController.h"
#import "HXLiveCommentViewController.h"
#import "HXRecordLiveViewModel.h"
#import "UIButton+WebCache.h"
#import "HXWatcherBoard.h"


@interface HXRecordLiveViewController () <
ZegoChatDelegate,
ZegoVideoDelegate,
HXRecordAnchorViewDelegate,
HXRecordBottomBarDelegate,
HXPreviewLiveViewControllerDelegate,
HXLiveEndViewControllerDelegate,
HXWatcherContainerViewControllerDelegate,
HXLiveCommentContainerViewControllerDelegate
>
@end


@implementation HXRecordLiveViewController {
    HXPreviewLiveViewController *_previewViewController;
    HXLiveEndViewController *_endViewController;
    HXWatcherContainerViewController *_watcherContianer;
    HXLiveCommentContainerViewController *_commentContainer;
    
    NSString *_roomID;
    NSString *_roomTitle;
    NSString *_shareUrl;
    
    HXRecordLiveViewModel *_viewModel;
    BOOL _frontCamera;
    BOOL _microEnable;
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
    } else if ([segue.identifier isEqualToString:NSStringFromClass([HXWatcherContainerViewController class])]) {
        _watcherContianer = segue.destinationViewController;
        _watcherContianer.delegate = self;
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
    _microEnable = YES;
}

- (void)viewConfigure {
    ZegoAVApi *zegoAVApi = [HXZegoAVKitManager manager].zegoAVApi;
    //设置回调代理
    [zegoAVApi setChatDelegate:self callbackQueue:dispatch_get_main_queue()];
    [zegoAVApi setVideoDelegate:self callbackQueue:dispatch_get_main_queue()];
    
    [self updateAnchorView];
}

#pragma mark - Event Response
- (IBAction)closeButtonPressed {
    [_anchorView stopRecordTime];
    [[HXZegoAVKitManager manager].zegoAVApi takeLocalViewSnapshot];
}

#pragma mark - Private Methods
- (void)shouldSteady:(BOOL)steady {
    [[UIApplication sharedApplication] setIdleTimerDisabled:steady];
}

- (void)startLive {
    ZegoAVApi *zegoAVApi = [HXZegoAVKitManager manager].zegoAVApi;
    //进入聊天室
    ZegoUser *user = [ZegoUser new];
    user.userID = [HXUserSession session].uid;
    user.userName = [HXUserSession session].nickName;
    
    [zegoAVApi getInChatRoom:user zegoToken:0 zegoId:0];
    [zegoAVApi setAVConfig:[HXSettingSession session].configure];
}

- (void)endLiveWithSnapShotImage:(UIImage *)image {
    [self leaveRoom];
    
    _endViewController.snapShotImage = image;
    _endCountContainer.hidden = NO;
}

- (void)leaveRoom {
    [_viewModel.leaveRoomCommand execute:nil];
    [[HXZegoAVKitManager manager].zegoAVApi leaveChatRoom];
}

- (void)signalLink {
    @weakify(self)
    [_viewModel.enterSignal subscribeNext:^(NSArray *watchers) {
        @strongify(self)
        self->_watcherContianer.watchers = watchers;
        self.anchorView.countLabel.text = _viewModel.onlineCount;
    }];
    [_viewModel.exitSignal subscribeNext:^(id x) {
        ;
    }];
    [_viewModel.commentSignal subscribeNext:^(NSArray *comments) {
        @strongify(self)
        self->_commentContainer.comments = comments;
    }];
}

- (void)updateAnchorView {
    [_anchorView.avatar sd_setImageWithURL:[NSURL URLWithString:[HXUserSession session].user.avatarUrl] forState:UIControlStateNormal];
}

#pragma mark - ZegoChatDelegate
- (void)onGetInChatRoomResult:(uint32)result zegoToken:(uint32)zegoToken zegoId:(uint32)zegoId {
    if (result == 0) {
        NSLog(@"进入聊天室成功，开始启动直播...");
    } else {
        NSLog(@"进入聊天室失败!");
        return;
    }
    
    ZegoAVApi *zegoApi = [HXZegoAVKitManager manager].zegoAVApi;
    [zegoApi setLocalView:_liveView];
    [zegoApi startPreview];
    [zegoApi startPublishInChatRoom:_roomTitle];
    NSLog(@"直播中!");
}

- (void)onChatRoomDisconnected:(uint32)err {
    NSLog(@"已经从聊天室断开了:%u", err);
    NSLog(@"直播终止");
}

- (void)onKickOut:(uint32) reason msg:(NSString*)msg {
    NSLog(@"\n已经被踢出聊天室 （%d:%@）", reason, msg);
}

- (void)onPlayListUpdate:(PlayListUpdateFlag)flag playList:(NSArray*)list {
    ZegoAVApi *zegoAVApi = [HXZegoAVKitManager manager].zegoAVApi;
    
    if (flag == PlayListUpdateFlag_Error || list.count <= 0) {
        NSLog(@"直播出错");
        NSLog(@"无法拉取到直播信息！请退出重进！");
        return;
    }
    
    if (flag == PlayListUpdateFlag_Remove) {
        NSDictionary * dictStream = list[0];
        if ([[dictStream objectForKey:PUBLISHER_ID] isEqualToString:[HXUserSession session].uid]) {
            return;     //是自己停止直播的消息，应该在停止时处理过相关逻辑，这里不再处理
        }
    } else {
        if (flag == PlayListUpdateFlag_UpdateAll) {
//            [[HXZegoAVKitManager manager].zegoAVApi stopPlayInChatRoom:streamID];
        }
        
        for (NSUInteger i = 0; i < list.count; i++) {
            NSDictionary *dictStream = list[i];
            if ([[dictStream objectForKey:PUBLISHER_ID] isEqualToString:[HXUserSession session].uid]) {
                continue;     //是自己发布直播的消息，应该在发布时处理过相关逻辑，这里不再处理
            }
            
            //有新流加入，找到一个空闲的view来播放，如果已经有两路播放，则停止比较老的流，播放新流
            NSInteger newStreamID = [[dictStream objectForKey:STREAM_ID] longLongValue];
            [zegoAVApi startPlayInChatRoom:RemoteViewIndex_First streamID:newStreamID];
        }
    }
}

#pragma mark - ZegoVideoDelegate
- (void)onPublishSucc:(uint32)zegoToken zegoId:(uint32)zegoId title:(NSString *)title {
    NSLog(@"启动直播成功，直播进行中...");
    [_anchorView starRecordTime];
}

- (void)onPublishStop:(ShowErrCode)err zegoToken:(uint32)zegoToken zegoId:(uint32)zegoId title:(NSString *)title {
    if (err == ShowErrCode_Temp_Broken) {
        NSLog(@"网络优化中...");
        NSLog(@"直播已经被停止！");
        
        //临时中断，尝试重新启动发布直播
        ZegoAVApi *zegoAVApi = [HXZegoAVKitManager manager].zegoAVApi;
        [zegoAVApi startPreview];
    } else if (err == ShowErrCode_End) {
        //发布流正常结束
    }
}

- (void)onPlaySucc:(long long)streamID zegoToken:(uint32)zegoToken zegoId:(uint32)zegoId title:(NSString *)title {
    NSLog(@"直播中...");
}

- (void)onPlayStop:(uint32)err streamID:(long long)streamID zegoToken:(uint32)zegoToken zegoId:(uint32)zegoId title:(NSString *)title {
    if (err == ShowErrCode_Temp_Broken) {
        NSLog(@"网络优化中...");
    } else if (err == ShowErrCode_End) {
        NSLog(@"直播结束");
    }
}

- (void)onVideoSizeChanged:(long long)streamID width:(uint32)width height:(uint32)height{
    NSLog(@"%@ onVideoSizeChanged width: %u height:%u", self, width, height);
}

- (void)onPlayerCountUpdate:(uint32)userCount {
    NSLog(@"观看直播的人数:%@", @(userCount));
}

- (void)onSetPublishExtraDataResult:(uint32)errCode zegoToken:(uint32)zegoToken zegoId:(uint32)zegoId dataKey:(NSString*)strDataKey {
    ;
}

- (void)onTakeRemoteViewSnapshot:(CGImageRef)img {
    ;
}

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
            [[HXZegoAVKitManager manager].zegoAVApi setFrontCam:_frontCamera];
            break;
        }
        case HXRecordBottomBarActionMute: {
            _microEnable = !_microEnable;
            [[HXZegoAVKitManager manager].zegoAVApi enableMic:_microEnable];
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
- (void)previewControllerHandleFinishedShouldStartLive:(HXPreviewLiveViewController *)viewController roomID:(NSString *)roomID roomTitle:(NSString *)roomTitle shareUrl:(NSString *)shareUrl frontCamera:(BOOL)frontCamera {
    
    _roomID = roomID;
    _roomTitle = roomTitle;
    _shareUrl = shareUrl;
    _frontCamera = frontCamera;
    
    [self startLive];
    
    _viewModel = [[HXRecordLiveViewModel alloc] initWithRoomID:roomID];
    [self signalLink];
    
    _previewContainer.hidden = YES;
    [_previewContainer removeFromSuperview];
    _previewContainer = nil;
}

#pragma mark - HXLiveEndViewControllerDelegate Methods
- (void)endViewControllerWouldLikeExitRoom:(HXLiveEndViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - HXWatcherContainerViewControllerDelegate Methods
- (void)watcherContainer:(HXWatcherContainerViewController *)container shouldShowWatcher:(HXWatcherModel *)watcher {
    [HXWatcherBoard showWithWatcher:watcher gaged:^{
        ;
    } closed:^{
        ;
    }];
}

#pragma mark - HXLiveCommentContainerViewControllerDelegate Methods
- (void)commentContainer:(HXLiveCommentContainerViewController *)container shouldShowComment:(HXCommentModel *)comment {
    ;
}

@end
