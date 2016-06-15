//
//  MIAHostProfileViewModel.h
//  Piano
//
//  Created by 刘维 on 16/6/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAViewModel.h"
#import "MIAHostProfileModel.h"

UIKIT_EXTERN CGFloat const kHostProfileViewHeadLeftSpaceDistance;//头像与左边的间距大小
UIKIT_EXTERN CGFloat const kHostProfileViewHeadRightSpaceDistance;//头像与右边的间距大小
UIKIT_EXTERN CGFloat const kHostProfileViewHeadTopSpaceDistance;//头像与头部的间距大小.
UIKIT_EXTERN CGFloat const kHostProfileViewDefaultCellHeight;//cell默认的高度

@interface MIAHostProfileViewModel : MIAViewModel

@property (nonatomic, readonly) NSMutableArray *hostProfileDataArray;
@property (nonatomic, readonly) MIAHostProfileModel *hostProfileModel;
@property (nonatomic, readonly) RACSignal *viewUpdateSignal;

/**
 *  获取关注视图的cell高度.
 *
 *  @param width view的宽度.
 */
+ (CGFloat)hostProfileAttentionCellHeightWitWidth:(CGFloat)width topState:(BOOL)state;

/**
 *  获取打赏专辑的cell高度.
 *
 *  @param width view的宽度.
 */
+ (CGFloat)hostProfileRewardAlbumCellHeightWithWidth:(CGFloat)width;

@end
