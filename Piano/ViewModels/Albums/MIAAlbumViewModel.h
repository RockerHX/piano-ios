//
//  MIAAlbumViewModel.h
//  Piano
//
//  Created by 刘维 on 16/5/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAViewModel.h"
#import "MIAAlbumModel.h"

UIKIT_EXTERN CGFloat const kAlbumSongCellHeight;//歌曲的cell的高度
UIKIT_EXTERN CGFloat const kAlbumBarViewHeight;//头部Bar的高度
UIKIT_EXTERN CGFloat const kAlbumEnterCommentViewHeight;//底部输入评论的框的高度


@interface MIAAlbumViewModel : MIAViewModel

@property (nonatomic, copy, readonly) NSString *uid;

@property (nonatomic, strong) MIAAlbumModel *albumModel;
@property (nonatomic, strong, readonly) NSMutableArray *cellDataArray;

- (instancetype)initWithUid:(NSString *)uid;

@end
