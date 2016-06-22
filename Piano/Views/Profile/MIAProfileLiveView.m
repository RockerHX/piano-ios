//
//  MIAProfileLiveView.m
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAProfileLiveView.h"
#import "MusicMgr.h"
#import "MIAProfileViewModel.h"

static CGFloat const kShowImageToTitleDistanceSpace = 9.;
static CGFloat const kTitleTopDistanceSpace = 10.;
static CGFloat const kTitleToTipDistanceSpace = 5.;

@interface MIAProfileLiveView()

@property (nonatomic, strong) MIAProfileLiveModel *liveModel;
@property (nonatomic, copy) ProfileViewClickBlock profileViewClickBlock;

@end

@implementation MIAProfileLiveView

- (void)addTapGesture{
    
    if (objc_getAssociatedObject(self, _cmd)) {
        //
    }else{
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tapGesture];
        objc_setAssociatedObject(self, _cmd, @"only", OBJC_ASSOCIATION_RETAIN);
    }
}

- (void)updateViewLayout{
    
    [super updateViewLayout];
    
    [self addTapGesture];
    
    [self.showImageView setBackgroundColor:[UIColor grayColor]];
//    [[self.showImageView layer] setCornerRadius:3.];
    [self.showTitleLabel setJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Live_Title]];
    [self.showTitleLabel setTextAlignment:NSTextAlignmentLeft];
    
    [self.showTipLabel setTextAlignment:NSTextAlignmentLeft];
    [self.showTipLabel setJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Live_Summary]];
    
    [self.showImageView layoutLeft:0. layoutItemHandler:nil];
    [self.showImageView layoutBottom:0. layoutItemHandler:nil];
    [self.showImageView layoutTop:0. layoutItemHandler:nil];
    [self.showImageView layoutWidthHeightRatio:1. layoutItemHandler:nil];
    
    [self.showTitleLabel layoutTopYView:self.showImageView distance:kTitleTopDistanceSpace layoutItemHandler:nil];
    [self.showTitleLabel layoutLeftView:self.showImageView distance:kShowImageToTitleDistanceSpace layoutItemHandler:nil];
    [self.showTitleLabel layoutRight:0. layoutItemHandler:nil];
    [self.showTitleLabel layoutHeight:[self.showTitleLabel sizeThatFits:JOMAXSize].height layoutItemHandler:nil];
    
    [self.showTipLabel layoutTopView:self.showTitleLabel distance:kTitleToTipDistanceSpace layoutItemHandler:nil];
    [self.showTipLabel layoutLeftXView:self.showTitleLabel distance:0. layoutItemHandler:nil];
    [self.showTipLabel layoutRightXView:self.showTitleLabel distance:0. layoutItemHandler:nil];
    [self.showTipLabel layoutHeight:[self.showTipLabel sizeThatFits:JOMAXSize].height layoutItemHandler:nil];
}

- (void)setShowData:(id)data{
    
    if ([data isKindOfClass:[MIAProfileLiveModel class]]) {
        
        self.liveModel = nil;
        self.liveModel = data;
        
        [self.showImageView sd_setImageWithURL:[NSURL URLWithString:_liveModel.liveCoverURL] placeholderImage:nil];
         [self.showTitleLabel setText:[NSString stringWithFormat:@"%@正在直播",_liveModel.nickName]];
         [self.showTipLabel setText:_liveModel.liveTitle];
        
        [self updateViewLayout];
    }else{
    
        [JOFException exceptionWithName:@"MIAProfileLiveView exception!" reason:@"data类型需要为LiveModel"];
    }
}

- (void)profileLiveViewClickHandler:(ProfileViewClickBlock)block{

    self.profileViewClickBlock = nil;
    self.profileViewClickBlock = block;
}

#pragma mark - tag action

- (void)tapAction:(UIGestureRecognizer *)gesture {
    
    if (_profileViewClickBlock) {
        _profileViewClickBlock();
    }
}

@end
