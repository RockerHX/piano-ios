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

    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithHeightWidthRatioValue:1. selfView:self.showImageView superView:self];
    
    [JOAutoLayout autoLayoutWithTopView:self.showImageView distance:kAlbumImageToTitleSpaceDistance selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithLeftXView:self.showImageView selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithRightXView:self.showImageView selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithHeight:[self.showTitleLabel sizeThatFits:JOMAXSize].height selfView:self.showTitleLabel superView:self];
    
    [JOAutoLayout autoLayoutWithTopView:self.showTitleLabel distance:kAlbumTitleToTipSpaceDistance selfView:self.showTipLabel superView:self];
    [JOAutoLayout autoLayoutWithLeftXView:self.showImageView selfView:self.showTipLabel superView:self];
    [JOAutoLayout autoLayoutWithRightXView:self.showImageView selfView:self.showTipLabel superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:self.showTipLabel superView:self];
//    [JOAutoLayout autoLayoutWithHeight:[self.showTipLabel sizeThatFits:JOMAXSize].height selfView:self.showTipLabel superView:self];
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
