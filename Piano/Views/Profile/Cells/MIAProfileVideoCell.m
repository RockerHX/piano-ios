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
        
        [_leftVideoView layoutTop:kContentViewInsideTopSpaceDistance layoutItemHandler:nil];
        [_leftVideoView layoutBottom:-kContentViewInsideBottomSpaceDistance layoutItemHandler:nil];
        [_leftVideoView layoutLeft:kContentViewInsideLeftSpaceDistance layoutItemHandler:nil];
        [_leftVideoView layoutWidth:viewWidth layoutItemHandler:nil];
        
        self.rightVideoView = [MIAProfileVideoView newAutoLayoutView];
        [_rightVideoView setTag:2];
        [self.cellContentView addSubview:_rightVideoView];
        
        [_rightVideoView layoutTop:kContentViewInsideTopSpaceDistance layoutItemHandler:nil];
        [_rightVideoView layoutBottom:-kContentViewInsideBottomSpaceDistance layoutItemHandler:nil];
        [_rightVideoView layoutLeftView:_leftVideoView distance:kProfileVideoItemSpaceDistance layoutItemHandler:nil];
        [_rightVideoView layoutWidth:viewWidth layoutItemHandler:nil];
    
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
