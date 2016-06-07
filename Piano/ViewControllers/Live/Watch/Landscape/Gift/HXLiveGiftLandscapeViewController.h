//
//  HXLiveGiftLandscapeViewController.h
//  Piano
//
//  Created by miaios on 16/6/7.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"


@interface HXLiveGiftLandscapeViewController : UIViewController

@property (weak, nonatomic) IBOutlet   UIView *tapView;
@property (weak, nonatomic) IBOutlet   UIView *containerView;
@property (weak, nonatomic) IBOutlet   UIView *countContainer;
@property (weak, nonatomic) IBOutlet   UIView *rechargeContainer;

@property (weak, nonatomic) IBOutlet  UILabel *balanceCountLabel;
@property (weak, nonatomic) IBOutlet  UILabel *countLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *giftConianerHeightConstraint;

@property (nonatomic, strong) NSString *roomID;

- (IBAction)giveGiftButtonPressed;

@end
