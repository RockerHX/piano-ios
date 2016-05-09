//
//  MIAMeAttentionPromptCell.m
//  Piano
//
//  Created by 刘维 on 16/5/5.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAMeAttentionPromptCell.h"
#import "MIAMeAttentionPromptView.h"

static CGFloat const kContentViewItemSpaceDistance = 25.; //每个元素间的间距

@interface MIAMeAttentionPromptCell(){

    CGFloat cellWidth;
}

@end

@implementation MIAMeAttentionPromptCell


- (void)setCellWidth:(CGFloat )width{

    cellWidth = width;
    [self.contentView setBackgroundColor:JOConvertRGBToColor(21., 21., 21., 1.)];
    [self.cellContentView setBackgroundColor:JOConvertRGBToColor(21., 21., 21., 1.)];
    
    [self createAttentionPromptCellContentView];
}

- (void)createAttentionPromptCellContentView{

    CGFloat viewWidth = (cellWidth - kContentViewRightSpaceDistance -kContentViewLeftSpaceDistance -kContentViewInsideLeftSpaceDistance - kContentViewInsideRightSpaceDistance - 3*kContentViewItemSpaceDistance)/4.;
    
    for (int i = 0; i < 4; i++) {
        
        MIAMeAttentionPromptView *promptView = [self createAttentionPromptViewWithData:nil];
        [promptView setAttentionPromptViewWidth:viewWidth];
        [promptView setTag:i+1];
        [self.cellContentView addSubview:promptView];
        
        [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentViewInsideTopSpaceDistance selfView:promptView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithBottomSpaceDistance:-kContentViewInsideBottomSpaceDistance selfView:promptView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithWidth:viewWidth selfView:promptView superView:self.cellContentView];
        
        if (i == 0) {
            [JOAutoLayout autoLayoutWithLeftSpaceDistance:kContentViewInsideLeftSpaceDistance selfView:promptView superView:self.cellContentView];
        }else{
            
            UIView *lastView = [self.cellContentView viewWithTag:i];
            [JOAutoLayout autoLayoutWithLeftView:lastView distance:kContentViewItemSpaceDistance selfView:promptView superView:self.cellContentView];
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

- (MIAMeAttentionPromptView *)createAttentionPromptViewWithData:(id)data{

    MIAMeAttentionPromptView *meAttentionPromptView = [MIAMeAttentionPromptView newAutoLayoutView];
    [meAttentionPromptView setShowData:nil];
    return meAttentionPromptView;
}

@end
