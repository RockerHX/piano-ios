//
//  MIAAlbumDetailCell.m
//  Piano
//
//  Created by 刘维 on 16/5/11.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAAlbumDetailCell.h"
#import "MIAAlbumDetailView.h"

@interface MIAAlbumDetailCell()

@property (nonatomic, strong) MIAAlbumDetailView *albumDetailView;

@end

@implementation MIAAlbumDetailCell

- (void)setCellWidth:(CGFloat)width{

    
}

- (void)createAlbumDetailView{

    if (!self.albumDetailView) {
        self.albumDetailView = [MIAAlbumDetailView newAutoLayoutView];
        [self.cellContentView addSubview:_albumDetailView];
        
        [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_albumDetailView superView:self.cellContentView];
    }
}

- (void)setCellData:(id)data{

    [self createAlbumDetailView];
}

@end
