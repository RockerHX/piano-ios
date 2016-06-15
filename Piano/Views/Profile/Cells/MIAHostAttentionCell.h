//
//  MIAHostAttentionCell.h
//  Piano
//
//  Created by 刘维 on 16/6/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIABaseTableViewCell.h"

UIKIT_EXTERN CGFloat const kAttentionViewItemSpaceDistance;//每个关注的人之间的间距大小 水平方向
UIKIT_EXTERN CGFloat const kAttentionViewItemVerticalSpaceDistance;//竖直方向 每个item的间距大小

@interface MIAHostAttentionCell : MIABaseTableViewCell

/**
 *  针对大于1的row的cell的头部不需要那么高的情况.
 *
 *  @param state 状态
 */
- (void)setHostAttentionTopState:(BOOL)state;

@end
