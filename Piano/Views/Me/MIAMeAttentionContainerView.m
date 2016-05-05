//
//  MIAAttentionContainerView.m
//  Piano
//
//  Created by 刘维 on 16/5/5.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAMeAttentionContainerView.h"

@interface MIAMeAttentionContainerView()

@end

@implementation MIAMeAttentionContainerView

- (void)updateViewLayout{

    [super updateViewLayout];
    
    [self.showImageView setBackgroundColor:[UIColor purpleColor]];
    [[self.showImageView layer] setCornerRadius:3.];
    [self.showTitleLabel setFont:[UIFont systemFontOfSize:15.]];
    [self.showTitleLabel setText:@"剧痛"];
    [self.showTipLabe setHidden:YES];
    [self.showTitleLabel setTextAlignment:NSTextAlignmentLeft];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithHeightWidthRatioValue:1. selfView:self.showImageView superView:self];
    
    [JOAutoLayout autoLayoutWithTopView:self.showImageView distance:0. selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithLeftXView:self.showImageView selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithRightXView:self.showImageView selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:self.showTitleLabel superView:self];
}

- (void)setShowData:(id)data{

    [self updateViewLayout];
}

@end
