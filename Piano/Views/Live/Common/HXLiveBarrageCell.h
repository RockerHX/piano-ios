//
//  HXLiveBarrageCell.h
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UITableView+FDTemplateLayoutCell.h"
#import "HXBarrageModel.h"


@class HXLiveBarrageCell;


@protocol HXLiveBarrageCellDelegate <NSObject>

@required
- (void)commentCellShouldShowCommenter:(HXLiveBarrageCell *)cell;

@end


@interface HXLiveBarrageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet id  <HXLiveBarrageCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet     UILabel *contentLabel;

- (void)updateWithBarrage:(HXBarrageModel *)barrage;

@end
