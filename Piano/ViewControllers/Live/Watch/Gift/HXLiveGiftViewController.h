//
//  HXLiveGiftViewController.h
//  Piano
//
//  Created by miaios on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"
#import "HXShowRechargeDelegate.h"


@interface HXLiveGiftViewController : UIViewController

@property (weak, nonatomic) IBOutlet       id  <HXShowRechargeDelegate>rechargeDelegate;

@property (weak, nonatomic) IBOutlet   UIView *tapView;
@property (weak, nonatomic) IBOutlet   UIView *containerView;
@property (weak, nonatomic) IBOutlet   UIView *lowGiftContainer;
@property (weak, nonatomic) IBOutlet   UIView *normalGiftContainer;
@property (weak, nonatomic) IBOutlet   UIView *mediumGiftContainer;
@property (weak, nonatomic) IBOutlet   UIView *highGiftContainer;

@property (weak, nonatomic) IBOutlet UIButton *lowGiftButton;
@property (weak, nonatomic) IBOutlet UIButton *normalGiftButton;
@property (weak, nonatomic) IBOutlet UIButton *mediumGiftButton;
@property (weak, nonatomic) IBOutlet UIButton *highGiftButton;

@property (weak, nonatomic) IBOutlet  UILabel *balanceCountLabel;
@property (weak, nonatomic) IBOutlet   UIView *rechargeContainer;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (nonatomic, strong) NSString *roomID;

- (IBAction)giftButtonPressed:(UIButton *)button;
- (IBAction)giveGiftButtonPressed;

@end
