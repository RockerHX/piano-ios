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
@property (nonatomic, copy) LiveCellClickBlock liveCellClickBlock;

@end

@implementation MIAProfileLiveCell

- (void)setCellWidth:(CGFloat)width{

    [self.cellContentView setBackgroundColor:[UIColor whiteColor]];
}

- (void)createLiveView{

    if (!self.liveView) {

        self.liveView = [MIAProfileLiveView newAutoLayoutView];
        @weakify(self);
        [_liveView profileLiveViewClickHandler:^{
        @strongify(self);
            if (self.liveCellClickBlock) {
                self.liveCellClickBlock();
            }
        }];
        [self.cellContentView addSubview:_liveView];
        
        [_liveView layoutEdge:UIEdgeInsetsMake(kContentViewInsideTopSpaceDistance, kContentViewInsideLeftSpaceDistance, -kContentViewInsideBottomSpaceDistance, -kContentViewInsideRightSpaceDistance) layoutItemHandler:nil];

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

- (void)liveCellClickBlock:(LiveCellClickBlock)block{

    self.liveCellClickBlock = nil;
    self.liveCellClickBlock = block;
}

@end
