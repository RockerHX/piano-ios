//
//  HXHostProfileContainerViewController.h
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXMeViewModel.h"
#import "HXAttentionModel.h"


typedef NS_ENUM(NSUInteger, HXHostProfileContainerAction) {
    HXHostProfileContainerActionAvatarTaped,
    HXHostProfileContainerActionNickNameTaped,
    HXHostProfileContainerActionSignatureTaped,
    HXHostProfileContainerActionRecharge,
    HXHostProfileContainerActionPurchaseHistory,
};


@protocol HXHostProfileContainerDelegate;


@interface HXHostProfileContainerViewController : UITableViewController

@property (weak, nonatomic) IBOutlet          id  <HXHostProfileContainerDelegate>delegate;

@property (weak, nonatomic) IBOutlet    UIButton *settingButton;
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet     UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *signatureLabel;

@property (nonatomic, strong) HXMeViewModel *viewModel;

- (IBAction)backButtonPressed;
- (IBAction)settingButtonPressed;

- (void)refresh;

@end


@protocol HXHostProfileContainerDelegate <NSObject>

@required
- (void)container:(HXHostProfileContainerViewController *)container hanleAttentionAnchor:(HXAttentionModel *)model;
- (void)container:(HXHostProfileContainerViewController *)container takeAction:(HXHostProfileContainerAction)action;

@end
