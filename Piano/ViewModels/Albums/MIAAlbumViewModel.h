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
UIKIT_EXTERN CGFloat const kAlbumComentCellDefaultHeight;//默认的评论的cell的高度

UIKIT_EXTERN NSInteger const kAlbumCommentLimitCount;//拉取评论的数量


@interface MIAAlbumViewModel : MIAViewModel

@property (nonatomic, copy, readonly) NSString *uid;

@property (nonatomic, strong) MIAAlbumModel *albumModel;
@property (nonatomic, strong, readonly) NSMutableArray *cellDataArray;
@property (nonatomic, assign, readonly) NSInteger commentCount;

/**
 *  初始化 uid.
 *
 *  @param uid uid.
 *
 *  @return 实例化对象.
 */
- (instancetype)initWithUid:(NSString *)uid;

/**
 *  专辑信息的视图的高度.
 *
 *  @return 高度.
 */
- (CGFloat)albumDetailViewHeight;

/**
 *  获取某条评论的cell高度.
 *
 *  @param index 评论的索引.
 *
 *  @return cell的高度.
 */
- (CGFloat)commentCellHeightWithIndex:(NSInteger)index viewWidth:(CGFloat)width;

/**
 *  发送评论事件的信号.
 *
 *  @param content 评论的内容.
 *  @param albumID 专辑的ID.
 *
 *  @return 信号.
 */
- (RACSignal *)sendCommentWithContent:(NSString *)content albumID:(NSString *)albumID commentID:(NSString *)commentID;

/**
 *  获取专辑评论事件的信号.
 *
 *  @param albumID       专辑的id。
 *  @param lastCommentID 上次拉取到的commentID. PS:该值如果为空或者@"",则会被看做是更新评论列表,不会增加数据源的值，
 *                       否则则会增加数据源的值,如果出现重复的评论数据源可以检查这个值是否给定正确
 *
 *  @return 信号
 */
- (RACSignal *)getCommentListWithAlbumID:(NSString *)albumID lastCommentID:(NSString *)lastCommentID;


@end
