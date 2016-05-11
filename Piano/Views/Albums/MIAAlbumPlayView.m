//
//  MIAAlbumPlayView.m
//  Piano
//
//  Created by 刘维 on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAAlbumPlayView.h"
#import "JOBaseSDK.h"
#import "MIAFontManage.h"

#define SliderColor JORGBCreate(246., 28., 41., 1.)

static CGFloat const kTopSpaceDistance = 10.; //上面的间距大小
static CGFloat const kBottomSpaceDistance = 10.; //下面的间距大小

static CGFloat const kButtonToTimeSpaceDistance = 10.;//播放按钮到开始时间的间距大小
static CGFloat const kTimeToSliderSpaceDistance = 10.; //播放时间到slider的间距大小
static CGFloat const kButtonToButtonSpaceDistance = 10.;//按钮间的间距大小

@interface MIAAlbumPlayView(){

    BOOL playState;
}

@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UILabel *startTimeLabel;
@property (nonatomic, strong) UISlider *sliderView;
@property (nonatomic, strong) UILabel *remainTimeLabel;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *preButton;

@end

@implementation MIAAlbumPlayView

- (instancetype)init{

    self = [super init];
    if (self) {
        
        [self createPlayView];
    }
    return self;
}

- (void)createPlayView{

    self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_playButton setImage:[UIImage imageNamed:@"AD-PlayIcon-L"] forState:UIControlStateNormal];
    [self addSubview:_playButton];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_playButton superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:kTopSpaceDistance selfView:_playButton superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:-kBottomSpaceDistance selfView:_playButton superView:self];
    [JOAutoLayout autoLayoutWithWidthEqualHeightWithselfView:_playButton superView:self];
    
    self.startTimeLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_Play_Time]];
    [_startTimeLabel setText:@"0:00"];
    [self addSubview:_startTimeLabel];
    
    [JOAutoLayout autoLayoutWithLeftView:_playButton distance:kButtonToTimeSpaceDistance selfView:_startTimeLabel superView:self];
    [JOAutoLayout autoLayoutWithTopYView:_playButton selfView:_startTimeLabel superView:self];
    [JOAutoLayout autoLayoutWithBottomYView:_playButton selfView:_startTimeLabel superView:self];
    [JOAutoLayout autoLayoutWithWidth:[_startTimeLabel sizeThatFits:JOMAXSize].width+1 selfView:_startTimeLabel superView:self];
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextButton setImage:[UIImage imageNamed:@"AD-NextIcon-E"] forState:UIControlStateNormal];
    [_nextButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_nextButton];
    
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_nextButton superView:self];
    [JOAutoLayout autoLayoutWithTopYView:_playButton selfView:_nextButton superView:self];
    [JOAutoLayout autoLayoutWithBottomYView:_playButton selfView:_nextButton superView:self];
    [JOAutoLayout autoLayoutWithWidthEqualHeightWithselfView:_nextButton superView:self];
    
    self.preButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_preButton setImage:[UIImage imageNamed:@"AD-PreviousIcon-E"] forState:UIControlStateNormal];
    [_preButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_preButton];
    
    [JOAutoLayout autoLayoutWithRightView:_nextButton distance:-kButtonToButtonSpaceDistance selfView:_preButton superView:self];
    [JOAutoLayout autoLayoutWithTopYView:_playButton selfView:_preButton superView:self];
    [JOAutoLayout autoLayoutWithBottomYView:_playButton selfView:_preButton superView:self];
    [JOAutoLayout autoLayoutWithWidthEqualHeightWithselfView:_preButton superView:self];
    
    self.remainTimeLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_Play_Time]];
    [_remainTimeLabel setText:@"4:54"];
    [self addSubview:_remainTimeLabel];
    
    [JOAutoLayout autoLayoutWithRightView:_preButton distance:-kButtonToTimeSpaceDistance selfView:_remainTimeLabel superView:self];
    [JOAutoLayout autoLayoutWithTopYView:_playButton selfView:_remainTimeLabel superView:self];
    [JOAutoLayout autoLayoutWithBottomYView:_playButton selfView:_remainTimeLabel superView:self];
    [JOAutoLayout autoLayoutWithWidth:[_remainTimeLabel sizeThatFits:JOMAXSize].width+1 selfView:_remainTimeLabel superView:self];
    
    self.sliderView = [UISlider newAutoLayoutView];
    [_sliderView setMinimumTrackTintColor:SliderColor];
//    [_sliderView setMaximumTrackTintColor:SliderColor];
    [_sliderView setThumbTintColor:SliderColor];
    [self addSubview:_sliderView];
    
    [JOAutoLayout autoLayoutWithTopYView:_playButton distance:5. selfView:_sliderView superView:self];
    [JOAutoLayout autoLayoutWithBottomYView:_playButton distance:-5. selfView:_sliderView superView:self];
    [JOAutoLayout autoLayoutWithLeftView:_startTimeLabel distance:kTimeToSliderSpaceDistance selfView:_sliderView superView:self];
    [JOAutoLayout autoLayoutWithRightView:_remainTimeLabel distance:-kTimeToSliderSpaceDistance selfView:_sliderView superView:self];
}

@end
