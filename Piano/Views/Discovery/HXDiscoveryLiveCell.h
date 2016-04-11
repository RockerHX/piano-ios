//
//  HXDiscoveryLiveCell.h
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXDiscoveryModel.h"


@class HXDiscoveryLiveCell;


@protocol HXDiscoveryLiveCellDelegate <NSObject>

@required
- (void)discoveryLiveCellAnchorContainerTaped:(HXDiscoveryLiveCell *)cell;

@end


@interface HXDiscoveryLiveCell : UITableViewCell

@property (weak, nonatomic) IBOutlet          id  <HXDiscoveryLiveCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet      UIView *anchorContainer;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet     UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *attendeCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet     UILabel *titleLabel;

- (void)updateCellWithModel:(HXDiscoveryModel *)model;

@end
