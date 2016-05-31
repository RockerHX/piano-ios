//
//  HXMobileLoginViewController.h
//  Piano
//
//  Created by miaios on 16/5/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HXMobileLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;

- (IBAction)backButtonPressed;

@end
