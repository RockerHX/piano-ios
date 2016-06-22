//
//  MIAProfileReplayCell.m
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAProfileReplayCell.h"
#import "MIAProfileReplayView.h"

CGFloat const kProfileReplayItemSpaceDistance = 11.;

@interface MIAProfileReplayCell(){

    CGFloat cellWidth;
}

@property (nonatomic, copy) NSString *profileUid;

@property (nonatomic, strong) MIAProfileReplayView *leftReplayView;
@property (nonatomic, strong) MIAProfileReplayView *rightReplayView;

@end

@implementation MIAProfileReplayCell

- (void)setProfileReplayUID:(NSString *)uid{

    self.profileUid = nil;
    self.profileUid = uid;
}

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
        
        [_leftReplayView layoutTop:kContentViewInsideTopSpaceDistance layoutItemHandler:nil];
        [_leftReplayView layoutBottom:-kContentViewInsideBottomSpaceDistance layoutItemHandler:nil];
        [_leftReplayView layoutWidth:viewWidth layoutItemHandler:nil];
        [_leftReplayView layoutLeft:kContentViewInsideLeftSpaceDistance layoutItemHandler:nil];
        
        self.rightReplayView = [MIAProfileReplayView newAutoLayoutView];
        [_rightReplayView setTag:2];
        [self.cellContentView addSubview:_rightReplayView];
        
        [_rightReplayView layoutSizeView:_leftReplayView layoutItemHandler:nil];
        [_rightReplayView layoutTop:kContentViewInsideTopSpaceDistance layoutItemHandler:nil];
        [_rightReplayView layoutLeftView:_leftReplayView distance:kProfileReplayItemSpaceDistance layoutItemHandler:nil];
        
        UIView *whiteView = [UIView newAutoLayoutView];
        [whiteView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView insertSubview:whiteView belowSubview:self.cellContentView];
        
        [whiteView layoutEdge:UIEdgeInsetsMake(0, kContentViewLeftSpaceDistance, 1., -kContentViewRightSpaceDistance) layoutItemHandler:nil];
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
            [replayView setUid:_profileUid];
            [replayView setShowData:[data objectAtIndex:i]];
        }
        
    }else{
    
        [JOFException exceptionWithName:@"MIAProfileReplayCell exception" reason:@"data必须是NSArray类型"];
    }
}


@end
