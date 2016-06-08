//
//  MIAProfileLiveCell.m
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAProfileLiveCell.h"
#import "MIAProfileLiveView.h"
#import "MIAProfileViewModel.h"

@interface MIAProfileLiveCell()

@property (nonatomic, strong) MIAProfileLiveView *liveView;

@end

@implementation MIAProfileLiveCell

- (void)setCellWidth:(CGFloat)width{

    [self.cellContentView setBackgroundColor:[UIColor whiteColor]];
}

- (void)createLiveView{

    if (!self.liveView) {

        self.liveView = [MIAProfileLiveView newAutoLayoutView];
        [self.cellContentView addSubview:_liveView];
        
        [JOAutoLayout autoLayoutWithLeftSpaceDistance:kContentViewInsideLeftSpaceDistance selfView:_liveView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentViewInsideTopSpaceDistance selfView:_liveView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithRightSpaceDistance:-kContentViewInsideRightSpaceDistance selfView:_liveView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithBottomSpaceDistance:-15. selfView:_liveView superView:self.cellContentView];

        }
}

- (void)setCellData:(id)data{

    if ([data isKindOfClass:[MIAProfileLiveModel class]]) {
        [self createLiveView];
        [_liveView setShowData:data];
        
    }else{
    
        [JOFException exceptionWithName:@"MIAProfileLiveCell exception!" reason:@"data需要是MIAProfileLiveModel类型"];
    }
    
}

@end
