//
//  MIAAlbumEnterCommentView.m
//  Piano
//
//  Created by 刘维 on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAAlbumEnterCommentView.h"
#import "JOBaseSDK.h"
#import "MIAFontManage.h"

static CGFloat const kTopSpaceDistance = 10.;//上部的间距大小
static CGFloat const kBottomSpaceDistance = 10.;//下部的间距大小
static CGFloat const kLeftSpaceDistance = 10.;//左部的间距大小
static CGFloat const kRightSpaceDitance = 10.;//右部的间距大小
static CGFloat const kSendButtonWidth = 60.;//发送按钮的宽度

@interface MIAAlbumEnterCommentView()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *commentTextView;
@property (nonatomic, strong) UIButton *sendButton;

@property (nonatomic, copy) KeyBoardShowBlcok keyBoardShowBlock;
@property (nonatomic, copy) TextViewHeightChangeBlock textViewHeightChangeBlock;

@end

@implementation MIAAlbumEnterCommentView

- (void)dealloc{

    [self removeKeyBoardShowObbserve];
}

- (instancetype)init{

    self = [super init];
    if (self) {
        
        [self setBackgroundColor:[UIColor blackColor]];
        [self addKeyBoardShowObbserve];
        [self createCommentView];
    }
    return self;
}

- (void)createCommentView{
    
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sendButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [self addSubview:_sendButton];
    
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-kRightSpaceDitance selfView:_sendButton superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:kLeftSpaceDistance selfView:_sendButton superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:-kBottomSpaceDistance selfView:_sendButton superView:self];
    [JOAutoLayout autoLayoutWithWidth:kSendButtonWidth selfView:_sendButton superView:self];

    self.commentTextView = [UITextView newAutoLayoutView];
    [_commentTextView  setTextColor:[MIAFontManage getFontWithType:MIAFontType_Album_Comment_Enter]->color];
    [_commentTextView setFont:[MIAFontManage getFontWithType:MIAFontType_Album_Comment_Enter]->font];
    [_commentTextView setBackgroundColor:[UIColor whiteColor]];
    [_commentTextView setDelegate:self];
    [[_commentTextView layer] setCornerRadius:4.];
    [[_commentTextView layer] setMasksToBounds:YES];
    [self addSubview:_commentTextView];
        
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:kLeftSpaceDistance selfView:_commentTextView superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:kTopSpaceDistance selfView:_commentTextView superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:-kBottomSpaceDistance selfView:_commentTextView superView:self];
    [JOAutoLayout autoLayoutWithRightView:_sendButton distance:0. selfView:_commentTextView superView:self];
    
}

#pragma mark - keyboard

- (void)removeKeyBoardShowObbserve{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)addKeyBoardShowObbserve{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyBoardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    //获取当前显示的键盘高度
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey ] CGRectValue].size;
    
    if (_keyBoardShowBlock) {
        _keyBoardShowBlock(keyboardSize.height);
    }
}

- (void)keyBoardWillHidden:(NSNotification *)notification {

    if (_keyBoardShowBlock) {
        _keyBoardShowBlock(0.);
    }
}

- (void)keyBoardShowHandler:(KeyBoardShowBlcok)block{

    self.keyBoardShowBlock = nil;
    self.keyBoardShowBlock = block;
}

#pragma mark - textView height change

- (void)textViewHeightChangeHandler:(TextViewHeightChangeBlock)block{
    
    self.textViewHeightChangeBlock = nil;
    self.textViewHeightChangeBlock = block;
}

- (void)resignTextViewFirstResponder{

    [_commentTextView resignFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView{

    CGFloat textViewContentHeight = textView.contentSize.height;
    NSLog(@"height:%f",textViewContentHeight);
}

@end
