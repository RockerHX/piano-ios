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
#import "JOBaseSDK.h"

static CGFloat const kPopButtonWidth = 40.;

@interface MIAVideoPlayViewController()

@property (nonatomic, strong) UIButton *popButton;

@property (nonatomic, strong) UIView *playView;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) MIAPlaySlider *playSlider;

@end

@implementation MIAVideoPlayViewController

- (void)loadView{

    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self createPlayView];
    [self createPopButton];
    [self createPlaySliderView];
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

- (void)createPlaySliderView{

    self.playSlider = [MIAPlaySlider newAutoLayoutView];
    [_playSlider setMinimumTrackTintColor:JORGBSameCreate(200.)];
    [_playSlider setThumbTintColor:JORGBSameCreate(200.)];
    [_playSlider setMaximumTrackTintColor:JORGBCreate(200., 200., 200., 0.7)];
    [_playView addSubview:_playSlider];
    
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:-10. selfView:_playSlider superView:_playView];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:10. selfView:_playSlider superView:_playView];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-10. selfView:_playSlider superView:_playView];
    [JOAutoLayout autoLayoutWithHeight:20. selfView:_playSlider superView:_playView];
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    _playerLayer.frame = _playView.bounds;
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
