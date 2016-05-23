//
//  HXLiveRewardTopCell.h
//  Piano
//
//  Created by miaios on 16/5/20.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXLiveRewardTopModel.h"


@interface HXLiveRewardTopCell : UITableViewCell

@property (weak, nonatomic) IBOutlet     UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet     UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *coinTotalLabel;

- (void)updateWithTop:(HXLiveRewardTopModel *)top;

@end
