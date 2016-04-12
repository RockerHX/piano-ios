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
    
    BOOL _startPlay;
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
    
    [self playerConfigure];
    [self timerConfigure];
}

- (void)viewConfigure {
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.bounds;
    [self.replayView.layer addSublayer:layer];
    
    _bottomBar.duration = _model.duration;
}

- (void)playerConfigure {
    NSURL *url = [NSURL URLWithString:_model.videoUrl];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    _player = [AVPlayer playerWithPlayerItem:item];
}

- (void)timerConfigure {
    uint64_t interval = NSEC_PER_MSEC * 100;
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
    if ((playItem.duration.value > 0) && !_startPlay) {
        _startPlay = YES;
        [self fetchBarrageData];
    }
}

- (void)playFinished {
    dispatch_source_cancel(_timer);
    _bottomBar.currentTime = _model.duration;
}

- (void)playError {
    ;
}

#pragma mark - Private Methods
- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)readPlayTime {
    CMTime time = [_player currentTime];
    CGFloat currentTime = time.value / time.timescale;
    _bottomBar.currentTime = currentTime;
    
    if ((currentTime >= _viewModel.timeNode) && _startPlay) {
        [self fetchBarrageData];
    }
}

- (void)fetchBarrageData {
    @weakify(self)
    RACSignal *fetchCommentSiganl = [_viewModel.fetchCommentCommand execute:nil];
    [fetchCommentSiganl subscribeError:^(NSError *error) {
        @strongify(self)
        [self showBannerWithPrompt:error.domain];
    } completed:^{
        @strongify(self)
        self->_containerViewController.comments = self->_viewModel.comments;
    }];
}

#pragma mark - HXLiveCommentContainerViewControllerDelegate Methods
- (void)commentContainer:(HXLiveCommentContainerViewController *)container shouldShowComment:(HXCommentModel *)comment {
    ;
}

#pragma mark - HXLiveAnchorViewDelegate Methods
- (void)anchorView:(HXLiveAnchorView *)anchorView takeAction:(HXLiveAnchorViewAction)action {
    ;
}

#pragma mark - HXReplayBottomBarDelegate Methods
- (void)bottomBar:(HXReplayBottomBar *)bar takeAction:(HXReplayBottomBarAction)action {
    switch (action) {
        case HXReplayBottomBarActionPlay: {
            [_player play];
            break;
        }
        case HXReplayBottomBarActionPause: {
            [_player pause];
            break;
        }
        case HXReplayBottomBarActionShare: {
            ;
            break;
        }
    }
}

- (void)bottomBar:(HXReplayBottomBar *)bar dragProgressBar:(CGFloat)progress {
    CMTime time = (CMTime){_model.duration * progress, 1, 1, 0};
    [_player seekToTime:time completionHandler:^(BOOL finished) {
        ;
    }];
}

@end
