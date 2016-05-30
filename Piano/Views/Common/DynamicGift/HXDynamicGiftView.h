//
//  HXDynamicGiftView.h
//  Piano
//
//  Created by miaios on 16/5/26.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXGiftModel.h"


@interface HXDynamicGiftView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *animationView;
@property (weak, nonatomic) IBOutlet      UIView *informationContainer;
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet     UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *promptLabel;

- (void)animationWithGift:(HXGiftModel *)gift;

@end
