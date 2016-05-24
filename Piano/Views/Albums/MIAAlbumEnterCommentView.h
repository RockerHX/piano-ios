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

/**
 *  发送评论.
 *
 *  @param commentConent 评论的内容
 */
typedef void(^SendCommentBlock) (NSString *commentConent);

@interface MIAAlbumEnterCommentView : UIView

/**
 *  键盘出现的回调.
 *
 *  @param block KeyBoardShowBlcok,
 */
- (void)keyBoardShowHandler:(KeyBoardShowBlcok)block;

/**
 *  输入框里面的文字高度的变化的block.
 *
 *  @param block TextViewHeightChangeBlock,
 */
- (void)textViewHeightChangeHandler:(TextViewHeightChangeBlock)block;

/**
 *  发送评论的回调.
 *
 *  @param block SendCommentBlock.
 */
- (void)sendAlbumCommentHanlder:(SendCommentBlock)block;

/**
 *  收起键盘
 */
- (void)resignTextViewFirstResponder;

/**
 *  清空TextView
 */
- (void)cleanTextView;

@end
