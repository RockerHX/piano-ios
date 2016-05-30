//
//  MIAVideoPlayViewController.m
//  Piano
//
//  Created by 刘维 on 16/5/27.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAVideoPlayViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MIAPlaySlider.h"
#import "MIAPlayBarView.h"
#import "JOBaseSDK.h"

static CGFloat const kPopButtonWidth = 40.;

@interface MIAVideoPlayViewController(){

    dispatch_source_t timer;
}

@property (nonatomic, strong) UIButton *popButton;

@property (nonatomic, strong) UIView *playView;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) MIAPlayBarView *playBarView;
@property (nonatomic, strong) MIAPlaySlider *playSlider;

@end

@implementation MIAVideoPlayViewController

- (void)loadView{

    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self createPlayView];
    [self createPopButton];
    [self createPlayBarView];
}

- (void)createPlayView{

    self.playView = [UIView newAutoLayoutView];
    [_playView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:_playView];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_playView superView:self.view];
    
    NSURL *url = [NSURL URLWithString:_videoURLString];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    _player = [AVPlayer playerWithPlayerItem:item];
    
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [_playView.layer addSublayer:_playerLayer];
    [_player play];
}

- (void)createPopButton{

    self.popButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_popButton setTitle:@"x" forState:UIControlStateNormal];
    [_popButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_popButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_popButton addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_popButton];
    
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-10. selfView:_popButton superView:self.view];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:10. selfView:_popButton superView:self.view];
    [JOAutoLayout autoLayoutWithSize:JOSize(kPopButtonWidth, kPopButtonWidth) selfView:_popButton superView:self.view];
}

- (void)createPlayBarView{

//    self.playSlider = [MIAPlaySlider newAutoLayoutView];
//    [_playSlider setMinimumTrackTintColor:JORGBSameCreate(200.)];
////    [_playSlider setThumbTintColor:JORGBSameCreate(200.)];
//    [_playSlider setSliderThumbHeight:20. color:JORGBSameCreate(200.)];
//    [_playSlider setMaximumTrackTintColor:JORGBCreate(200., 200., 200., 0.7)];
//    [_playView addSubview:_playSlider];
//    
//    [JOAutoLayout autoLayoutWithBottomSpaceDistance:-10. selfView:_playSlider superView:_playView];
//    [JOAutoLayout autoLayoutWithLeftSpaceDistance:10. selfView:_playSlider superView:_playView];
//    [JOAutoLayout autoLayoutWithRightSpaceDistance:-10. selfView:_playSlider superView:_playView];
//    [JOAutoLayout autoLayoutWithHeight:20. selfView:_playSlider superView:_playView];
    
    self.playBarView = [MIAPlayBarView newAutoLayoutView];
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
    
    [_playBarView setCurrentPlayTime:@""];
}

#pragma mark - button Action

- (void)popAction{

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
