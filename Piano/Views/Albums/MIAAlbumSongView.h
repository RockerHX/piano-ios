//
//  MIAAlbumSongView.h
//  Piano
//
//  Created by 刘维 on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIAAlbumSongView : UIView

/**
 *  更改歌曲不同的播放状态下的显示
 *
 *  @param state YES:正在播放的状态 NO:未播放的状态
 */
- (void)changeSongPlayState:(BOOL)state;

/**
 *  打开歌曲下载状态的提示
 *
 */
- (void)openAlbumSongDownloadState;

/**
 *  设置歌曲的Model
 *
 *  @param data HXSongModel
 */
- (void)setSongData:(id)data;

/**
 *  设置歌曲在列表中的索引位置.
 *
 *  @param index 索引位置.
 */
- (void)setSongIndex:(NSInteger)index;

@end
