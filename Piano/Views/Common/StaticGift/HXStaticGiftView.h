//
//  HXStaticGiftView.h
//  Piano
//
//  Created by miaios on 16/5/26.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXStaticGiftItemView.h"


@interface HXStaticGiftView : UIView

@property (weak, nonatomic) IBOutlet HXStaticGiftItemView *topItemView;
@property (weak, nonatomic) IBOutlet HXStaticGiftItemView *bottomItemView;

- (void)animationWithGift:(HXGiftModel *)gift;

@end
