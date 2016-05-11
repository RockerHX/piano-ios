//
//  MIAAlbumRewardView.h
//  Piano
//
//  Created by 刘维 on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIAAlbumRewardView : UIView

/**
 *  设置视图的高度.
 *
 *  @param height 高度.
 */
- (void)setRewardViewHeight:(CGFloat)height;

/**
 *  设置数据.
 *
 *  @param rewardData 数据.
 */
- (void)setRewardData:(id)rewardData;

@end
