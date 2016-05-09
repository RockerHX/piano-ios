//
//  MIAProfileAlbumCell.m
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAProfileAlbumCell.h"
#import "MIAProfileAlbumView.h"

static CGFloat const kProfileAlbumItemSpaceDistance = 20.;

@interface MIAProfileAlbumCell(){

    CGFloat cellWidth;
}

@property (nonatomic, strong) MIAProfileAlbumView *profileAlbumView;

@end

@implementation MIAProfileAlbumCell

- (void)setCellWidth:(CGFloat)width{
    
    [self.cellContentView setBackgroundColor:[UIColor whiteColor]];
    cellWidth = width;
    [self createProfileAlbumCellContentView];
}

- (void)createProfileAlbumCellContentView{
    
    CGFloat viewWidth = (cellWidth - kContentViewRightSpaceDistance -kContentViewLeftSpaceDistance -kContentViewInsideLeftSpaceDistance - kContentViewInsideRightSpaceDistance - 2*kProfileAlbumItemSpaceDistance)/3.;
    
    for (int i = 0; i < 3; i++) {
        
        MIAProfileAlbumView *albumView = [self createProfileAlbumViewWithData:nil];
        [albumView setTag:i+1];
        [self.cellContentView addSubview:albumView];
        
        [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentViewInsideTopSpaceDistance selfView:albumView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithBottomSpaceDistance:-kContentViewInsideBottomSpaceDistance selfView:albumView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithWidth:viewWidth selfView:albumView superView:self.cellContentView];
        
        if (i == 0) {
            [JOAutoLayout autoLayoutWithLeftSpaceDistance:kContentViewInsideLeftSpaceDistance selfView:albumView superView:self.cellContentView];
        }else{
            
            UIView *lastView = [self.cellContentView viewWithTag:i];
            [JOAutoLayout autoLayoutWithLeftView:lastView distance:kProfileAlbumItemSpaceDistance selfView:albumView superView:self.cellContentView];
        }
    }
    
}


- (void)setCellData:(id)data{
    
}

- (MIAProfileAlbumView *)createProfileAlbumViewWithData:(id)data{
    
    MIAProfileAlbumView *profileAlbumView = [MIAProfileAlbumView newAutoLayoutView];
    [profileAlbumView setShowData:nil];
    return profileAlbumView;
}

@end
