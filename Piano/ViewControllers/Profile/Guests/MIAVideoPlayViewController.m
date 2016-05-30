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

static CGFloat const kPopButtonWidth = 40.; //右上角退出按钮的宽度.

@interface MIAVideoPlayViewController(){

    BOOL finishedState;
    dispatch_source_t timer;
}

@property (nonatomic, strong) UIButton *popButton;

@property (nonatomic, strong) UIView *playView;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) MIAPlayBarView *playBarView;

@end

@implementation MIAVideoPlayViewController

- (void)loadView{

    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    finishedState = NO;
    [self createPlayView];
    [self createPopButton];
    [self createPlayBarView];
    [self addAVPlayObserver];
    [self timerUpdate];
    [_player play];
}

- (void)createPlayView{

    self.playView = [UIView newAutoLayoutView];
    [_playView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:_playView];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_playView superView:self.view];
    
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
            [self.player play];
        }else if (type == PlayBarActionPause){
            //暂停
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
            //分享
        }
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinished) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playError) name:AVPlayerItemFailedToPlayToEndTimeNotification object:nil];

}

- (void)removeAVPlayObserver{
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemFailedToPlayToEndTimeNotification object:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    AVPlayerItem *playerItem = object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        if(status==AVPlayerStatusReadyToPlay){

            [_playBarView setCurrentPlayState:YES];
            [_playBarView setCurrentVideoDuration:playerItem.duration.value/playerItem.duration.timescale];
        }
    }
//    else if([keyPath isEqualToString:@"loadedTimeRanges"])
//    {
//        NSArray *array=playerItem.loadedTimeRanges;
//        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
//        float startSeconds = CMTimeGetSeconds(timeRange.start);
//        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
//        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
//        NSLog(@"共缓冲：%.2f",totalBuffer);
//    }
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
