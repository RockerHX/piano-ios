//
//  HXReplayViewController.m
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXReplayViewController.h"
#import "HXLiveBarrageContainerViewController.h"
#import "HXLiveAnchorView.h"
#import "HXReplayBottomBar.h"
#import <AVFoundation/AVFoundation.h>
#import "HXReplayViewModel.h"
#import "UIButton+WebCache.h"
#import "HXUserSession.h"
#import "HXLiveModel.h"
#import "MiaAPIHelper.h"
#import "BlocksKit+UIKit.h"
#import "BFRadialWaveHUD.h"


@interface HXReplayViewController () <
HXLiveBarrageContainerViewControllerDelegate,
HXLiveAnchorViewDelegate,
HXReplayBottomBarDelegate
>
@end


@implementation HXReplayViewController {
    HXLiveBarrageContainerViewController *_barrageContainer;
    
    HXReplayViewModel *_viewModel;
    AVPlayer *_player;
    dispatch_source_t _timer;
    BFRadialWaveHUD *_hud;
    
    BOOL _play;
}

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameLive;
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
    
    [_player play];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    [self showLoadingHUD];
    
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
    _anchorView.replay = YES;
    _bottomBar.duration = _model.duration;
}

- (void)sigalLink {
    @weakify(self)
    if (([HXUserSession session].state == HXUserStateLogin) && ![[HXUserSession session].uid isEqualToString:_viewModel.model.uID]) {
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
    
    [_viewModel.viewReplayCommand execute:nil];
}

- (void)playerConfigure {
    NSURL *url = [NSURL URLWithString:_model.videoUrl];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    _player = [AVPlayer playerWithPlayerItem:item];
}

- (void)timerConfigure {
    uint64_t interval = NSEC_PER_MSEC * 200;
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
    [self showErrorLoading];
}

#pragma mark - Private Methods
- (void)showLoadingHUD {
    if (!_hud) {
        _hud = [[BFRadialWaveHUD alloc] initWithView:_replayView
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
    dispatch_source_cancel(_timer);
    _play = NO;
    [_player pause];
    _player = nil;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)readPlayTime {
    CMTime time = [_player currentTime];
    CGFloat currentTime = 0.0f;
    if (time.timescale > 0.0f) {
        [self hiddenLoadingHUD];
        currentTime = time.value / time.timescale;
    }
    _bottomBar.currentTime = currentTime;
    
    if ((currentTime >= _viewModel.timeNode) && _play) {
        [self fetchBarrageData];
    }
}

- (void)fetchBarrageData {
    @weakify(self)
    RACSignal *fetchBarrageSiganl = [_viewModel.fetchBarrageCommand execute:nil];
    [fetchBarrageSiganl subscribeError:^(NSError *error) {
        @strongify(self)
        if (![error.domain isEqualToString:RACCommandErrorDomain]) {
            [self showBannerWithPrompt:error.domain];
        }
    } completed:^{
        _barrageContainer.barrages = _viewModel.barrages;
    }];
}

- (void)updateAnchorView {
    [_anchorView.avatar sd_setImageWithURL:[NSURL URLWithString:_viewModel.anchorAvatar] forState:UIControlStateNormal];
    _anchorView.nickNameLabel.text = _viewModel.anchorNickName;
    _anchorView.countLabel.text = _viewModel.viewCount;
    _anchorView.ownside = [[HXUserSession session].uid isEqualToString:_viewModel.model.uID];
}

#pragma mark - HXLiveBarrageContainerViewControllerDelegate Methods
- (void)barrageContainer:(HXLiveBarrageContainerViewController *)container shouldShowBarrage:(HXBarrageModel *)barrage {
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
        case HXReplayBottomBarActionReport: {
            [MiaAPIHelper reportWithType:@"resport_anchor" content:_model.uID completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                [self showBannerWithPrompt:@"举报成功"];
            } timeoutBlock:^(MiaRequestItem *requestItem) {
                [self showBannerWithPrompt:@"网络超时，举报失败"];
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
            [self->_viewModel clearBarrages];
            [self->_viewModel updateTimeNode:currentTime];
            [self fetchBarrageData];
            
            if (!_play) {
                [_player play];
            }
        }
    }];
}

@end
