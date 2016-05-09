//
//  MIAMeAttentionContainerCell.m
//  Piano
//
//  Created by 刘维 on 16/5/5.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAMeAttentionContainerCell.h"
#import "MIAMeAttentionContainerView.h"

static CGFloat const kContentViewItemSpaceDistance = 25.; //每个元素间的间距

@interface MIAMeAttentionContainerCell(){
    
    CGFloat cellWidth;
}

@end

@implementation MIAMeAttentionContainerCell


- (void)setCellWidth:(CGFloat )width{
    
    cellWidth = width;
    [self.contentView setBackgroundColor:JOConvertRGBToColor(21., 21., 21., 1.)];
    [self.cellContentView setBackgroundColor:JOConvertRGBToColor(21., 21., 21., 1.)];
    [self createAttentionContainerCellContentView];
}

- (void)createAttentionContainerCellContentView{

    CGFloat viewWidth = (cellWidth - kContentViewRightSpaceDistance -kContentViewLeftSpaceDistance -kContentViewInsideLeftSpaceDistance - kContentViewInsideRightSpaceDistance - 2*kContentViewItemSpaceDistance)/3.;
    
    for (int i = 0; i < 3; i++) {
        
        MIAMeAttentionContainerView *containerView = [self createAttentionPromptViewWithData:nil];
        [containerView setTag:i+1];
        [self.cellContentView addSubview:containerView];
        
        [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentViewInsideTopSpaceDistance selfView:containerView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithBottomSpaceDistance:-kContentViewInsideBottomSpaceDistance selfView:containerView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithWidth:viewWidth selfView:containerView superView:self.cellContentView];
        
        if (i == 0) {
            [JOAutoLayout autoLayoutWithLeftSpaceDistance:kContentViewInsideLeftSpaceDistance selfView:containerView superView:self.cellContentView];
        }else{
            
            UIView *lastView = [self.cellContentView viewWithTag:i];
            [JOAutoLayout autoLayoutWithLeftView:lastView distance:kContentViewItemSpaceDistance selfView:containerView superView:self.cellContentView];
        }
    }
}

- (void)setCellData:(id)data{
    
    if ([data isKindOfClass:[NSArray class]]) {
        
        if ([data count] > 4 || [data count] < 1) {
            [JOFException exceptionWithName:@"MIAMeAttentionPromptCell exception" reason:@"DataArray 数据源有问题,count只能在1~3的之间"];
        }else{
            
            
        }
    }
}

- (MIAMeAttentionContainerView *)createAttentionPromptViewWithData:(id)data{
    
    MIAMeAttentionContainerView *meAttentionContainerView = [MIAMeAttentionContainerView newAutoLayoutView];
    [meAttentionContainerView setShowData:nil];
    return meAttentionContainerView;
}

@end
