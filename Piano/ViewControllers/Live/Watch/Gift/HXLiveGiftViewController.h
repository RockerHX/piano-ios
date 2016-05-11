//
//  HXLiveGiftViewController.h
//  Piano
//
//  Created by miaios on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"


@interface HXLiveGiftViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *tapView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *lowGiftContainer;
@property (weak, nonatomic) IBOutlet UIView *normalGiftContainer;
@property (weak, nonatomic) IBOutlet UIView *mediumGiftContainer;
@property (weak, nonatomic) IBOutlet UIView *highGiftContainer;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

- (IBAction)giveGiftButtonPressed;

@end
