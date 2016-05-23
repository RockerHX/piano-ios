//
//  MIAAlbumPlayView.h
//  Piano
//
//  Created by 刘维 on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXSongModel.h"

/**
 *  歌曲播放的改变的block.
 *
 *  @param songIndex 当前歌曲的indxe.
 */
typedef void(^PlaySongBlock) (HXSongModel *songModel, NSInteger songIndex);

@interface MIAAlbumPlayView : UIView

/**
 *  播放歌曲发生改变的block回调.
 *
 *  @param block PlaySongChangeBlock.
 */
- (void)songChangeHandler:(PlaySongBlock)block;

/**
 *  设置歌曲Model的数组.
 *
 *  @param songModelArray 歌曲的数组.
 */
- (void)setSongModelArray:(NSArray *)songModelArray;

/**
 *  按索引值播放歌曲
 *
 *  @param songIndex 歌曲的索引值
 */
- (void)playSongIndex:(NSInteger)songIndex;


@end
