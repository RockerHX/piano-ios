//
//  HXMobileLoginViewController.h
//  Piano
//
//  Created by miaios on 16/5/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"
#import "HXLoginViewModel.h"


@protocol HXMobileLoginViewControllerDelegate;


@interface HXMobileLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet          id  <HXMobileLoginViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet    UIButton *loginButton;

@property (nonatomic, strong) HXLoginViewModel *viewModel;

- (IBAction)backButtonPressed;
- (IBAction)loginButtonPressed;

@end


@protocol HXMobileLoginViewControllerDelegate <NSObject>

@required
- (void)loginSuccessHandleWithData:(NSDictionary *)data;
- (void)loginFailureHanleWithPrompt:(NSString *)prompt;

@end
