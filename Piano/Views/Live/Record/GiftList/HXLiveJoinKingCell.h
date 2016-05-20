//
//  HXLiveJoinKingCell.h
//  Piano
//
//  Created by miaios on 16/5/20.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXLiveJoinKingModel.h"


@interface HXLiveJoinKingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet     UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet     UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *coinTotalLabel;

- (void)updateWithKing:(HXLiveJoinKingModel *)king;

@end
