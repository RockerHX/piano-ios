//
//  MIAAlbumDetailView.h
//  Piano
//
//  Created by 刘维 on 16/5/11.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AlbumDetailType) {

    AlbumDetailTypeNoReward, //进入未打赏过的专辑详情页
    AlbumDetailTypeReward, //进入已打赏过的专辑详情页
};

/**
 *  打赏下载的按钮的点击事件的block
 */
typedef void(^RewardAlbumActionBlock)();

@interface MIAAlbumDetailView : UIView

//获取detailView需要的高度
- (CGFloat)albumDetailViewHeight;

//设置数据
- (void)setAlbumHeadDetailData:(id)data;

/**
 *  打赏按钮点击的回调.
 *
 *  @param block RewardAlbumActionBlock.
 */
- (void)rewardAlbumButtonClickHanlder:(RewardAlbumActionBlock)block;

@end
