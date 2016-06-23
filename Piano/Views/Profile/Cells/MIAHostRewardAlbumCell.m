//
//  MIAHostRewardAlbumCell.m
//  Piano
//
//  Created by 刘维 on 16/6/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAHostRewardAlbumCell.h"
#import "MIAHostRewardAlbumView.h"

CGFloat const kHostProfileAlbumItemSpaceDistance = 18.;

@interface MIAHostRewardAlbumCell(){

    CGFloat cellWidth;
}

@property (nonatomic, strong) MIAHostRewardAlbumView *leftHostRewardAlbumView;
@property (nonatomic, strong) MIAHostRewardAlbumView *midHostRewardAlbumView;
@property (nonatomic, strong) MIAHostRewardAlbumView *rightHostRewardAlbumView;

@end

@implementation MIAHostRewardAlbumCell

- (void)setCellWidth:(CGFloat)width{
    
    [self setBackgroundColor:JORGBCreate(0., 0., 0, 0.4)];
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    [self.cellContentView  setBackgroundColor:[UIColor clearColor]];
    cellWidth = width;
}

- (void)createProfileAlbumCellContentView{
    
    CGFloat viewWidth = (cellWidth - kContentViewRightSpaceDistance -kContentViewLeftSpaceDistance -kContentViewInsideLeftSpaceDistance - kContentViewInsideRightSpaceDistance - 2*kHostProfileAlbumItemSpaceDistance)/3.;
    
    if (!self.leftHostRewardAlbumView) {
        
        self.leftHostRewardAlbumView = [MIAHostRewardAlbumView newAutoLayoutView];
        [_leftHostRewardAlbumView setTag:1];
        [self.cellContentView addSubview:_leftHostRewardAlbumView];
        
        [_leftHostRewardAlbumView layoutTop:kContentViewInsideTopSpaceDistance layoutItemHandler:nil];
        [_leftHostRewardAlbumView layoutBottom:-kContentViewInsideBottomSpaceDistance layoutItemHandler:nil];
        [_leftHostRewardAlbumView layoutWidth:viewWidth layoutItemHandler:nil];
        [_leftHostRewardAlbumView layoutLeft:kContentViewInsideLeftSpaceDistance layoutItemHandler:nil];
        
        self.midHostRewardAlbumView = [MIAHostRewardAlbumView newAutoLayoutView];
        [_midHostRewardAlbumView setTag:2];
        [self.cellContentView addSubview:_midHostRewardAlbumView];
        
        [_midHostRewardAlbumView layoutSizeView:_leftHostRewardAlbumView layoutItemHandler:nil];
        [_midHostRewardAlbumView layoutLeftView:_leftHostRewardAlbumView distance:kHostProfileAlbumItemSpaceDistance layoutItemHandler:nil];
        [_midHostRewardAlbumView layoutTop:kContentViewInsideTopSpaceDistance layoutItemHandler:nil];
        
        self.rightHostRewardAlbumView = [MIAHostRewardAlbumView newAutoLayoutView];
        [_rightHostRewardAlbumView setTag:3];
        [self.cellContentView addSubview:_rightHostRewardAlbumView];
        
        [_rightHostRewardAlbumView layoutSizeView:_leftHostRewardAlbumView layoutItemHandler:nil];
        [_rightHostRewardAlbumView layoutLeftView:_midHostRewardAlbumView distance:kHostProfileAlbumItemSpaceDistance layoutItemHandler:nil];
        [_rightHostRewardAlbumView layoutTop:kContentViewInsideTopSpaceDistance layoutItemHandler:nil];
    }
}


- (void)setCellData:(id)data{
    
    if ([data isKindOfClass:[NSArray class]]) {
        
        [self createProfileAlbumCellContentView];
        
        [_leftHostRewardAlbumView setHidden:YES];
        [_midHostRewardAlbumView setHidden:YES];
        [_rightHostRewardAlbumView setHidden:YES];
        
        for (int i = 0; i < [data count]; i++) {
            
            MIAHostRewardAlbumView *albumView = [self.cellContentView viewWithTag:i+1];
            [albumView setShowData:[data objectAtIndex:i]];
            [albumView setHidden:NO];
        }
    }else{
        
        [JOFException exceptionWithName:@"MIAHostRewardAlbumCell Exception" reason:@"data 需要的格式为数组,数组里的元素为HostMusicAlbumModel类型"];
    }
}

@end
