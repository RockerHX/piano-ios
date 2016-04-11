//
//  HXReplayBottomBar.h
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, HXReplayBottomBarAction) {
    HXReplayBottomBarActionPlay,
    HXReplayBottomBarActionPause,
    HXReplayBottomBarActionShare,
};


@class HXReplaySlider;
@class HXReplayBottomBar;


@protocol HXReplayBottomBarDelegate <NSObject>

@required
- (void)bottomBar:(HXReplayBottomBar *)bar takeAction:(HXReplayBottomBarAction)action;

@end


@interface HXReplayBottomBar : UIView

@property (weak, nonatomic) IBOutlet id  <HXReplayBottomBarDelegate>delegate;

@property (weak, nonatomic) IBOutlet         UIView *container;
@property (weak, nonatomic) IBOutlet HXReplaySlider *slider;

- (IBAction)pauseButtonPressed;
- (IBAction)shareButtonPressed;

@end
