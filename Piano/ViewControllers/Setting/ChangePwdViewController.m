//
//  ChangePwdViewController.m
//  mia
//
//  Created by linyehui on 2015/09/08.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//

#import "ChangePwdViewController.h"
#import "MIAButton.h"
#import "MIALabel.h"
#import "UIImage+Extrude.h"
#import "UIImage+ColorToImage.h"
#import "MiaAPIHelper.h"
#import "WebSocketMgr.h"
#import "MBProgressHUDHelp.h"
#import "NSString+MD5.h"
#import "HXAlertBanner.h"
#import "UIConstants.h"
#import "MIANavBarView.h"
#import "JOBaseSDK.h"

@interface ChangePwdViewController () <UITextFieldDelegate>

@end

@implementation ChangePwdViewController {
    MIANavBarView   *_navBarView;
	UIView 			*_inputView;
	UITextField 	*_oldPasswordTextField;
	UITextField 	*_firstPasswordTextField;
	UITextField 	*_secondPasswordTextField;
	MIAButton 		*_confirmButton;

	MBProgressHUD 	*_progressHUD;
}

-(void)dealloc {
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
	[self initUI];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
	return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
	return NO;
}

- (void)initUI {
	static NSString *kChangePwdTitle = @"修改密码";
	self.title = kChangePwdTitle;
	NSDictionary *fontDictionary = @{NSForegroundColorAttributeName:[UIColor blackColor],
                                                NSFontAttributeName:[UIFont systemFontOfSize:16.0f]};
	[self.navigationController.navigationBar setTitleTextAttributes:fontDictionary];
	[self.view setBackgroundColor:[UIColor whiteColor]];
    
	[self initInputView];
    [self createNavBarView];
}

- (void)createNavBarView{

    _navBarView = [MIANavBarView newAutoLayoutView];
    [_navBarView setTitle:@"修改密码"];
    [_navBarView setBackgroundColor:[UIColor whiteColor]];
    [[_navBarView navBarTitleLabel] setTextColor:[UIColor blackColor]];
    [_navBarView setLeftButtonImageName:@"C-BackIcon-Gray"];
    [_navBarView showBottomLineView];
//    [_navBarView setLeftButtonTitle:@"x" titleColor:[UIColor blackColor]];
    
    @weakify(self);
    [_navBarView navBarLeftClickHanlder:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    } rightClickHandler:nil];
    [self.view addSubview:_navBarView];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_navBarView superView:self.view];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_navBarView superView:self.view];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_navBarView superView:self.view];
    [JOAutoLayout autoLayoutWithHeight:50. selfView:_navBarView superView:self.view];
}

