//
//  HXWatcherCell.h
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UITableView+FDTemplateLayoutCell.h"


@class HXWatcherCell;


@protocol HXWatcherCellDelegate <NSObject>

@required
- (void)commentCellShouldShowCommenter:(HXWatcherCell *)cell;

@end


@interface HXWatcherCell : UITableViewCell

@property (weak, nonatomic) IBOutlet id  <HXWatcherCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet     UILabel *contentLabel;

- (void)displayWithCommenter:(id)commenter;

@end
