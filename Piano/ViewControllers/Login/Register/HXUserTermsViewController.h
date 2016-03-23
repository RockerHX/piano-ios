//
//  HXUserTermsViewController.h
//  mia
//
//  Created by miaios on 15/10/21.
//  Copyright © 2015年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"

@interface HXUserTermsViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet   UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)iKnowButtonPressed;

@end
