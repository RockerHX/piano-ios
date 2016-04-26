//
//  HXDiscoveryLiveCell.h
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDiscoveryCell.h"
#import "HXDiscoveryModel.h"


@interface HXDiscoveryLiveCell : HXDiscoveryCell

@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet     UILabel *countLabel;
@property (weak, nonatomic) IBOutlet     UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *titleLabel;

- (void)updateCellWithModel:(HXDiscoveryModel *)model;

@end
