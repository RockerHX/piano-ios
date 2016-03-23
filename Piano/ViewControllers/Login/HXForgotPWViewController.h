//
//  HXForgotPWViewController.h
//  Mia
//
//  Created by miaios on 16/1/5.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"

@class HXCaptchButton;

@interface HXForgotPWViewController : UITableViewController

@property (weak, nonatomic) IBOutlet    UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet HXCaptchButton *captchaButton;
@property (weak, nonatomic) IBOutlet    UITextField *captchaTextField;
@property (weak, nonatomic) IBOutlet    UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet    UITextField *confirmTextField;

- (IBAction)resetButtonPressed;

@end
