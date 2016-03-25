//
//  HXPlayBottomBar.h
//  mia
//
//  Created by miaios on 16/2/25.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HXPlayBottomBarAction) {
    HXPlayBottomBarActionPrevious,
    HXPlayBottomBarActionPause,
    HXPlayBottomBarActionNext,
};

@class HXPlayBottomBar;

@protocol HXPlayBottomBarDelegate <NSObject>

@required
- (void)bottomBar:(HXPlayBottomBar *)bar takeAction:(HXPlayBottomBarAction)action;
- (void)bottomBar:(HXPlayBottomBar *)bar seekToPosition:(float)postion;

@end

@interface HXPlayBottomBar : UIView

@property (weak, nonatomic) IBOutlet     id  <HXPlayBottomBarDelegate>delegate;

@property (weak, nonatomic) IBOutlet   UIView *containerView;

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet  UILabel *playTimeLabel;
@property (weak, nonatomic) IBOutlet  UILabel *musicTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *infectButton;

@property (nonatomic, assign) BOOL  pause;
@property (nonatomic, assign) BOOL  enablePrevious;
@property (nonatomic, assign) BOOL  enableNext;

@property (nonatomic, assign) NSUInteger  playTime;
@property (nonatomic, assign) NSUInteger  musicTime;

- (IBAction)previousButtonPressed;
- (IBAction)pauseButtonPressed;
- (IBAction)nextButtonPressed;
- (IBAction)valueChange:(UISlider *)slider;

@end
