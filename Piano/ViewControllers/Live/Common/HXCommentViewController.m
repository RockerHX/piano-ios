//
//  HXCommentViewController.m
//  Piano
//
//  Created by miaios on 16/3/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXCommentViewController.h"
#import "HXCommentViewModel.h"

@interface HXCommentViewController ()
@end

@implementation HXCommentViewController {
    HXCommentViewModel *_viewModel;
}

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameLive;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_textField becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    _viewModel = [[HXCommentViewModel alloc] initWithRoomID:_roomID];
    RAC(_viewModel, content) = _textField.rac_textSignal;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)viewConfigure {
    ;
}

#pragma mark - Event Response
- (IBAction)sendButtonPressed {
    [self showHUD];
    
    @weakify(self)
    RACSignal *sendSignal = [_viewModel.sendCommand execute:nil];
    [sendSignal subscribeNext:^(NSString *message) {
        @strongify(self)
        [self showBannerWithPrompt:message];
    } error:^(NSError *error) {
        @strongify(self)
        [self showBannerWithPrompt:error.domain];
    } completed:^{
        @strongify(self)
        [self hiddenHUD];
        [self tapGesture];
    }];
}

- (void)tapGesture {
    [_textField resignFirstResponder];
    [self hiddenKeyBoardAnimation];
}

- (void)keyBoardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    //获取当前显示的键盘高度
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey ] CGRectValue].size;
    [self popKeyBoardAnimationWithHeight:keyboardSize.height];
}

#pragma mark - Private Methods
- (void)popKeyBoardAnimationWithHeight:(CGFloat)height {
    _bottomConstraint.constant = height;
    [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        [_commentView layoutIfNeeded];
    } completion:nil];
}

- (void)hiddenKeyBoardAnimation {
    _bottomConstraint.constant = -50.0f;
    [UIView animateWithDuration:0.4f animations:^{
        [_commentView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

@end
