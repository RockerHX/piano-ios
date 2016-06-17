//
//  MIAProfileLiveCell.h
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIABaseTableViewCell.h"

typedef void(^LiveCellClickBlock)();

@interface MIAProfileLiveCell : MIABaseTableViewCell

/**
 *  LiveCell 的点击回调.
 *
 *  @param block LiveCellClickBlock
 */
- (void)liveCellClickBlock:(LiveCellClickBlock)block;

@end
