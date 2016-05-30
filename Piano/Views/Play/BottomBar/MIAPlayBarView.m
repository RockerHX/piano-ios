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
static CGFloat const kPlayBarViewTimeLabelToButtonSpaceDistance = 10.;
static CGFloat const kPlayBarViewTimeLabelWidth = 50.;

@interface MIAPlayBarView(){

    BOOL playState;
}

@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) MIAPlaySlider *playSlider;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *shareButton;

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
    [_playButton setBackgroundColor:[UIColor grayColor]];
    [self addSubview:_playButton];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:kPlayBarViewLeftSpaceDistance selfView:_playButton superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_playButton superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_playButton superView:self];
    [JOAutoLayout autoLayoutWithWidthEqualHeightWithselfView:_playButton superView:self];
    
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shareButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_shareButton setBackgroundColor:[UIColor grayColor]];
    [self addSubview:_shareButton];
    
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-kPlayBarViewRightSpaceDistance selfView:_shareButton superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_shareButton superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_shareButton superView:self];
    [JOAutoLayout autoLayoutWithWidthEqualHeightWithselfView:_shareButton superView:self];
    
    self.timeLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_PlayVideo_Time]];
    [_timeLabel setText:@"00:00"];
    [self addSubview:_timeLabel];
    
    [JOAutoLayout autoLayoutWithRightView:_shareButton distance:-kPlayBarViewTimeLabelToButtonSpaceDistance selfView:_timeLabel superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_timeLabel superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_timeLabel superView:self];
    [JOAutoLayout autoLayoutWithWidth:kPlayBarViewTimeLabelWidth selfView:_timeLabel superView:self];
    
    self.playSlider = [MIAPlaySlider newAutoLayoutView];
    [_playSlider setMinimumTrackTintColor:JORGBSameCreate(200.)];
    //    [_playSlider setThumbTintColor:JORGBSameCreate(200.)];
    [_playSlider setSliderThumbHeight:20. color:JORGBSameCreate(200.)];
    [_playSlider setMaximumTrackTintColor:JORGBCreate(200., 200., 200., 0.7)];
    [_playSlider setMinimumValue:0.];
    [_playSlider setMaximumValue:1.];
    [self addSubview:_playSlider];
    
    [JOAutoLayout autoLayoutWithLeftView:_playButton distance:kPlayBarViewButtonToSliderSpaceDistance selfView:_playSlider superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_playSlider superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_playSlider superView:self];
    [JOAutoLayout autoLayoutWithRightView:_timeLabel distance:-kPlayBarViewSliderToTimeLabelSpaceDistance selfView:_playSlider superView:self];
}

- (void)setCurrentPlayTime:(NSString *)time{

    
}

@end
