//
//  MIAAlbumSongCell.h
//  Piano
//
//  Created by 刘维 on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIABaseTableViewCell.h"

@interface MIAAlbumSongCell : MIABaseTableViewCell

/**
 *  设置歌曲播放的状态.
 *
 *  @param state YES:是播放 NO:未播放状态
 */
- (void)setSongPlayState:(BOOL)state;

/**
 *  设置cell的索引值.
 *
 *  @param cellIndex 索引值.
 */
- (void)setSongCellIndex:(NSInteger)cellIndex;

/**
 *  打开song cell下载状态的检查
 */
- (void)openSongDownloadState;

@end
