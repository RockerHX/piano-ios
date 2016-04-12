//
//  HXReplayBottomBar.m
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXReplayBottomBar.h"
#import "HXXib.h"
#import "HXReplaySlider.h"


@implementation HXReplayBottomBar

HXXibImplementation

#pragma mark - Load Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    ;
}

- (void)viewConfigure {
    _container.backgroundColor = [UIColor clearColor];
}

#pragma mark - Property
- (void)setCurrentTime:(CGFloat)currentTime {
    _currentTime = currentTime;
    
    _slider.value = currentTime / _duration;
    _startTimeLabel.text = [self timeFormatWithTime:currentTime];
}

- (void)setDuration:(CGFloat)duration {
    _duration = duration;
    _endTimeLabel.text = [self timeFormatWithTime:duration];
}

#pragma mark - Event Response
- (IBAction)pauseButtonPressed:(UIButton *)button {
    button.selected = !button.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(bottomBar:takeAction:)]) {
        [_delegate bottomBar:self takeAction:(button.selected ? HXReplayBottomBarActionPause : HXReplayBottomBarActionPlay)];
    }
}

- (IBAction)shareButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(bottomBar:takeAction:)]) {
        [_delegate bottomBar:self takeAction:HXReplayBottomBarActionShare];
    }
}

- (IBAction)sliderValueChanged:(UISlider *)slider {
    CGFloat progress = slider.value;
    self.currentTime = _duration * progress;
    if (_delegate && [_delegate respondsToSelector:@selector(bottomBar:dragProgressBar:)]) {
        [_delegate bottomBar:self dragProgressBar:progress];
    }
}

#pragma mark - Private Methods
- (NSString *)timeFormatWithTime:(CGFloat)time {
    NSInteger second = time;
    NSInteger minute = second / 60;
    return [NSString stringWithFormat:@"%02zd:%02zd", minute, (second % 60)];
}

@end
