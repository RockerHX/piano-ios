//
//  MIAProfileLiveView.m
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAProfileLiveView.h"

static CGFloat const kShowImageToTitleDistanceSpace = 10.;
static CGFloat const kTitleTopDistanceSpace = 15.;
static CGFloat const kTitleToTipDistanceSpace = 5.;

@implementation MIAProfileLiveView

- (void)updateViewLayout{
    
    [super updateViewLayout];
    
    [self.showImageView setBackgroundColor:[UIColor purpleColor]];
    [[self.showImageView layer] setCornerRadius:3.];
    [self.showTitleLabel setFont:[UIFont systemFontOfSize:15.]];
    [self.showTitleLabel setText:@"小和尚正在直播"];
    [self.showTitleLabel setTextColor:[UIColor blackColor]];
    [self.showTitleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.showTipLabel setTextColor:[UIColor grayColor]];
    [self.showTipLabel setTextAlignment:NSTextAlignmentLeft];
    [self.showTipLabel setText:@"说说小和尚的故事"];
    [self.showTipLabel setFont:[UIFont systemFontOfSize:13.]];
    
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithHeightWidthRatioValue:1. selfView:self.showImageView superView:self];
    
    [JOAutoLayout autoLayoutWithTopYView:self.showImageView distance:kTitleTopDistanceSpace selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithLeftView:self.showImageView distance:kShowImageToTitleDistanceSpace selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithHeight:[self.showTitleLabel sizeThatFits:JOMAXSize].height selfView:self.showTitleLabel superView:self];
    
    [JOAutoLayout autoLayoutWithTopView:self.showTitleLabel distance:kTitleToTipDistanceSpace selfView:self.showTipLabel superView:self];
    [JOAutoLayout autoLayoutWithLeftXView:self.showTitleLabel selfView:self.showTipLabel superView:self];
    [JOAutoLayout autoLayoutWithRightXView:self.showTitleLabel selfView:self.showTipLabel superView:self];
    [JOAutoLayout autoLayoutWithHeight:[self.showTipLabel sizeThatFits:JOMAXSize].height selfView:self.showTipLabel superView:self];
}

- (void)setShowData:(id)data{
    
    [self updateViewLayout];
}

@end
