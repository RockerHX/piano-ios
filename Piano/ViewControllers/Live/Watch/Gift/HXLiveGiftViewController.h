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

@property (weak, nonatomic) IBOutlet  UILabel *balanceCountLabel;
@property (weak, nonatomic) IBOutlet   UIView *rechargeContainer;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conianerHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (nonatomic, strong) NSString *roomID;

- (IBAction)giveGiftButtonPressed;

@end
