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

@property (nonatomic, strong) MIAProfileReplayView *leftReplayView;
@property (nonatomic, strong) MIAProfileReplayView *rightReplayView;

@end

@implementation MIAProfileReplayCell

- (void)setCellWidth:(CGFloat)width{
    
    [self.cellContentView setBackgroundColor:[UIColor whiteColor]];
    cellWidth = width;
}

- (void)createProfileReplayCellContentView{
    
    CGFloat viewWidth = (cellWidth - kContentViewRightSpaceDistance -kContentViewLeftSpaceDistance -kContentViewInsideLeftSpaceDistance - kContentViewInsideRightSpaceDistance - kProfileReplayItemSpaceDistance)/2.;
    
    if (!self.leftReplayView) {
    
        self.leftReplayView = [MIAProfileReplayView newAutoLayoutView];
        [_leftReplayView setTag:1];
        [self.cellContentView addSubview:_leftReplayView];
        
        [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentViewInsideTopSpaceDistance selfView:_leftReplayView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithBottomSpaceDistance:-kContentViewInsideBottomSpaceDistance selfView:_leftReplayView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithWidth:viewWidth selfView:_leftReplayView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithLeftSpaceDistance:kContentViewInsideLeftSpaceDistance selfView:_leftReplayView superView:self.cellContentView];
        
        self.rightReplayView = [MIAProfileReplayView newAutoLayoutView];
        [_rightReplayView setTag:2];
        [self.cellContentView addSubview:_rightReplayView];
        
        [JOAutoLayout autoLayoutWithSizeWithView:_leftReplayView selfView:_rightReplayView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentViewInsideTopSpaceDistance selfView:_rightReplayView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithLeftView:_leftReplayView distance:kProfileReplayItemSpaceDistance selfView:_rightReplayView superView:self.cellContentView];
    }
}


- (void)setCellData:(id)data{
    
    if ([data isKindOfClass:[NSArray class]]) {
        
        [self createProfileReplayCellContentView];
        
        [_leftReplayView setHidden:YES];
        [_rightReplayView setHidden:YES];
        
        for (int i = 0; i < [data count]; i++) {
            
            MIAProfileReplayView *replayView = [self.cellContentView viewWithTag:i+1];
            [replayView setHidden:NO];
            [replayView setShowData:[data objectAtIndex:i]];
        }
        
    }else{
    
        [JOFException exceptionWithName:@"MIAProfileReplayCell exception" reason:@"data必须是NSArray类型"];
    }
}


@end
