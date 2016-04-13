//
//  HXLiveEndViewController.h
//  Piano
//
//  Created by miaios on 16/3/30.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"


@class HXLiveModel;
@class HXLiveEndViewController;


@protocol HXLiveEndViewControllerDelegate <NSObject>

@required
- (void)endViewControllerWouldLikeExitRoom:(HXLiveEndViewController *)viewController;

@end


@interface HXLiveEndViewController : UIViewController

@property (weak, nonatomic) IBOutlet          id  <HXLiveEndViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *blurView;
@property (weak, nonatomic) IBOutlet      UIView *containerView;
@property (weak, nonatomic) IBOutlet      UIView *countContainerView;

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet     UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *totalViewCountLabel;
@property (weak, nonatomic) IBOutlet     UILabel *appendFansCountLabel;
@property (weak, nonatomic) IBOutlet     UILabel *appendMCurrencyCountLabel;

@property (nonatomic, assign)        BOOL  isLive;
@property (nonatomic, strong) HXLiveModel *liveModel;

@property (nonatomic, strong) UIImage *snapShotImage;

- (IBAction)backButtonPressed;

@end
