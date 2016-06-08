//
//  MIAPlayBarView.m
//  Piano
//
//  Created by 刘维 on 16/5/30.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAPlayBarView.h"
#import "JOBaseSDK.h"
#import "MIAPlaySlider.h"
#import "MIAFontManage.h"

static CGFloat const kPlayBarViewLeftSpaceDistance = 10.;
static CGFloat const kPlayBarViewRightSpaceDistance = 10.;
static CGFloat const kPlayBarViewButtonToSliderSpaceDistance = 10.;
static CGFloat const kPlayBarViewSliderToTimeLabelSpaceDistance = 10.;
//static CGFloat const kPlayBarViewTimeLabelToButtonSpaceDistance = 10.;
static CGFloat const kPlayBarViewTimeLabelWidth = 40.;

@interface MIAPlayBarView(){

    BOOL playState;
    CGFloat videoDuration;
}

@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) MIAPlaySlider *playSlider;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *shareButton;

@property (nonatomic, copy) PlayBarActionBlock playBarActionBlock;

@end

@implementation MIAPlayBarView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        [self createPlayBarView];
    }
    return self;
}

- (void)createPlayBarView{

    self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_playButton setImage:[UIImage imageNamed:@"VP-Pause"] forState:UIControlStateNormal];
    [_playButton addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_playButton];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:kPlayBarViewLeftSpaceDistance selfView:_playButton superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_playButton superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_playButton superView:self];
    [JOAutoLayout autoLayoutWithWidthEqualHeightWithselfView:_playButton superView:self];
    
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shareButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_shareButton setImage:[UIImage imageNamed:@"C-More"] forState:UIControlStateNormal];
    [_shareButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_shareButton];
    
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-kPlayBarViewRightSpaceDistance selfView:_shareButton superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_shareButton superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_shareButton superView:self];
    [JOAutoLayout autoLayoutWithWidthEqualHeightWithselfView:_shareButton superView:self];
//    [JOAutoLayout autoLayoutWithWidth:CGFLOAT_MIN selfView:_shareButton superView:self];
    
    self.timeLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_PlayVideo_Time]];
    [_timeLabel setText:@"00:00"];
    [self addSubview:_timeLabel];
    
    [JOAutoLayout autoLayoutWithRightView:_shareButton distance:-0 selfView:_timeLabel superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_timeLabel superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_timeLabel superView:self];
    [JOAutoLayout autoLayoutWithWidth:kPlayBarViewTimeLabelWidth selfView:_timeLabel superView:self];
    
    self.playSlider = [MIAPlaySlider newAutoLayoutView];
    [_playSlider setMinimumTrackTintColor:JORGBSameCreate(220.)];
    //    [_playSlider setThumbTintColor:JORGBSameCreate(200.)];
//    [_playSlider setSliderThumbHeight:20. color:JORGBSameCreate(200.)];
    [_playSlider setThumbImage:[UIImage imageNamed:@"VP-SliderThumb"] forState:UIControlStateNormal];
    [_playSlider setMaximumTrackTintColor:JORGBCreate(200., 200., 200., 0.7)];
    [_playSlider setMinimumValue:0.];
    [_playSlider setMaximumValue:1.];
    [_playSlider addTarget:self action:@selector(sliderValueChange) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_playSlider];
    
    [JOAutoLayout autoLayoutWithLeftView:_playButton distance:kPlayBarViewButtonToSliderSpaceDistance selfView:_playSlider superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_playSlider superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_playSlider superView:self];
    [JOAutoLayout autoLayoutWithRightView:_timeLabel distance:-kPlayBarViewSliderToTimeLabelSpaceDistance selfView:_playSlider superView:self];
}

- (void)setCurrentVideoDuration:(CGFloat)duration{

    videoDuration = duration;
}

- (void)setCurrentPlayTime:(CGFloat)time{
    
    _playSlider.value = time / videoDuration;
    [_timeLabel setText:[self timeFormatWithTime:time]];
}

- (CGFloat)currentPlayTime{

    return [self currentTime];
}

- (void)setCurrentPlayState:(BOOL)state{

    playState = state;
    [self updatePlayButtonState];
}

- (BOOL)currentPlayState{

    return playState;
}

- (void)palyBarActionHanlder:(PlayBarActionBlock)block{

    self.playBarActionBlock = nil;
    self.playBarActionBlock = block;
}

- (void)updatePlayButtonState{

    if (playState) {
        //播放状态
        [_playButton setImage:[UIImage imageNamed:@"VP-Pause"] forState:UIControlStateNormal];
    }else{
        //未播放的状态
        [_playButton setImage:[UIImage imageNamed:@"VP-Play"] forState:UIControlStateNormal];
    }
}

#pragma mark - time

- (CGFloat)currentTime{

    return _playSlider.value * videoDuration;
}

#pragma mark - action

- (void)sliderValueChange{

    if (_playBarActionBlock) {
        _playBarActionBlock(PlayBarActionSlider);
    }
    
    [_timeLabel setText:[self timeFormatWithTime:[self currentTime]]];
}

- (void)playAction{

    playState?(playState = NO):(playState = YES);
    
    [self updatePlayButtonState];
    
    if (_playBarActionBlock) {
        
        PlayBarActionType type;
        
        if (playState) {
            type = PlayBarActionPlay;
        }else{
            type = PlayBarActionPause;
        }
        
        _playBarActionBlock(type);
    }
}

- (void)shareAction{

    if (_playBarActionBlock) {
        _playBarActionBlock(PlayBarActionShare);
    }
}

#pragma mark - time format

- (NSString *)timeFormatWithTime:(CGFloat)time {
    NSInteger second = time;
    NSInteger minute = second / 60;
    return [NSString stringWithFormat:@"%02zd:%02zd", minute, (second % 60)];
}

@end