- (void)initInputView {
    
	_inputView = [[UIView alloc] initWithFrame:self.view.frame];
	[self.view addSubview:_inputView];

	static const CGFloat kTextFieldMarginLeft		= 18;
	static const CGFloat kTextFieldHeight			= 45;
	static const CGFloat kUserNameMarginTop			= 50 + 30;
	static const CGFloat kVerificationCodeMarginTop	= kUserNameMarginTop + kTextFieldHeight + 5;
	static const CGFloat kFirstPasswordMarginTop	= kVerificationCodeMarginTop + kTextFieldHeight + 5;
	static const CGFloat kSecondPasswordMarginTop	= kFirstPasswordMarginTop + kTextFieldHeight + 5;
	static const CGFloat kSiginUpMarginTop			= kSecondPasswordMarginTop + kTextFieldHeight + 38;
	static const CGFloat kSignUpMarginLeft			= 16;

	UIColor *placeHolderColor = UIColorByHex(0x808080);
	UIColor *textColor = [UIColor blackColor];
	UIColor *lineColor = UIColorByHex(0xdcdcdc);
	UIFont *textFont = [UIFont systemFontOfSize:16.0f];

	_oldPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(kTextFieldMarginLeft,
																	  kUserNameMarginTop,
																	  self.view.frame.size.width - 2 * kTextFieldMarginLeft,
																	  kTextFieldHeight)];
	_oldPasswordTextField.borderStyle = UITextBorderStyleNone;
	_oldPasswordTextField.backgroundColor = [UIColor clearColor];
	_oldPasswordTextField.textColor = textColor;
	_oldPasswordTextField.placeholder = @"输入旧密码";
	[_oldPasswordTextField setFont:textFont];
	_oldPasswordTextField.secureTextEntry = YES;
	_oldPasswordTextField.keyboardType = UIKeyboardTypeDefault;
	_oldPasswordTextField.returnKeyType = UIReturnKeyNext;
	_oldPasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	_oldPasswordTextField.delegate = self;
	[_oldPasswordTextField setValue:placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];
	[_inputView addSubview:_oldPasswordTextField];

	UIView *userNameLineView = [[UIView alloc] initWithFrame:CGRectMake(kTextFieldMarginLeft,
																		kUserNameMarginTop + kTextFieldHeight,
																		_inputView.frame.size.width - 2 * kTextFieldMarginLeft,
																		0.5)];
	userNameLineView.backgroundColor = lineColor;
	[_inputView addSubview:userNameLineView];

	_firstPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(kTextFieldMarginLeft,
																			  kVerificationCodeMarginTop,
																			  _inputView.frame.size.width - 2 * kTextFieldMarginLeft,
																			  kTextFieldHeight)];
	_firstPasswordTextField.borderStyle = UITextBorderStyleNone;
	_firstPasswordTextField.backgroundColor = [UIColor clearColor];
	_firstPasswordTextField.textColor = textColor;
	_firstPasswordTextField.placeholder = @"输入新密码";
	[_firstPasswordTextField setFont:textFont];
	_firstPasswordTextField.secureTextEntry = YES;
	_firstPasswordTextField.keyboardType = UIKeyboardTypeDefault;
	_firstPasswordTextField.returnKeyType = UIReturnKeyNext;
	_firstPasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	_firstPasswordTextField.delegate = self;
	[_firstPasswordTextField setValue:placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];
	[_inputView addSubview:_firstPasswordTextField];

	UIView *verificationCodeLineView = [[UIView alloc] initWithFrame:CGRectMake(kTextFieldMarginLeft,
																				kVerificationCodeMarginTop + kTextFieldHeight,
																				_inputView.frame.size.width - 2 * kTextFieldMarginLeft,
																				0.5)];
	verificationCodeLineView.backgroundColor = lineColor;
	[_inputView addSubview:verificationCodeLineView];

	_secondPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(kTextFieldMarginLeft,
																		   kFirstPasswordMarginTop,
																		   _inputView.frame.size.width - 2 * kTextFieldMarginLeft,
																		   kTextFieldHeight)];
	_secondPasswordTextField.borderStyle = UITextBorderStyleNone;
	_secondPasswordTextField.backgroundColor = [UIColor clearColor];
	_secondPasswordTextField.textColor = textColor;
	_secondPasswordTextField.placeholder = @"再次输入新密码";
	[_secondPasswordTextField setFont:textFont];
	_secondPasswordTextField.secureTextEntry = YES;
	_secondPasswordTextField.keyboardType = UIKeyboardTypeDefault;
	_secondPasswordTextField.returnKeyType = UIReturnKeyDone;
	_secondPasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	_secondPasswordTextField.delegate = self;
	[_secondPasswordTextField setValue:placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];
	[_inputView addSubview:_secondPasswordTextField];

	UIView *firstPasswordLineView = [[UIView alloc] initWithFrame:CGRectMake(kTextFieldMarginLeft,
																			 kFirstPasswordMarginTop + kTextFieldHeight,
																			 _inputView.frame.size.width - 2 * kTextFieldMarginLeft,
																			 0.5)];
	firstPasswordLineView.backgroundColor = lineColor;
	[_inputView addSubview:firstPasswordLineView];

	CGRect resetButtonFrame = CGRectMake(kSignUpMarginLeft,
											 kSiginUpMarginTop,
											 _inputView.frame.size.width - 2 * kSignUpMarginLeft,
											 kTextFieldHeight);
	 _confirmButton = [[MIAButton alloc] initWithFrame:resetButtonFrame
													   titleString:@"修改密码"
														titleColor:[UIColor whiteColor]
															  font:[UIFont systemFontOfSize:16.0f]
														   logoImg:nil
												   backgroundImage:[UIImage createImageWithColor:UIColorByHex(0x000000)]];
	[_confirmButton setBackgroundImage:[UIImage createImageWithColor:UIColorByHex(0xf2f2f2)] forState:UIControlStateDisabled];
	[_confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
	[_confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
	[_confirmButton setEnabled:NO];
	_confirmButton.layer.cornerRadius = 23;
	_confirmButton.clipsToBounds = YES;
	[_inputView addSubview:_confirmButton];

	UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
	gesture.numberOfTapsRequired = 1;
	[_inputView addGestureRecognizer:gesture];
}

#pragma mark - delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField == _oldPasswordTextField) {
		[_firstPasswordTextField becomeFirstResponder];
	} else if (textField == _firstPasswordTextField) {
		[_secondPasswordTextField becomeFirstResponder];
	} else if (textField == _secondPasswordTextField) {
		[_secondPasswordTextField resignFirstResponder];
		[self resumeView];
	}

	[self checkConfirmButtonStatus];
	return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	if (textField == _secondPasswordTextField) {
		[self moveUpViewForKeyboard];
	}

	return YES;
}

