//
//  MIAProfileAlbumView.m
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAProfileAlbumView.h"
#import "MIAAlbumModel.h"

@interface MIAProfileAlbumView()

@property (nonatomic, strong) MIAAlbumModel *albumModel;

@end

@implementation MIAProfileAlbumView

- (void)updateViewLayout{
    
    [super updateViewLayout];
    
//    [self.showImageView setBackgroundColor:[UIColor purpleColor]];
    [[self.showImageView layer] setCornerRadius:3.];
    [self.showTitleLabel setJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Album_Name]];
    
    [self.showTipLabel setJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Album_BackTotal]];
    

    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithHeightWidthRatioValue:1. selfView:self.showImageView superView:self];
    
    [JOAutoLayout autoLayoutWithTopView:self.showImageView distance:0. selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithLeftXView:self.showImageView selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithRightXView:self.showImageView selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithHeight:[self.showTitleLabel sizeThatFits:JOMAXSize].height + 6 selfView:self.showTitleLabel superView:self];
    
    [JOAutoLayout autoLayoutWithTopView:self.showTitleLabel distance:0 selfView:self.showTipLabel superView:self];
    [JOAutoLayout autoLayoutWithLeftXView:self.showImageView selfView:self.showTipLabel superView:self];
    [JOAutoLayout autoLayoutWithRightXView:self.showImageView selfView:self.showTipLabel superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:self.showTipLabel superView:self];
}

- (void)setShowData:(id)data{
    
    
    if ([data isKindOfClass:[MIAAlbumModel class]]) {
        self.albumModel = nil;
        self.albumModel = data;
        [self.showTitleLabel setText:_albumModel.title];
        [self.showImageView sd_setImageWithURL:[NSURL URLWithString:_albumModel.coverUrl] placeholderImage:nil];
        [self.showTipLabel setText:[NSString stringWithFormat:@"%@人打赏",_albumModel.backTotal]];
        
        [self updateViewLayout];
    }else{
    
        [JOFException exceptionWithName:@"MIAProfileAlbumView exception" reason:@"data不是MIAAlbumModel类型的"];
    }
    
    
}

@end
