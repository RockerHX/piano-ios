//
//  HXMeContainerViewController.h
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXMeViewModel.h"
#import "HXAttentionModel.h"


typedef NS_ENUM(NSUInteger, HXMeContainerAction) {
    HXMeContainerActionAvatarTaped,
    HXMeContainerActionNickNameTaped,
    HXMeContainerActionSignatureTaped,
    HXMeContainerActionRecharge,
    HXMeContainerActionPurchaseHistory,
};


@class HXMeContainerViewController;


@protocol HXMeContainerViewControllerDelegate <NSObject>

@required
- (void)container:(HXMeContainerViewController *)container hanleAttentionAnchor:(HXAttentionModel *)model;
- (void)container:(HXMeContainerViewController *)container takeAction:(HXMeContainerAction)action;

@end


@interface HXMeContainerViewController : UITableViewController

@property (weak, nonatomic) IBOutlet          id  <HXMeContainerViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet    UIButton *settingButton;
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet     UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *signatureLabel;

@property (nonatomic, strong) HXMeViewModel *viewModel;

- (IBAction)settingButtonPressed;

- (void)refresh;

@end
