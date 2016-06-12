//
//  MIAHostRewardAlbumView.m
//  Piano
//
//  Created by 刘维 on 16/6/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAHostRewardAlbumView.h"
#import "MIAFontManage.h"

@implementation MIAHostRewardAlbumView

- (void)updateViewLayout{
    
    [super updateViewLayout];
    
    [self.showImageView setBackgroundColor:[UIColor purpleColor]];
    [self.showTitleLabel setFont:[MIAFontManage getFontWithType:MIAFontType_Host_Album_Name]->font];
    [self.showTitleLabel setTextColor:[MIAFontManage getFontWithType:MIAFontType_Host_Album_Name]->color];
    [self.showTitleLabel setText:@"剧痛"];
    [self.showTipLabel setHidden:YES];
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
