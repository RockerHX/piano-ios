//
//  HXPlayBottomBar.m
//  mia
//
//  Created by miaios on 16/2/25.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXPlayBottomBar.h"
#import "HXXib.h"

@implementation HXPlayBottomBar

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
    _containerView.backgroundColor = [UIColor clearColor];
    [_slider setThumbImage:[UIImage imageNamed:@"PL-CursorIcon"] forState:UIControlStateNormal];
}

#pragma mark - Property
- (void)setPause:(BOOL)pause {
    _pause = pause;
    [_pauseButton setImage:[UIImage imageNamed:(pause ? @"PL-PauseIcon" : @"PL-PlayIcon")] forState:UIControlStateNormal];
}

- (void)setEnablePrevious:(BOOL)enablePrevious {
    _enablePrevious = enablePrevious;
    _previousButton.enabled = enablePrevious;
}

- (void)setEnableNext:(BOOL)enableNext {
    _enableNext = enableNext;
    _nextButton.enabled = enableNext;
}

- (void)setPlayTime:(NSUInteger)playTime {
    _playTime = playTime;
    
    _playTimeLabel.text = [self timeText:playTime];
}

- (void)setMusicTime:(NSUInteger)musicTime {
    _musicTime = musicTime;
    
    _musicTimeLabel.text = [self timeText:musicTime];
}

#pragma mark - Event Response
- (IBAction)previousButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(bottomBar:takeAction:)]) {
        [_delegate bottomBar:self takeAction:HXPlayBottomBarActionPrevious];
    }
}

- (IBAction)pauseButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(bottomBar:takeAction:)]) {
        [_delegate bottomBar:self takeAction:HXPlayBottomBarActionPause];
    }
}

- (IBAction)nextButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(bottomBar:takeAction:)]) {
        [_delegate bottomBar:self takeAction:HXPlayBottomBarActionNext];
    }
}

- (IBAction)valueChange:(UISlider *)slider {
	NSLog(@"slider value : %.2f",[slider value]);

	if (_delegate && [_delegate respondsToSelector:@selector(bottomBar:seekToPosition:)]) {
		[_delegate bottomBar:self seekToPosition:[slider value]];
	}
}


#pragma mark - Private Methods
- (NSString *)timeText:(NSUInteger)time {
    NSUInteger minute = (time / 60);
    NSUInteger second = (time % 60);
    NSString *minuteText = [NSString stringWithFormat:@"%@%@", ((minute < 10) ? @"0" : @""), @(minute).stringValue];
    NSString *secondText = [NSString stringWithFormat:@"%@%@", ((second < 10) ? @"0" : @""), @(second).stringValue];
    return [NSString stringWithFormat:@"%@:%@", minuteText, secondText];
}

@end
