//
//  HXRegisterViewController.m
//  Mia
//
//  Created by miaios on 16/1/5.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXRegisterViewController.h"
#import "TTTAttributedLabel.h"
#import "HXUserTermsViewController.h"
#import "UIConstants.h"

@interface HXRegisterViewController () <
TTTAttributedLabelDelegate
>
@end

@implementation HXRegisterViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    CGFloat preferredMaxLayoutWidth = SCREEN_WIDTH - 60.0f;
    _firstPromptLabel.preferredMaxLayoutWidth = preferredMaxLayoutWidth;
    _secondPromptLabel.preferredMaxLayoutWidth = preferredMaxLayoutWidth;
}

- (void)viewConfigure {
    NSDictionary *linkAttributes = @{(__bridge id)kCTUnderlineStyleAttributeName: [NSNumber numberWithInt:kCTUnderlineStyleNone],
                                     (__bridge id)kCTForegroundColorAttributeName: [UIColor blueColor]};
    _secondPromptLabel.activeLinkAttributes = linkAttributes;
    _secondPromptLabel.linkAttributes = linkAttributes;
    
    NSString *linkString = @"《Mia音乐软件使用协议》";
    [_secondPromptLabel addLinkToPhoneNumber:linkString withRange:[_secondPromptLabel.text rangeOfString:linkString]];
}

#pragma mark - TTTAttributedLabelDelegate Methods
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithPhoneNumber:(NSString *)phoneNumber {
    HXUserTermsViewController *userTermsViewController = [HXUserTermsViewController instance];
    [self presentViewController:userTermsViewController animated:YES completion:nil];
}

@end
