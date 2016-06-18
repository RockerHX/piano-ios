//
//  MIAVideoPlayViewController.m
//  Piano
//
//  Created by 刘维 on 16/5/27.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAVideoPlayViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIViewController+HXClass.h"
#import "MIAPlaySlider.h"
#import "MIAPlayBarView.h"
#import "JOBaseSDK.h"
#import "MusicMgr.h"
#import "MiaAPIHelper.h"
#import "MIAReportManage.h"

static CGFloat const kPopButtonWidth = 40.; //右上角退出按钮的宽度.

static NSTimeInterval const kHiddenEventViewDefaultTime = 5.;//默认隐藏的按钮事件的事件

@interface MIAVideoPlayViewController(){

    BOOL finishedState;
    BOOL playState;
    NSTimeInterval loadTime;
    dispatch_source_t timer;
}

@property (nonatomic, strong) UIButton *popButton;

@property (nonatomic, strong) UIView *playView;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) MIAPlayBarView *playBarView;

@property (nonatomic, strong) UIView *videoLoadingView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic, strong) NSTimer *hiddenPlayBarTimer;

@end

@implementation MIAVideoPlayViewController

- (void)loadView{

    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    if ([[MusicMgr standard] isPlaying]) {
        [[MusicMgr standard] pause];
    }

    finishedState = NO;
    playState = NO;
    [self createPlayView];
    [self createPopButton];
    [self createPlayBarView];
    [self addAVPlayObserver];
    [self timerUpdate];
    [self createLodingView];
    [_player play];
    [self showLodingView];
}

- (void)resetHiddenPlayBarViewTimer{

    [self setPlayEventViewHiddenState:NO];
    
    if (_hiddenPlayBarTimer && [_hiddenPlayBarTimer isValid]) {
        [_hiddenPlayBarTimer invalidate];
    }
    self.hiddenPlayBarTimer = [NSTimer scheduledTimerWithTimeInterval:kHiddenEventViewDefaultTime target:self selector:@selector(hiddenEventView) userInfo:nil repeats:NO];
}

- (void)hiddenEventView{

//    JOLog(@"隐藏事件按钮");
    [self setPlayEventViewHiddenState:YES];
}

- (void)createLodingView{

    self.videoLoadingView = [UIView newAutoLayoutView];
    [_videoLoadingView setBackgroundColor:[UIColor clearColor]];
    [[_videoLoadingView layer] setCornerRadius:5.];
    [[_videoLoadingView layer] setMasksToBounds:YES];
    [_videoLoadingView setHidden:YES];
    [self.view addSubview:_videoLoadingView];
    
    [JOAutoLayout autoLayoutWithCenterWithView:self.view selfView:_videoLoadingView superView:self.view];
    [JOAutoLayout autoLayoutWithSize:JOSize(70., 70.) selfView:_videoLoadingView superView:self.view];
    
    self.indicatorView = [UIActivityIndicatorView newAutoLayoutView];
    [_indicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_indicatorView startAnimating];
    [_videoLoadingView addSubview:_indicatorView];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0, .0, 0., 0.) selfView:_indicatorView superView:_videoLoadingView];
}

- (void)showLodingView{

    [_videoLoadingView setHidden:NO];
}

- (void)hiddenLodingView{

    [_videoLoadingView setHidden:YES];
}

- (void)createPlayView{

    self.playView = [UIView newAutoLayoutView];
    [_playView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:_playView];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_playView superView:self.view];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playViewTap:)];
    [_playView addGestureRecognizer:tapGesture];
    
    NSURL *url = [NSURL URLWithString:_videoURLString];
    self.playerItem = [AVPlayerItem playerItemWithURL:url];
    _player = [AVPlayer playerWithPlayerItem:_playerItem];
    
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [_playView.layer addSublayer:_playerLayer];
}

- (void)createPopButton{

    self.popButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_popButton setImage:[UIImage imageNamed:@"VP-Close"] forState:UIControlStateNormal];
    [_popButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_popButton addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_popButton];
    
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-10. selfView:_popButton superView:self.view];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:10. selfView:_popButton superView:self.view];
    [JOAutoLayout autoLayoutWithSize:JOSize(kPopButtonWidth, kPopButtonWidth) selfView:_popButton superView:self.view];
}

