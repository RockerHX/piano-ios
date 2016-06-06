//
//  MIAProfileVideoCell.m
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAProfileVideoCell.h"
#import "MIAProfileVideoView.h"

CGFloat const kProfileVideoItemSpaceDistance = 11.;

@interface MIAProfileVideoCell(){

    CGFloat cellWidth;
}

@property (nonatomic, strong) MIAProfileVideoView *leftVideoView;
@property (nonatomic, strong) MIAProfileVideoView *rightVideoView;

@end

@implementation MIAProfileVideoCell

- (void)setCellWidth:(CGFloat)width{
    
    [self.cellContentView setBackgroundColor:[UIColor whiteColor]];
    cellWidth = width;
    
}
- (void)createProfileVideoCellContentView{
    
    CGFloat viewWidth = (cellWidth - kContentViewRightSpaceDistance -kContentViewLeftSpaceDistance -kContentViewInsideLeftSpaceDistance - kContentViewInsideRightSpaceDistance - kProfileVideoItemSpaceDistance)/2.;
    
    if (!self.leftVideoView) {
    
        self.leftVideoView = [MIAProfileVideoView newAutoLayoutView];
        [_leftVideoView setTag:1];
        [self.cellContentView addSubview:_leftVideoView];
        
        [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentViewInsideTopSpaceDistance selfView:_leftVideoView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithBottomSpaceDistance:-kContentViewInsideBottomSpaceDistance selfView:_leftVideoView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithLeftSpaceDistance:kContentViewInsideLeftSpaceDistance selfView:_leftVideoView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithWidth:viewWidth selfView:_leftVideoView superView:self.cellContentView];
        
        self.rightVideoView = [MIAProfileVideoView newAutoLayoutView];
        [_rightVideoView setTag:2];
        [self.cellContentView addSubview:_rightVideoView];
        
        [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentViewInsideTopSpaceDistance selfView:_rightVideoView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithBottomSpaceDistance:-kContentViewInsideBottomSpaceDistance selfView:_rightVideoView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithLeftView:_leftVideoView distance:kProfileVideoItemSpaceDistance selfView:_rightVideoView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithWidth:viewWidth selfView:_rightVideoView superView:self.cellContentView];
    
    }
}


- (void)setCellData:(id)data{
    
    if ([data isKindOfClass:[NSArray class]]) {
        
        [self createProfileVideoCellContentView];
        [_leftVideoView setHidden:YES];
        [_rightVideoView setHidden:YES];
        
        for (int i = 0; i < [data count]; i++) {
            MIAProfileVideoView *videoView = [self.cellContentView viewWithTag:i+1];
            [videoView setHidden:NO];
            [videoView setShowData:[data objectAtIndex:i]];
        }
    }else{
    
        [JOFException exceptionWithName:@"MIAProfileVideoCell exception!" reason:@"data需要为NSArray,里面的元素要为MIAVideoModel类型"];
    }
}

@end
