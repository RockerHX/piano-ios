//
//  MIAAlbumCommentCell.m
//  Piano
//
//  Created by 刘维 on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAAlbumCommentCell.h"
#import "MIAAlbumCommentView.h"

@interface MIAAlbumCommentCell()

@property (nonatomic, strong) MIAAlbumCommentView *commmentView;

@end

@implementation MIAAlbumCommentCell

- (void)setCellWidth:(CGFloat)width{
    
    
}

- (void)createAlbumDetailView{
    
    if (!self.commmentView) {
        [self.cellContentView setBackgroundColor:[UIColor whiteColor]];
        self.commmentView = [MIAAlbumCommentView newAutoLayoutView];
        [self.cellContentView addSubview:_commmentView];
        
        [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(kContentViewInsideTopSpaceDistance, kContentViewInsideLeftSpaceDistance, -kContentViewInsideRightSpaceDistance, 0.) selfView:_commmentView superView:self.cellContentView];
    }
}

- (void)setCellData:(id)data{
    
    [self createAlbumDetailView];
    
    [_commmentView setAlbumCommentData:data];
}

@end
