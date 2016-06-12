//
//  MIAHostAttentionCell.m
//  Piano
//
//  Created by 刘维 on 16/6/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAHostAttentionCell.h"
#import "MIAHostAttentionView.h"

static CGFloat const kAttentionViewItemSpaceDistance = 25.; //每个元素间的间距

@interface MIAHostAttentionCell(){

    CGFloat cellWidth;
}

@end

@implementation MIAHostAttentionCell

- (void)setCellWidth:(CGFloat )width{
    
    cellWidth = width;
    [self.contentView setBackgroundColor:JOConvertRGBToColor(0., 0., 0., 0.5)];
    [self.cellContentView setBackgroundColor:JOConvertRGBToColor(0., 0., 0., 0.5)];
    
    [self createAttentionPromptCellContentView];
}

- (void)createAttentionPromptCellContentView{
    
    CGFloat viewWidth = (cellWidth - kContentViewRightSpaceDistance -kContentViewLeftSpaceDistance -kContentViewInsideLeftSpaceDistance - kContentViewInsideRightSpaceDistance - 3*kAttentionViewItemSpaceDistance)/4.;
    
    for (int i = 0; i < 4; i++) {
        
        MIAHostAttentionView *attentionView = [self createAttentionPromptViewWithData:nil];
        [attentionView setAttentionViewWidth:viewWidth];
        [attentionView setTag:i+1];
        [self.cellContentView addSubview:attentionView];
        
        [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentViewInsideTopSpaceDistance selfView:attentionView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithBottomSpaceDistance:-kContentViewInsideBottomSpaceDistance selfView:attentionView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithWidth:viewWidth selfView:attentionView superView:self.cellContentView];
        
        if (i == 0) {
            [JOAutoLayout autoLayoutWithLeftSpaceDistance:kContentViewInsideLeftSpaceDistance selfView:attentionView superView:self.cellContentView];
        }else{
            
            UIView *lastView = [self.cellContentView viewWithTag:i];
            [JOAutoLayout autoLayoutWithLeftView:lastView distance:kAttentionViewItemSpaceDistance selfView:attentionView superView:self.cellContentView];
        }
    }
    
}

- (void)setCellData:(id)data{
    
    if ([data isKindOfClass:[NSArray class]]) {
        
        if ([data count] > 4 || [data count] < 1) {
            [JOFException exceptionWithName:@"MIAMeAttentionPromptCell exception" reason:@"DataArray 数据源有问题,count只能在1~4的之间"];
        }else{
            
            
        }
    }
}

- (MIAHostAttentionView *)createAttentionPromptViewWithData:(id)data{
    
    MIAHostAttentionView *meAttentionPromptView = [MIAHostAttentionView newAutoLayoutView];
    [meAttentionPromptView setShowData:nil];
    return meAttentionPromptView;
}

@end
