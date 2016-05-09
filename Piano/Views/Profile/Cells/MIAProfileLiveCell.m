//
//  MIAProfileLiveCell.m
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAProfileLiveCell.h"
#import "MIAProfileLiveView.h"

@interface MIAProfileLiveCell()

@property (nonatomic, strong) MIAProfileLiveView *liveView;

@end

@implementation MIAProfileLiveCell

- (void)setCellWidth:(CGFloat)width{

    [self.cellContentView setBackgroundColor:[UIColor whiteColor]];
    [self createLiveView];
}

- (void)createLiveView{

    self.liveView = [MIAProfileLiveView newAutoLayoutView];
    [self.cellContentView addSubview:_liveView];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:kContentViewInsideLeftSpaceDistance selfView:_liveView superView:self.cellContentView];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentViewInsideTopSpaceDistance selfView:_liveView superView:self.cellContentView];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-kContentViewInsideRightSpaceDistance selfView:_liveView superView:self.cellContentView];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:-kContentViewInsideBottomSpaceDistance selfView:_liveView superView:self.cellContentView];

}

- (void)setCellData:(id)data{

    [_liveView setShowData:nil];
}

@end
