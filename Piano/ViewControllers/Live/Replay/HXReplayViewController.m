//
//  HXReplayViewController.m
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXReplayViewController.h"
#import "HXLiveCommentContainerViewController.h"
#import "HXLiveAnchorView.h"
#import "HXReplayBottomBar.h"
#import <AVFoundation/AVFoundation.h>
#import "HXReplayViewModel.h"
#import "UIButton+WebCache.h"
#import "HXUserSession.h"
#import <ShareSDKUI/ShareSDKUI.h>


@interface HXReplayViewController () <
HXLiveCommentContainerViewControllerDelegate,
HXLiveAnchorViewDelegate,
HXReplayBottomBarDelegate
>
@end


@implementation HXReplayViewController {
    HXLiveCommentContainerViewController *_containerViewController;
    
    HXReplayViewModel *_viewModel;
    AVPlayer *_player;
    dispatch_source_t _timer;
    
    BOOL _play;
}

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameLive;
}

+ (NSString *)navigationControllerIdentifier {
    return @"HXReplayNavigationController";
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _containerViewController = segue.destinationViewController;
    _containerViewController.delegate = self;
}

#pragma mark - View Controller Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
    
    [_player play];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playTimeJumped:) name:AVPlayerItemTimeJumpedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinished) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playError) name:AVPlayerItemFailedToPlayToEndTimeNotification object:nil];
    
    _viewModel = [[HXReplayViewModel alloc] initWithDiscoveryModel:_model];
    [self sigalLink];
    
    [self playerConfigure];
    [self timerConfigure];
}

- (void)viewConfigure {
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.bounds;
    [self.replayView.layer addSublayer:layer];
    
    [self updateAnchorView];
    _bottomBar.duration = _model.duration;
}

- (void)sigalLink {
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

- (void)playerConfigure {
    NSURL *url = [NSURL URLWithString:_model.videoUrl];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    _player = [AVPlayer playerWithPlayerItem:item];
}

- (void)timerConfigure {
    uint64_t interval = NSEC_PER_SEC;
    dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, 0), interval, 0);
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self readPlayTime];
        });
    });
    dispatch_resume(_timer);
}

#pragma mark - Event Response
- (IBAction)closeButtonPressed {
    [self dismiss];
}

- (void)playTimeJumped:(NSNotification *)notification {
    AVPlayerItem *playItem = notification.object;
    if ((playItem.duration.value > 0) && !_play) {
        _play = YES;
        [self fetchBarrageData];
    }
}

- (void)playFinished {
    _play = NO;
    dispatch_source_cancel(_timer);
    _bottomBar.currentTime = _model.duration;
}

- (void)playError {
    _play = NO;
    dispatch_source_cancel(_timer);
}

#pragma mark - Private Methods
- (void)dismiss {
    dispatch_source_cancel(_timer);
    _play = NO;
    [_player pause];
    _player = nil;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)readPlayTime {
    CMTime time = [_player currentTime];
    CGFloat currentTime = time.value / time.timescale;
    _bottomBar.currentTime = currentTime;
    
    if ((currentTime >= _viewModel.timeNode) && _play) {
        [self fetchBarrageData];
    }
}

- (void)fetchBarrageData {
    @weakify(self)
    RACSignal *fetchCommentSiganl = [_viewModel.fetchCommentCommand execute:nil];
    [fetchCommentSiganl subscribeError:^(NSError *error) {
        @strongify(self)
        if (![error.domain isEqualToString:RACCommandErrorDomain]) {
            [self showBannerWithPrompt:error.domain];
        }
    } completed:^{
        @strongify(self)
        self->_containerViewController.comments = self->_viewModel.comments;
    }];
}

- (void)updateAnchorView {
    [_anchorView.avatar sd_setImageWithURL:[NSURL URLWithString:_viewModel.anchorAvatar] forState:UIControlStateNormal];
    _anchorView.nickNameLabel.text = _viewModel.anchorNickName;
    _anchorView.countLabel.text = _viewModel.viewCount;
}

#pragma mark - HXLiveCommentContainerViewControllerDelegate Methods
- (void)commentContainer:(HXLiveCommentContainerViewController *)container shouldShowComment:(HXCommentModel *)comment {
    ;
}

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

#pragma mark - HXReplayBottomBarDelegate Methods
- (void)bottomBar:(HXReplayBottomBar *)bar takeAction:(HXReplayBottomBarAction)action {
    switch (action) {
        case HXReplayBottomBarActionPlay: {
            _play = YES;
            [_player play];
            break;
        }
        case HXReplayBottomBarActionPause: {
            _play = NO;
            [_player pause];
            break;
        }
        case HXReplayBottomBarActionShare: {
            //1、创建分享参数（必要）
            NSMutableDictionary *shareParams = @{}.mutableCopy;
            [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                             images:[UIImage imageNamed:@"传入的图片名"]
                                                url:[NSURL URLWithString:@"http://mob.com"]
                                              title:@"分享标题"
                                               type:SSDKContentTypeAuto];
            
//            // 定制新浪微博的分享内容
//            [shareParams SSDKSetupSinaWeiboShareParamsByText:@"定制新浪微博的分享内容" title:nil image:[UIImage imageNamed:@"传入的图片名"] url:nil latitude:0 longitude:0 objectID:nil type:SSDKContentTypeAuto];
            // 定制微信好友的分享内容
            [shareParams SSDKSetupWeChatParamsByText:@"定制微信的分享内容" title:@"title" url:[NSURL URLWithString:@"http://mob.com"] thumbImage:nil image:[UIImage imageNamed:@"传入的图片名"] musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatSession];// 微信好友子平台
            
            //2、分享
            [ShareSDK showShareActionSheet:self.view
                                     items:nil
                               shareParams:shareParams
                       onShareStateChanged:
             ^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                 ;
             }];
            break;
        }
    }
}

- (void)bottomBar:(HXReplayBottomBar *)bar dragProgressBar:(CGFloat)progress {
    NSTimeInterval currentTime = _model.duration * progress;
    CMTime time = CMTimeMake(currentTime, 1);
    
    @weakify(self)
    [_player seekToTime:time completionHandler:^(BOOL finished) {
        @strongify(self)
        if (finished) {
            [self timerConfigure];
            [self->_viewModel clearComments];
            [self->_viewModel updateTimeNode:currentTime];
            [self fetchBarrageData];
            
            if (!_play) {
                [_player play];
            }
        }
    }];
}

@end
