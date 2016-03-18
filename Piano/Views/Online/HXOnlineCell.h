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

@property (weak, nonatomic) IBOutlet UIImageView *publisherAvatar;
@property (weak, nonatomic) IBOutlet UIImageView *previewCover;
@property (weak, nonatomic) IBOutlet     UILabel *publisherNameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *publishInfoLabel;
@property (weak, nonatomic) IBOutlet     UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet     UILabel *favoriteCountLabel;
@property (weak, nonatomic) IBOutlet     UILabel *attendeCountLabel;

- (void)displayCellWithModel:(HXOnlineModel *)model;

@end
