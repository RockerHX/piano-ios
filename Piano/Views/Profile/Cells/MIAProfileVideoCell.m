//
//  MIAProfileVideoCell.m
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAProfileVideoCell.h"
#import "MIAProfileVideoView.h"

static CGFloat const kProfileVideoItemSpaceDistance = 20.;

@interface MIAProfileVideoCell(){

    CGFloat cellWidth;
}

@property (nonatomic, strong) MIAProfileVideoView *profileVideoView;

@end

@implementation MIAProfileVideoCell

- (void)setCellWidth:(CGFloat)width{
    
    [self.cellContentView setBackgroundColor:[UIColor whiteColor]];
    cellWidth = width;
    [self createProfileVideoCellContentView];
}

- (void)createProfileVideoCellContentView{
    
    CGFloat viewWidth = (cellWidth - kContentViewRightSpaceDistance -kContentViewLeftSpaceDistance -kContentViewInsideLeftSpaceDistance - kContentViewInsideRightSpaceDistance - kProfileVideoItemSpaceDistance)/2.;
    
    for (int i = 0; i < 2; i++) {
        
        MIAProfileVideoView *albumView = [self createProfileVideoViewWithData:nil];
        [albumView setTag:i+1];
        [self.cellContentView addSubview:albumView];
        
        [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentViewInsideTopSpaceDistance selfView:albumView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithBottomSpaceDistance:-kContentViewInsideBottomSpaceDistance selfView:albumView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithWidth:viewWidth selfView:albumView superView:self.cellContentView];
        
        if (i == 0) {
            [JOAutoLayout autoLayoutWithLeftSpaceDistance:kContentViewInsideLeftSpaceDistance selfView:albumView superView:self.cellContentView];
        }else{
            
            UIView *lastView = [self.cellContentView viewWithTag:i];
            [JOAutoLayout autoLayoutWithLeftView:lastView distance:kProfileVideoItemSpaceDistance selfView:albumView superView:self.cellContentView];
        }
    }
    
}


- (void)setCellData:(id)data{
    
}

- (MIAProfileVideoView *)createProfileVideoViewWithData:(id)data{
    
    MIAProfileVideoView *profileVideoView = [MIAProfileVideoView newAutoLayoutView];
    [profileVideoView setShowData:nil];
    return profileVideoView;
}

@end
