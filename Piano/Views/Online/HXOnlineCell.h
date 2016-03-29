//
//  HXOnlineCell.h
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXOnlineModel.h"


@interface HXOnlineCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet     UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *attendeCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet     UILabel *titleLabel;

- (void)displayCellWithModel:(HXOnlineModel *)model;

@end
