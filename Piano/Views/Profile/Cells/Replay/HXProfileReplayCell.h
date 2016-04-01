//
//  HXProfileReplayCell.h
//  Piano
//
//  Created by miaios on 16/4/1.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXReplayModel.h"


@interface HXProfileReplayCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet     UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet     UILabel *timeLabel;

- (void)updateCellWithReplay:(HXReplayModel *)replay;

@end