#pragma mark - Notification

#pragma mark - keyboard

- (void)moveUpViewForKeyboard {
	NSTimeInterval animationDuration = 0.30f;
	[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
	[UIView setAnimationDuration:animationDuration];
	float width = _inputView.frame.size.width;
	float height = _inputView.frame.size.height;

	static const CGFloat kOffsetForKeyboard = 30;
	CGRect rect = CGRectMake(0.0f, -kOffsetForKeyboard, width,height);
	_inputView.frame = rect;
	[UIView commitAnimations];
}

- (void)resumeView {
	NSTimeInterval animationDuration = 0.30f;
	[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
	[UIView setAnimationDuration:animationDuration];
	float width = self.view.frame.size.width;
	float height = self.view.frame.size.height;
	CGRect rect = CGRectMake(0.0f, 0, width, height);
	_inputView.frame = rect;
	[UIView commitAnimations];
}

- (void)checkConfirmButtonStatus {
	if ([_oldPasswordTextField.text length] <= 0
		|| [_firstPasswordTextField.text length] <= 0
		|| [_secondPasswordTextField.text length] <= 0) {
		[_confirmButton setEnabled:NO];
	} else {
		[_confirmButton setEnabled:YES];
	}
}

- (BOOL)checkPasswordFormat {
	NSString *str1 = _firstPasswordTextField.text;
	NSString *str2 = _secondPasswordTextField.text;

	if (![str1 isEqualToString:str2]) {
		[HXAlertBanner showWithMessage:@"两次输入的密码不一致，请重新输入" tap:nil];
		return NO;
	}

	static const long kMinPasswordLength = 6;
	if (str1.length < kMinPasswordLength) {
		[HXAlertBanner showWithMessage:[NSString stringWithFormat:@"密码长度不能少于%ld位", kMinPasswordLength] tap:nil];
		return NO;
	}

	return YES;
}

#pragma mark - button Actions
- (void)confirmButtonAction:(id)sender {
	if (![self checkPasswordFormat])
		return;

	MBProgressHUD *aProgressHub = [MBProgressHUDHelp showLoadingWithText:@"正在修改密码"];

	NSString *oldPasswordHash = [NSString md5HexDigest:_oldPasswordTextField.text];
	NSString *newPasswordHash = [NSString md5HexDigest:_firstPasswordTextField.text];

	[MiaAPIHelper changePasswordWithOldPasswordHash:oldPasswordHash
									newPasswordHash:newPasswordHash
									  completeBlock:
	 ^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
		 if (success) {
			 [self.navigationController popViewControllerAnimated:YES];
			 [HXAlertBanner showWithMessage:@"密码修改成功" tap:nil];
		 } else {
			 id error = userInfo[MiaAPIKey_Values][MiaAPIKey_Error];
			 [HXAlertBanner showWithMessage:[NSString stringWithFormat:@"%@", error] tap:nil];
		 }

		 [aProgressHub removeFromSuperview];
	 } timeoutBlock:^(MiaRequestItem *requestItem) {
		 [aProgressHub removeFromSuperview];
	 }];
}

- (void)hidenKeyboard {
	[_oldPasswordTextField resignFirstResponder];
	[_firstPasswordTextField resignFirstResponder];
	[_secondPasswordTextField resignFirstResponder];

	[self resumeView];
	[self checkConfirmButtonStatus];
}

@end
