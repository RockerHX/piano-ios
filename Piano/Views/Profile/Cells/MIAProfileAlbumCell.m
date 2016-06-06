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
        
        [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentViewInsideTopSpaceDistance selfView:_leftAlbumView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithBottomSpaceDistance:-kContentViewInsideBottomSpaceDistance selfView:_leftAlbumView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithWidth:viewWidth selfView:_leftAlbumView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithLeftSpaceDistance:kContentViewInsideLeftSpaceDistance selfView:_leftAlbumView superView:self.cellContentView];
        
        self.midAlbumView = [MIAProfileAlbumView newAutoLayoutView];
        [_midAlbumView setTag:2];
        [self.cellContentView addSubview:_midAlbumView];
        
        [JOAutoLayout autoLayoutWithSizeWithView:_leftAlbumView selfView:_midAlbumView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithLeftView:_leftAlbumView distance:kProfileAlbumItemSpaceDistance selfView:_midAlbumView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentViewInsideTopSpaceDistance selfView:_midAlbumView superView:self.cellContentView];
        
        self.rightAlbumView = [MIAProfileAlbumView newAutoLayoutView];
        [_rightAlbumView setTag:3];
        [self.cellContentView addSubview:_rightAlbumView];
        
        [JOAutoLayout autoLayoutWithSizeWithView:_leftAlbumView selfView:_rightAlbumView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithLeftView:_midAlbumView distance:kProfileAlbumItemSpaceDistance selfView:_rightAlbumView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentViewInsideTopSpaceDistance selfView:_rightAlbumView superView:self.cellContentView];
    
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
