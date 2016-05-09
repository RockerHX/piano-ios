//
//  MIAProfileReplayCell.m
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAProfileReplayCell.h"
#import "MIAProfileReplayView.h"

static CGFloat const kProfileReplayItemSpaceDistance = 20.;

@interface MIAProfileReplayCell(){

    CGFloat cellWidth;
}

@property (nonatomic, strong) MIAProfileReplayView *profileReplayView;

@end

@implementation MIAProfileReplayCell

- (void)setCellWidth:(CGFloat)width{
    
    [self.cellContentView setBackgroundColor:[UIColor whiteColor]];
    cellWidth = width;
    [self createProfileReplayCellContentView];
}

- (void)createProfileReplayCellContentView{
    
    CGFloat viewWidth = (cellWidth - kContentViewRightSpaceDistance -kContentViewLeftSpaceDistance -kContentViewInsideLeftSpaceDistance - kContentViewInsideRightSpaceDistance - kProfileReplayItemSpaceDistance)/2.;
    
    for (int i = 0; i < 2; i++) {
        
        MIAProfileReplayView *replayView = [self createProfileReplayViewWithData:nil];
        [replayView setTag:i+1];
        [self.cellContentView addSubview:replayView];
        
        [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentViewInsideTopSpaceDistance selfView:replayView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithBottomSpaceDistance:-kContentViewInsideBottomSpaceDistance selfView:replayView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithWidth:viewWidth selfView:replayView superView:self.cellContentView];
        
        if (i == 0) {
            [JOAutoLayout autoLayoutWithLeftSpaceDistance:kContentViewInsideLeftSpaceDistance selfView:replayView superView:self.cellContentView];
        }else{
            
            UIView *lastView = [self.cellContentView viewWithTag:i];
            [JOAutoLayout autoLayoutWithLeftView:lastView distance:kProfileReplayItemSpaceDistance selfView:replayView superView:self.cellContentView];
        }
    }
    
}


- (void)setCellData:(id)data{
    
}

- (MIAProfileReplayView *)createProfileReplayViewWithData:(id)data{
    
    MIAProfileReplayView *profileReplayView = [MIAProfileReplayView newAutoLayoutView];
    [profileReplayView setShowData:nil];
    return profileReplayView;
}

@end
