//
//  HXLiveRewardViewController.h
//  Piano
//
//  Created by miaios on 16/5/11.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"


@interface HXLiveRewardViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *tapView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UILabel *rewardCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceCountLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

- (IBAction)rewardButtonPressed;

@end
