//
//  HXLiveEndViewController.h
//  Piano
//
//  Created by miaios on 16/3/30.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"

@class FXBlurView;
@class HXLiveEndViewController;


@protocol HXLiveEndViewControllerDelegate <NSObject>

@required
- (void)endViewControllerWouldLikeExitRoom:(HXLiveEndViewController *)viewController;

@end


@interface HXLiveEndViewController : UIViewController

@property (weak, nonatomic) IBOutlet          id  <HXLiveEndViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet  FXBlurView *blurView;
@property (weak, nonatomic) IBOutlet      UIView *containerView;

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet     UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *totalViewCountLabel;
@property (weak, nonatomic) IBOutlet     UILabel *appendFansCountLabel;
@property (weak, nonatomic) IBOutlet     UILabel *appendMCurrencyCountLabel;

- (IBAction)backButtonPressed;

@end
