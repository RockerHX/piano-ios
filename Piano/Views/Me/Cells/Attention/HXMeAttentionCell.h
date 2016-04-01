//
//  HXMeAttentionCell.h
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXAttentionModel.h"


@interface HXMeAttentionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet     UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet      UIView *livePromptView;

- (void)updateCellWithAttention:(HXAttentionModel *)attention;

@end
