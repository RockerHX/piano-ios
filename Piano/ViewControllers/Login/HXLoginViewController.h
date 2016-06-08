//
//  HXLoginViewController.h
//  mia
//
//  Created by miaios on 15/11/26.
//  Copyright © 2015年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"


typedef NS_ENUM(NSUInteger, HXLoginViewControllerAction) {
    HXLoginViewControllerActionDismiss,
    HXLoginViewControllerActionLoginSuccess,
};


@class HXLoginViewController;


@protocol HXLoginViewControllerDelegate <NSObject>

@optional
- (void)loginViewController:(HXLoginViewController *)loginViewController takeAction:(HXLoginViewControllerAction)action;

@end


@interface HXLoginViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet id  <HXLoginViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property (weak, nonatomic) IBOutlet    UIButton *weixinButton;
@property (weak, nonatomic) IBOutlet    UIButton *mobileButton;
@property (weak, nonatomic) IBOutlet      UIView *registerView;
@property (weak, nonatomic) IBOutlet    UIButton *checkBoxButton;
@property (weak, nonatomic) IBOutlet      UIView *termOfServiceLabel;

- (IBAction)weixinButtonPressed;
- (IBAction)checkBoxButtonPressed:(UIButton *)button;

@end