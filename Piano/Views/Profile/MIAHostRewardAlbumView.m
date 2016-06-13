//
//  MIAHostRewardAlbumView.m
//  Piano
//
//  Created by 刘维 on 16/6/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAHostRewardAlbumView.h"
#import "MIAHostProfileModel.h"
#import "UIImageView+WebCache.h"
#import "MIAFontManage.h"
#import "AppDelegate.h"
#import "MIAAlbumViewController.h"

CGFloat const kRewardAlbumImageToTitleDistanceSpace = 6.;

@interface MIAHostRewardAlbumView()

@property (nonatomic, strong) HostMusicAlbumModel *hostMusicAlbumModel;

@end

@implementation MIAHostRewardAlbumView

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
    
    [self.showTitleLabel setFont:[MIAFontManage getFontWithType:MIAFontType_Host_Album_Name]->font];
    [self.showTitleLabel setTextColor:[MIAFontManage getFontWithType:MIAFontType_Host_Album_Name]->color];
    [self.showTipLabel setHidden:YES];
    [self.showTitleLabel setTextAlignment:NSTextAlignmentLeft];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithHeightWidthRatioValue:1. selfView:self.showImageView superView:self];
    
    [JOAutoLayout autoLayoutWithTopView:self.showImageView distance:kRewardAlbumImageToTitleDistanceSpace selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithLeftXView:self.showImageView selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithRightXView:self.showImageView selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithHeight:[self.showTitleLabel sizeThatFits:JOMAXSize].height selfView:self.showTitleLabel superView:self];
}

- (void)setShowData:(id)data{
    
    if ([data isKindOfClass:[HostMusicAlbumModel class]]) {
        
        self.hostMusicAlbumModel = data;
        [self.showTitleLabel setText:_hostMusicAlbumModel.title];
        [self.showImageView sd_setImageWithURL:[NSURL URLWithString:_hostMusicAlbumModel.coverUrl]];
        
        [self updateViewLayout];
        
    }else{
        [JOFException exceptionWithName:@"MIAHostRewardAlbumView exception!" reason:@"data 必须是HostMusicAlbumModel类型"];
    }
}

#pragma mark - tap gesture

- (void)tapAction:(UIGestureRecognizer *)gesture{
    
    MIAAlbumViewController *albumViewController = [MIAAlbumViewController new];
    [albumViewController setAlbumUID:_hostMusicAlbumModel.id];
    [albumViewController setRewardType:MIAAlbumRewardTypeMyReward];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [(UINavigationController *)[[delegate window] rootViewController] pushViewController:albumViewController animated:YES];
}

@end
