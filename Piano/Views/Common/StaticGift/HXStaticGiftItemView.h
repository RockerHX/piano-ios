//
//  HXStaticGiftItemView.h
//  Piano
//
//  Created by miaios on 16/5/30.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXGiftModel.h"


@interface HXStaticGiftItemView : UIView

@property (weak, nonatomic) IBOutlet      UIView *informationContainer;
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet     UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *promptLabel;

@property (weak, nonatomic) IBOutlet UIImageView *giftView;
@property (weak, nonatomic) IBOutlet     UILabel *countLabel;
@property (weak, nonatomic) IBOutlet      UIView *labelContainer;

- (void)showGift:(HXGiftModel *)gift completed:(void(^)(void))completed;

@end
