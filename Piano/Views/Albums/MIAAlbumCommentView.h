//
//  MIAAlbumCommentView.h
//  Piano
//
//  Created by 刘维 on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat const kImageToLabelSpaceDistance;//图片与label之间的间距
UIKIT_EXTERN CGFloat const kImageWidth;//图片的宽度
UIKIT_EXTERN CGFloat const kCommentContentRightSpaceDistance;//右间距大小.

@interface MIAAlbumCommentView : UIView

/**
 *  这是评论的数据模型.
 *
 *  @param data MIACommentModle
 */
- (void)setAlbumCommentData:(id)data;

/**
 *  设置提交评论视图的宽度.
 *
 *  @param width 宽度.
 */
- (void)setCommentViewWidth:(CGFloat)width;

@end
