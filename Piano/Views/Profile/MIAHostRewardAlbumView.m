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
    
    [self.showImageView layoutLeft:0. layoutItemHandler:nil];
    [self.showImageView layoutRight:0. layoutItemHandler:nil];
    [self.showImageView layoutTop:0. layoutItemHandler:nil];
    [self.showImageView layoutHeightWidthRatio:1. layoutItemHandler:nil];
    
    [self.showTitleLabel layoutTopView:self.showImageView distance:kRewardAlbumImageToTitleDistanceSpace layoutItemHandler:nil];
    [self.showTitleLabel layoutLeftXView:self.showImageView distance:0. layoutItemHandler:nil];
    [self.showTitleLabel layoutRightXView:self.showImageView distance:0. layoutItemHandler:nil];
    [self.showTitleLabel layoutHeight:[self.showTitleLabel sizeThatFits:JOMAXSize].height layoutItemHandler:nil];
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
