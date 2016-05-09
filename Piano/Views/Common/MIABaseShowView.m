//
//  MIABaseCellView.m
//  Piano
//
//  Created by 刘维 on 16/5/5.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIABaseShowView.h"

@interface MIABaseShowView()

@end

@implementation MIABaseShowView

- (instancetype)init{

    self = [super init];
    if (self) {
        
        [self createBaseShowView];
    }
    return self;
}

- (void)createBaseShowView{

    self.showImageView = [UIImageView newAutoLayoutView];
    [_showImageView setContentMode:UIViewContentModeScaleAspectFit];
    [[_showImageView layer] setMasksToBounds:YES];
    [self addSubview:_showImageView];
    
    self.showTitleLabel = [UILabel newAutoLayoutView];
    [_showTitleLabel setBackgroundColor:[UIColor clearColor]];
//    [_showTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [_showTitleLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:_showTitleLabel];
    
    self.showTipLabel = [UILabel newAutoLayoutView];
    [_showTipLabel setBackgroundColor:[UIColor clearColor]];
//    [_showTipLabe setTextAlignment:NSTextAlignmentCenter];
    [_showTipLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:_showTipLabel];
}

- (void)updateViewLayout{

    [JOAutoLayout removeAllAutoLayoutWithSelfView:self.showImageView superView:self];
    [JOAutoLayout removeAllAutoLayoutWithSelfView:self.showTitleLabel superView:self];
    [JOAutoLayout removeAllAutoLayoutWithSelfView:self.showTipLabel superView:self];
}

- (void)setShowData:(id)data{}

@end
