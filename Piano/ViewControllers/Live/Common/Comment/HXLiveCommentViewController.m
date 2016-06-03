//
//  HXLiveCommentViewController.m
//  Piano
//
//  Created by miaios on 16/3/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveCommentViewController.h"
#import "HXLiveCommentViewModel.h"
#import "BlocksKit+UIKit.h"

@interface HXLiveCommentViewController ()
@end

@implementation HXLiveCommentViewController {
    HXLiveCommentViewModel *_viewModel;
}

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameLive;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    _viewModel = [[HXLiveCommentViewModel alloc] initWithRoomID:_roomID];
    RAC(_viewModel, content) = _textField.rac_textSignal;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewConfigure {
    __weak __typeof__(self)weakSelf = self;
    [_tapView bk_whenTapped:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf hiddenKeyboard];
    }];
    
    [_textField setBk_shouldReturnBlock:^BOOL(UITextField *textField) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf sendButtonPressed];
        return YES;
    }];
    
    [_textField becomeFirstResponder];
}

#pragma mark - Event Response
- (IBAction)sendButtonPressed {
    [self showHUD];
    
    @weakify(self)
    RACSignal *sendSignal = [_viewModel.sendCommand execute:nil];
    [sendSignal subscribeNext:^(NSString *message) {
        @strongify(self)
        [self hiddenHUD];
        [self showBannerWithPrompt:message];
    } error:^(NSError *error) {
        @strongify(self)
        [self hiddenHUD];
        if (![error.domain isEqualToString:RACCommandErrorDomain]) {
            [self showBannerWithPrompt:error.domain];
        }
    } completed:^{
        @strongify(self)
        [self hiddenHUD];
        [self hiddenKeyboard];
    }];
}

- (void)keyBoardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    //获取当前显示的键盘高度
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey ] CGRectValue].size;
    [self popKeyBoardAnimationWithHeight:keyboardSize.height];
}

- (void)keyBoardWillHidden:(NSNotification *)notification {
    [self hiddenKeyboard];
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
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)hiddenKeyboard {
    [self.view endEditing:YES];
    [self hiddenKeyBoardAnimation];
}

@end
