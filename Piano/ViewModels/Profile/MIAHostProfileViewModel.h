//
//  MIAHostProfileViewModel.h
//  Piano
//
//  Created by 刘维 on 16/6/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAViewModel.h"

UIKIT_EXTERN CGFloat const kHostProfileViewHeadHeight;// 头部的高度.
UIKIT_EXTERN CGFloat const kHostProfileViewHeadImageWidth;//头部视图中图片的宽度.
UIKIT_EXTERN CGFloat const kHostProfileViewDefaultCellHeight;//cell默认的高度

@interface MIAHostProfileViewModel : MIAViewModel

/**
 *  获取关注视图的cell高度.
 *
 *  @param width view的宽度.
 */
+ (CGFloat)hostProfileAttentionCellHeightWitWidth:(CGFloat)width;

/**
 *  获取打赏专辑的cell高度.
 *
 *  @param width view的宽度.
 */
+ (CGFloat)hostProfileRewardAlbumCellHeightWithWidth:(CGFloat)width;

@end
