//
//  MIAAttentionShowView.m
//  Piano
//
//  Created by 刘维 on 16/5/5.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAMeAttentionPromptView.h"

static CGFloat const kLiveTipLableHeight = 18.;

@interface MIAMeAttentionPromptView()

@property (nonatomic, strong) UILabel *liveTipLabel;

@end

@implementation MIAMeAttentionPromptView

- (void)updateViewLayout{

    [super updateViewLayout];
    
    [self.showTipLabel setHidden:YES];
    [self.showImageView setBackgroundColor:[UIColor orangeColor]];
    [self.showTitleLabel setText:@"于文文"];
    [self.showTitleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithHeightWidthRatioValue:1. selfView:self.showImageView superView:self];
    
    [JOAutoLayout autoLayoutWithTopView:self.showImageView distance:0. selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithLeftXView:self.showImageView selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithRightXView:self.showImageView selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:self.showTitleLabel superView:self];
}

- (void)setLiveShowState:(BOOL)state{

    if (!self.liveTipLabel) {
        self.liveTipLabel = [UILabel newAutoLayoutView];
        [_liveTipLabel setBackgroundColor:[UIColor whiteColor]];
        [_liveTipLabel setTextAlignment:NSTextAlignmentCenter];
        [_liveTipLabel setTextColor:[UIColor redColor]];
        [[_liveTipLabel layer] setCornerRadius:kLiveTipLableHeight/2.];
        [[_liveTipLabel layer] setMasksToBounds:YES];
        [_liveTipLabel setFont:[UIFont systemFontOfSize:10]];
        [_liveTipLabel setText:@"●Live"];
        [self addSubview:_liveTipLabel];
    }
    
    [JOAutoLayout removeAllAutoLayoutWithSelfView:_liveTipLabel superView:self];
    
    if (state) {
        [_liveTipLabel setHidden:NO];
        
        [JOAutoLayout autoLayoutWithBottomYView:self.showImageView selfView:_liveTipLabel superView:self];
        [JOAutoLayout autoLayoutWithHeight:kLiveTipLableHeight selfView:_liveTipLabel superView:self];
        [JOAutoLayout autoLayoutWithCenterXWithView:self.showImageView selfView:_liveTipLabel superView:self];
        [JOAutoLayout autoLayoutWithWidthWithView:self.showImageView ratioValue:2./3. selfView:_liveTipLabel superView:self];
        
    }else{
    
        [_liveTipLabel setHidden:YES];
    }
    
}

- (void)setAttentionPromptViewWidth:(CGFloat )width{

    [[self.showImageView layer] setCornerRadius:width/2.];
}

- (void)setShowData:(id)data{

    [self updateViewLayout];
    [self setLiveShowState:YES];
}

@end
