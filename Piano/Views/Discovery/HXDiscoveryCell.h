//
//  HXDiscoveryCell.h
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXDiscoveryModel.h"


@class HXDiscoveryCell;


@protocol HXDiscoveryCellDelegate <NSObject>

@required
- (void)discoveryCellAnchorContainerTaped:(HXDiscoveryCell *)cell;

@end


@interface HXDiscoveryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet          id  <HXDiscoveryCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet      UIView *anchorContainer;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet     UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *attendeCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet     UILabel *titleLabel;

- (void)updateCellWithModel:(HXDiscoveryModel *)model;

@end
