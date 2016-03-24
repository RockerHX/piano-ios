//
//  HXWatchLiveCommentCell.h
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UITableView+FDTemplateLayoutCell.h"


@class HXWatchLiveCommentCell;


@protocol HXWatchLiveCommentCellDelegate <NSObject>

@required
- (void)commentCellShouldShowCommenter:(HXWatchLiveCommentCell *)cell;

@end


@interface HXWatchLiveCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet id  <HXWatchLiveCommentCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet     UILabel *contentLabel;

@end
