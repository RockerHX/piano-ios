//
//  MIAProfileAlbumView.m
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAProfileAlbumView.h"
#import "AppDelegate.h"
#import "MIAAlbumViewController.h"
#import "MIAAlbumModel.h"

CGFloat const kAlbumImageToTitleSpaceDistance = 7.;
CGFloat const kAlbumTitleToTipSpaceDistance = 5.;

@interface MIAProfileAlbumView()

@property (nonatomic, strong) MIAAlbumModel *albumModel;

@end

@implementation MIAProfileAlbumView

#pragma mark - tap gesture

- (void)addTapGesture{

    if (objc_getAssociatedObject(self, _cmd)) {
        //
    }else{
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tapGesture];
        objc_setAssociatedObject(self, _cmd, @"only", OBJC_ASSOCIATION_RETAIN);
    }
}

- (void)tapAction:(UIGestureRecognizer *)gesture{
    
    MIAAlbumViewController *albumViewController = [MIAAlbumViewController new];
    [albumViewController setAlbumUID:_albumModel.id];
    [albumViewController setRewardType:MIAAlbumRewardTypeNormal];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [(UINavigationController *)[[delegate window] rootViewController] pushViewController:albumViewController animated:YES];
}

#pragma mark - date  view layout

- (void)updateViewLayout{
    
    [super updateViewLayout];
    
    [self addTapGesture];
    
//    [[self.showImageView layer] setCornerRadius:3.];
    [self.showTitleLabel setJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Album_Name]];
    [self.showTipLabel setJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Album_BackTotal]];
    
    [self.showImageView layoutLeft:0. layoutItemHandler:nil];
    [self.showImageView layoutRight:0. layoutItemHandler:nil];
    [self.showImageView layoutTop:0. layoutItemHandler:nil];
    [self.showImageView layoutHeightWidthRatio:1. layoutItemHandler:nil];
    
    [self.showTitleLabel layoutTopView:self.showImageView distance:kAlbumImageToTitleSpaceDistance layoutItemHandler:nil];
    [self.showTitleLabel layoutLeftXView:self.showImageView distance:0. layoutItemHandler:nil];
    [self.showTitleLabel layoutRightXView:self.showImageView distance:0. layoutItemHandler:nil];
    [self.showTitleLabel layoutHeight:[self.showTitleLabel sizeThatFits:JOMAXSize].height layoutItemHandler:nil];

    [self.showTipLabel layoutTopView:self.showTitleLabel distance:kAlbumTitleToTipSpaceDistance layoutItemHandler:nil];
    [self.showTipLabel layoutLeftXView:self.showImageView distance:0. layoutItemHandler:nil];
    [self.showTipLabel layoutRightXView:self.showImageView distance:0. layoutItemHandler:nil];
    [self.showTipLabel layoutBottom:0. layoutItemHandler:nil];
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
