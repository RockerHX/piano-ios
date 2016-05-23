//
//  MIAAlbumDetailView.h
//  Piano
//
//  Created by 刘维 on 16/5/11.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXSongModel.h"

typedef NS_ENUM(NSUInteger, AlbumDetailType) {

    AlbumDetailTypeNoReward, //进入未打赏过的专辑详情页
    AlbumDetailTypeReward, //进入已打赏过的专辑详情页
};

/**
 *  打赏下载的按钮的点击事件的block
 */
typedef void(^RewardAlbumActionBlock)();

/**
 *  播放歌曲发生改变的block.
 *
 *  @param songModel 歌曲的Model.
 *  @param songIndex 歌曲的索引.
 */
typedef void(^PlaySongChangeBlock)(HXSongModel *songModel, NSInteger songIndex);

@interface MIAAlbumDetailView : UIView

//获取detailView需要的高度
- (CGFloat)albumDetailViewHeight;

/**
 *  设置专辑的一些数据.
 *
 *  @param data 专辑的数据
 */
- (void)setAlbumHeadDetailData:(id)data;

/**
 *  设置专辑歌曲的数据.
 *
 *  @param data 专辑歌曲的数据.(数组类型)
 */
- (void)setAlbumSongModelData:(id)data;

/**
 *  按索引值播放专辑歌曲.
 *
 *  @param songIndex 歌曲的索引值.
 */
- (void)playAlbumSongWithIndex:(NSInteger)songIndex;

/**
 *  打赏按钮点击的回调.
 *
 *  @param block RewardAlbumActionBlock.
 */
- (void)rewardAlbumButtonClickHanlder:(RewardAlbumActionBlock)block;

/**
 *  播放歌曲发生改变时的handler处理.
 *
 *  @param sendBlock PlaySongChangeBlock.
 */
- (void)playSongChangeHandler:(PlaySongChangeBlock)sendBlock;

@end
