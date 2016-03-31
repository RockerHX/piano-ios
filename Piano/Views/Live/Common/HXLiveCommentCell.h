//
//  HXLiveCommentCell.h
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UITableView+FDTemplateLayoutCell.h"
#import "HXCommentModel.h"


@class HXLiveCommentCell;


@protocol HXLiveCommentCellDelegate <NSObject>

@required
- (void)commentCellShouldShowCommenter:(HXLiveCommentCell *)cell;

@end


@interface HXLiveCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet id  <HXLiveCommentCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet     UILabel *contentLabel;

- (void)updateWithComment:(HXCommentModel *)comment;

@end
