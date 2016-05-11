//
//  MIAProfileVideoView.m
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAProfileVideoView.h"

static CGFloat const kTitleLabelHeight = 20.;

@interface MIAProfileVideoView()

@property (nonatomic, strong) UIImageView *videoImageView;
@property (nonatomic, strong) UILabel *numberlabel;

@end

@implementation MIAProfileVideoView

- (void)updateViewLayout{
    
    [super updateViewLayout];
    
    [self createTipNumberView];
    
    [self.showImageView setBackgroundColor:[UIColor purpleColor]];
    [[self.showImageView layer] setCornerRadius:3.];
    [self.showTitleLabel setJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Video_Name]];
    [self.showTitleLabel setText:@"小和尚"];
    [self.showTipLabel setHidden:YES];
    
    [_numberlabel setText:@"3455"];
    
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0 selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithHeight:kTitleLabelHeight selfView:self.showTitleLabel superView:self];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithBottomView:self.showTitleLabel distance:0. selfView:self.showImageView superView:self];
    
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_numberlabel superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:5. selfView:_numberlabel superView:self];
    [JOAutoLayout autoLayoutWithHeight:[_numberlabel sizeThatFits:JOMAXSize].height selfView:_numberlabel superView:self];
    [JOAutoLayout autoLayoutWithWidth:[_numberlabel sizeThatFits:JOMAXSize].width + 8. selfView:_numberlabel superView:self];
    
    [JOAutoLayout autoLayoutWithRightView:_numberlabel distance:0. selfView:_videoImageView superView:self];
    [JOAutoLayout autoLayoutWithTopYView:_numberlabel selfView:_videoImageView superView:self];
    [JOAutoLayout autoLayoutWithBottomYView:_numberlabel selfView:_videoImageView superView:self];
    [JOAutoLayout autoLayoutWithWidthEqualHeightWithselfView:_videoImageView superView:self];
    
}

- (void)createTipNumberView{

    if (!self.videoImageView) {
        
        self.videoImageView = [UIImageView newAutoLayoutView];
        [_videoImageView setBackgroundColor:[UIColor orangeColor]];
        [self addSubview:_videoImageView];
        
        self.numberlabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Video_ViweCount]];
        [self addSubview:_numberlabel];
    }
    
    
    
}

- (void)setShowData:(id)data{
    
    [self updateViewLayout];
}

@end
