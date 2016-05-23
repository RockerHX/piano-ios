//
//  HXLiveGiftItemCell.h
//  Piano
//
//  Created by miaios on 16/5/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXGiftModel.h"


@interface HXLiveGiftItemCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *giftLogo;
@property (weak, nonatomic) IBOutlet     UILabel *coinCountLabel;

- (void)updateWithGift:(HXGiftModel *)gift;

@end
