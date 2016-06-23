//
//  MIAProfileAlbumCell.m
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAProfileAlbumCell.h"
#import "MIAProfileAlbumView.h"
#import "MIAProfileViewModel.h"

CGFloat const kProfileAlbumItemSpaceDistance = 18.;

@interface MIAProfileAlbumCell(){

    CGFloat cellWidth;
}

@property (nonatomic, strong) MIAProfileAlbumView *leftAlbumView;
@property (nonatomic, strong) MIAProfileAlbumView *midAlbumView;
@property (nonatomic, strong) MIAProfileAlbumView *rightAlbumView;

@end

@implementation MIAProfileAlbumCell

- (void)setCellWidth:(CGFloat)width{
    
    [self.cellContentView setBackgroundColor:[UIColor whiteColor]];
    cellWidth = width;
}

- (void)createProfileAlbumCellContentView{
    
    CGFloat viewWidth = (cellWidth - kContentViewRightSpaceDistance -kContentViewLeftSpaceDistance -kContentViewInsideLeftSpaceDistance - kContentViewInsideRightSpaceDistance - 2*kProfileAlbumItemSpaceDistance)/3.;
    
    if (!self.leftAlbumView) {
        
        self.leftAlbumView = [MIAProfileAlbumView newAutoLayoutView];
        [_leftAlbumView setTag:1];
        [self.cellContentView addSubview:_leftAlbumView];
        
        [_leftAlbumView layoutTop:kContentViewInsideTopSpaceDistance layoutItemHandler:nil];
        [_leftAlbumView layoutBottom:-kContentViewInsideBottomSpaceDistance-5 layoutItemHandler:nil];
        [_leftAlbumView layoutWidth:viewWidth layoutItemHandler:nil];
        [_leftAlbumView layoutLeft:kContentViewInsideLeftSpaceDistance layoutItemHandler:nil];
        
        self.midAlbumView = [MIAProfileAlbumView newAutoLayoutView];
        [_midAlbumView setTag:2];
        [self.cellContentView addSubview:_midAlbumView];
        
        [_midAlbumView layoutSizeView:_leftAlbumView layoutItemHandler:nil];
        [_midAlbumView layoutLeftView:_leftAlbumView distance:kProfileAlbumItemSpaceDistance layoutItemHandler:nil];
        [_midAlbumView layoutTop:kContentViewInsideTopSpaceDistance layoutItemHandler:nil];
        
        self.rightAlbumView = [MIAProfileAlbumView newAutoLayoutView];
        [_rightAlbumView setTag:3];
        [self.cellContentView addSubview:_rightAlbumView];
        
        [_rightAlbumView layoutSizeView:_leftAlbumView layoutItemHandler:nil];
        [_rightAlbumView layoutLeftView:_midAlbumView distance:kProfileAlbumItemSpaceDistance layoutItemHandler:nil];
        [_rightAlbumView layoutTop:kContentViewInsideTopSpaceDistance layoutItemHandler:nil];
    
    }
}


- (void)setCellData:(id)data{
    
    if ([data isKindOfClass:[NSArray class]]) {
        
        [self createProfileAlbumCellContentView];
        
        [_leftAlbumView setHidden:YES];
        [_midAlbumView setHidden:YES];
        [_rightAlbumView setHidden:YES];
        
        for (int i = 0; i < [data count]; i++) {
            
            MIAProfileAlbumView *albumView = [self.cellContentView viewWithTag:i+1];
            [albumView setShowData:[data objectAtIndex:i]];
            [albumView setHidden:NO];
        }
        
    }else{
    
        [JOFException exceptionWithName:@"MIAProfileAlbumCell Exception" reason:@"data 需要的格式为数组,数组里的元素为HXAlbumModel类型"];
    }
}


@end
