//
//  MIASettingViewModel.h
//  Piano
//
//  Created by 刘维 on 16/5/26.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAViewModel.h"

UIKIT_EXTERN CGFloat const kSettingDefaultCellHeight; //默认的cell的高度
UIKIT_EXTERN CGFloat const kSettingHeadImageCellHeight; //头像的cell的高度
UIKIT_EXTERN CGFloat const kSettingHeadImageHeight; //头像的高度

/**
 *  数据模型更新的block
 */
typedef void(^ContentDataUpdateBlock) ();

@interface MIASettingViewModel : MIAViewModel

@property (nonatomic, copy, readonly) NSArray *settingCellDataArray;
@property (nonatomic, strong) NSMutableArray *settingCellContentDataArray;

/**
 *  数据模型更新的回调.
 *
 *  @param block ContentDataUpdateBlock
 */
- (void)contentDataUpdateHanlder:(ContentDataUpdateBlock)block;


//更新数据模型中不同字段的接口
- (void)updateAvtarURLString:(NSString *)urlString; //头像URL
//下面几个更新会涉及到表的UI更新
- (void)updateNickName:(NSString *)nickName; //nic
- (void)updateSummay:(NSString *)summary;//简介
- (void)updateGender:(NSString *)gender; //性别  确保传过来的是 1 或者 2  1代表男性 2代表女性
- (void)updateCache; //缓存
- (void)updateSongCache; //歌曲缓存

@end