- (void)createPlayBarView{
    
    self.playBarView = [MIAPlayBarView newAutoLayoutView];
    
    @weakify(self);
    [_playBarView palyBarActionHanlder:^(PlayBarActionType type) {
    @strongify(self);
        if (type == PlayBarActionPlay) {
            //播放
            if (finishedState) {
                //结束的状态
                finishedState = NO;
                [self.player seekToTime:CMTimeMake(0, 1)];
            }else{
                //暂停的状态
            }
            
            playState = YES;
            [self.player play];
        }else if (type == PlayBarActionPause){
            //暂停
            playState = NO;
            [self.player pause];
        }else if (type == PlayBarActionSlider){
            //滑动
            finishedState = NO;
           [self.player seekToTime:CMTimeMake([self.playBarView currentPlayTime], 1)
                 completionHandler:^(BOOL finished) {
                     if (finished) {
                        }
                 }];
        }else if (type == PlayBarActionShare){
            //分享 暂时用来作为举报的按钮事件
            [MiaAPIHelper reportWithType:@"视频"
                                 content:@"视频内容"
                           completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                               
                               if (success) {
                                   
                                   [self showBannerWithPrompt:@"视频举报成功"];
                               }else{
                                   [self showBannerWithPrompt:@"视频举报失败"];
                               }
                           } timeoutBlock:^(MiaRequestItem *requestItem) {
                               [self showBannerWithPrompt:@"视频举报失败"];
                               
                           }];
        }
        
        [self resetHiddenPlayBarViewTimer];
    }];
    [_playView addSubview:_playBarView];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_playBarView superView:_playView];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_playBarView superView:_playView];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_playBarView superView:_playView];
    [JOAutoLayout autoLayoutWithHeight:40. selfView:_playBarView superView:_playView];
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    _playerLayer.frame = _playView.bounds;
}

#pragma mark - notice

- (void)addAVPlayObserver{
    
    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [_playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    [_playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinished) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playError) name:AVPlayerItemFailedToPlayToEndTimeNotification object:nil];

}

- (void)removeAVPlayObserver{
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [_playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [_playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemFailedToPlayToEndTimeNotification object:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    AVPlayerItem *playerItem = object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        if(status==AVPlayerStatusReadyToPlay){
            
            playState = YES;
            [self hiddenLodingView];
            [_playBarView setCurrentPlayState:YES];
            [_playBarView setCurrentVideoDuration:playerItem.duration.value/playerItem.duration.timescale];
            
            [self resetHiddenPlayBarViewTimer];
        }
        
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        
        //每次缓冲得到新数据 用来跟当前视屏播放的时间做一个对比,若当前缓冲时间小于播放的时间则表示 需要等待缓冲才能播放
        NSArray *array=playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        loadTime = startSeconds + durationSeconds;//缓冲总长度
//        [self checkPlayState];
//        NSLog(@"startSecond:%.2f",startSeconds);
//        NSLog(@"DurationSeconds:%.2f",durationSeconds);
//        NSLog(@"共缓冲：%.2f",loadTime);
    }else if ([keyPath isEqualToString:@"playbackBufferEmpty"]){
    
//        NSLog(@"缓冲数据为空");
        [_player pause];
        
        if (playState) {
            [_playBarView setCurrentPlayState:NO];
            [self showLodingView];
        }

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            if (playState) {
                [_player play];
                [_playBarView setCurrentPlayState:YES];
                [self hiddenLodingView];
                //rate 是avplayer 是一个属性，rate 1.0表示正在播放，0.0暂停， -1播放器失效
                if (_player.rate <= 0) {
                    //播放异常
                    
                }
            }
        });
    }else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]){
        
        if(playerItem.playbackLikelyToKeepUp){
//            NSLog(@"正常播放");
            if (playState) {
                [_player play];
                [self hiddenLodingView];
            }
        }
    }
}

#pragma mark - Tap gesture

- (void)playViewTap:(UIGestureRecognizer *)gesture{

//    [self setPlayEventViewHiddenState:!_popButton.hidden];
    [self resetHiddenPlayBarViewTimer];
}

- (void)setPlayEventViewHiddenState:(BOOL)state{

    [_popButton setHidden:state];
    [_playBarView setHidden:state];
    
//    if(!state){
//    
//        [self performSelector:@selector(hiddenPlayEventView) withObject:nil afterDelay:kHiddenEventViewDefaultTime];
//    }
}

- (void)hiddenPlayEventView{

    [self setPlayEventViewHiddenState:YES];
}

#pragma mark - play state


//- (void)playTimeJumped:(NSNotification *)notice{
//
//    AVPlayerItem *playItem = notice.object;
//    NSLog(@"时间的跳转value:%lld",playItem.duration.value);
//    
//    if ((playItem.duration.value > 0) && !finishedState) {
//        
//        [_playBarView setCurrentPlayState:YES];
//        [_playBarView setCurrentVideoDuration:playItem.duration.value/playItem.duration.timescale];
//    }
//}

- (void)playFinished{

    NSLog(@"播放结束");
    finishedState = YES;
    [_playBarView setCurrentPlayState:NO];
    [self popAction];
}

- (void)playError{

    [self showAlertWithMessage:[NSString stringWithFormat:@"播放出现了错误:%@",_player.error.domain] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        
    }];
}

#pragma mark - time update

- (void)timerUpdate {
    uint64_t interval = NSEC_PER_SEC;
    dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, 0), interval, 0);
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updatePlayBarTime];
        });
    });
    dispatch_resume(timer);
}

- (void)updatePlayBarTime{

    CMTime time = [_player currentTime];
    CGFloat currentTime = 0.0f;
    if (time.timescale > 0.0f) {
        currentTime = time.value / time.timescale;
    }
    
    [_playBarView setCurrentPlayTime:currentTime];
}

#pragma mark - button Action

- (void)popAction{

    dispatch_source_cancel(timer);
    [_player pause];
    _player = nil;
    [self removeAVPlayObserver];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - interface orientation

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
    
}

@end
