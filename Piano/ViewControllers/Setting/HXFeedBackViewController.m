//
//  HXFeedBackViewController.m
//  mia
//
//  Created by miaios on 15/10/21.
//  Copyright © 2015年 Mia Music. All rights reserved.
//

#import "HXFeedBackViewController.h"
#import "HXTextView.h"
#import "NSString+IsNull.h"
#import "MiaAPIHelper.h"
#import "HXAlertBanner.h"
#import "MBProgressHUDHelp.h"
#import "UIConstants.h"

static NSString *FeedContentPrompt = @"欢迎您提出宝贵的意见或建议，我们将为您不断改进。";

@interface HXFeedBackViewController () {
	MBProgressHUD 	*_progressHUD;
}

@end

@implementation HXFeedBackViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameSetting;
}

#pragma mark - Config Methods
- (void)loadConfigure {
    _feedContentTextView.placeholderText = FeedContentPrompt;
    _feedContentTextView.delegate = self;
}

- (void)viewConfigure {
    _sendButton.enabled = NO;
    _feedContentTextView.layer.borderWidth = 0.5f;
    _feedContentTextView.layer.borderColor = UIColorByRGBA(230.0f, 230.0f, 230.0f, 1.0).CGColor;
    
    _feedContactTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 5.0f, 1.0f)];
    _feedContactTextField.leftViewMode = UITextFieldViewModeAlways;
    _feedContactTextField.layer.borderWidth = 0.5f;
    _feedContactTextField.layer.borderColor = UIColorByRGBA(230.0f, 230.0f, 230.0f, 1.0).CGColor;
}

#pragma mark - Event Response
- (IBAction)backButtonPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sendButtonPressed {
    if (_feedContentTextView.text.length) {
        [self userFeedBackReuqestWithContact:_feedContactTextField.text content:_feedContentTextView.text];
    } else {
        [HXAlertBanner showWithMessage:@"反馈内容不能为空哦" tap:nil];
    }
}

#pragma mark - Private Methods
- (void)showMBProgressHUD {
	if(!_progressHUD){
		UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
		_progressHUD = [[MBProgressHUD alloc] initWithView:window];
		[window addSubview:_progressHUD];
		_progressHUD.dimBackground = YES;
		_progressHUD.labelText = @"正在提交反馈";
		[_progressHUD show:YES];
	}
}

- (void)removeMBProgressHUD {
	if(_progressHUD){
		[_progressHUD removeFromSuperview];
		_progressHUD = nil;
	}
}

#pragma mark - Private Methods
- (void)userFeedBackReuqestWithContact:(NSString *)contact content:(NSString *)content {
	if ([NSString isNull:content]) {
		return;
	}

	[self showMBProgressHUD];
#warning Eden
//	[MiaAPIHelper feedbackWithNote:content
//						   contact:contact completeBlock:
//	 ^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
//		 if (success) {
//			 [HXAlertBanner showWithMessage:@"反馈成功" tap:nil];
//			 [self.navigationController popViewControllerAnimated:YES];
//		 } else {
//			 [HXAlertBanner showWithMessage:@"反馈失败，请稍后重试" tap:nil];
//		 }
//
//		 [self removeMBProgressHUD];
//	 } timeoutBlock:^(MiaRequestItem *requestItem) {
//		 [HXAlertBanner showWithMessage:@"反馈超时，请稍后重试" tap:nil];
//		 [self removeMBProgressHUD];
//	}];
}

#pragma mark - UITextViewDelegate Methods
- (void)textViewDidChange:(UITextView *)textView {
    _sendButton.enabled = textView.text.length;
}

@end
