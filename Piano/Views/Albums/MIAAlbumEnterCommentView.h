//
//  MIAAlbumEnterCommentView.h
//  Piano
//
//  Created by 刘维 on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  键盘出现的block.
 *
 *  @param height 键盘的高度
 */
typedef void(^KeyBoardShowBlcok) (CGFloat height);

/**
 *  当输入框的高度需要发生变化的blcok
 *
 *  @param textViewHeight textView的高度
 */
typedef void(^TextViewHeightChangeBlock) (CGFloat textViewHeight);

@interface MIAAlbumEnterCommentView : UIView

- (void)keyBoardShowHandler:(KeyBoardShowBlcok)block;

- (void)textViewHeightChangeHandler:(TextViewHeightChangeBlock)block;

- (void)resignTextViewFirstResponder;

@end
