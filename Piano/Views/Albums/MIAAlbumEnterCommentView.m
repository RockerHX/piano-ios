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
#import "HXTextView.h"
#import "MiaAPIHelper.h"

static CGFloat const kTopSpaceDistance = 10.;//上部的间距大小
static CGFloat const kBottomSpaceDistance = 10.;//下部的间距大小
static CGFloat const kLeftSpaceDistance = 10.;//左部的间距大小
static CGFloat const kRightSpaceDitance = 10.;//右部的间距大小
static CGFloat const kSendButtonWidth = 60.;//发送按钮的宽度

@interface MIAAlbumEnterCommentView()<UITextViewDelegate,HXTextViewDelegate>

@property (nonatomic, strong) HXTextView *commentTextView;
@property (nonatomic, strong) UIButton *sendButton;

@property (nonatomic, copy) KeyBoardShowBlcok keyBoardShowBlock;
@property (nonatomic, copy) TextViewHeightChangeBlock textViewHeightChangeBlock;
@property (nonatomic, copy) SendCommentBlock sendCommentBlock;

@end

@implementation MIAAlbumEnterCommentView

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
    [_sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_sendButton setEnabled:NO];
    [[_sendButton titleLabel] setFont:[MIAFontManage getFontWithType:MIAFontType_Album_Comment_Send]->font];
    [_sendButton addTarget:self action:@selector(sendCommentAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sendButton];
    
    [_sendButton layoutRight:-kRightSpaceDitance layoutItemHandler:nil];
    [_sendButton layoutTop:kTopSpaceDistance layoutItemHandler:nil];
    [_sendButton layoutBottom:-kBottomSpaceDistance layoutItemHandler:nil];
    [_sendButton layoutWidth:kSendButtonWidth layoutItemHandler:nil];

    self.commentTextView = [HXTextView newAutoLayoutView];
    [_commentTextView  setTextColor:[MIAFontManage getFontWithType:MIAFontType_Album_Comment_Enter]->color];
    [_commentTextView setFont:[MIAFontManage getFontWithType:MIAFontType_Album_Comment_Enter]->font];
    [_commentTextView setBackgroundColor:[UIColor whiteColor]];
    [_commentTextView setDelegate:self];
    [_commentTextView setReturnKeyType:UIReturnKeyDone];
    [_commentTextView setMaxLine:5.];
    [_commentTextView setPlaceholderText:@"说说你的想法"];
    [[_commentTextView layer] setCornerRadius:4.];
    [[_commentTextView layer] setMasksToBounds:YES];
    [self addSubview:_commentTextView];
    
    [_commentTextView layoutLeft:kLeftSpaceDistance layoutItemHandler:nil];
    [_commentTextView layoutTop:kTopSpaceDistance layoutItemHandler:nil];
    [_commentTextView layoutBottom:-kBottomSpaceDistance layoutItemHandler:nil];
    [_commentTextView layoutRightView:_sendButton distance:0. layoutItemHandler:nil];
}

#pragma mark - Button Action

- (void)sendCommentAction{

    if ([JOTrimString(_commentTextView.text) length]) {
        
        if (_sendCommentBlock) {
            _sendCommentBlock(_commentTextView.text);
        }
    }
}

#pragma mark - HXTextView delegate

- (void)textViewSizeChanged:(CGSize)size{

    if (_textViewHeightChangeBlock) {
        _textViewHeightChangeBlock(size.height);
    }
}

- (void)textViewDidChange:(UITextView *)textView{

    if ([textView.text length]) {
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendButton setEnabled:YES];
    }else{
        [_sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_sendButton setEnabled:NO];
    }
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
        _keyBoardShowBlock(keyboardSize.height, YES);
    }
}

- (void)keyBoardWillHidden:(NSNotification *)notification {

    if (_keyBoardShowBlock) {
        _keyBoardShowBlock(0., NO);
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

- (void)cleanTextView{

    [_commentTextView setText:@""];
}

#pragma mark - send Comment

- (void)sendAlbumCommentHanlder:(SendCommentBlock)block{

    self.sendCommentBlock = nil;
    self.sendCommentBlock = block;
}

@end
