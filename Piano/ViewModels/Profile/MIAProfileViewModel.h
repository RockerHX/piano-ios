//
//  MIAProfileViewModel.h
//  Piano
//
//  Created by 刘维 on 16/5/9.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAViewModel.h"

UIKIT_EXTERN CGFloat const kProfileLiveCellHeight; //直播cell的高度
UIKIT_EXTERN CGFloat const kProfileAlbumCellHeight; //专辑cell的高度
UIKIT_EXTERN CGFloat const kProfileVideoCellHeight; //视频cell的高度
UIKIT_EXTERN CGFloat const kProfileReplayCellHeight; //直播回放cell的高度

typedef NS_ENUM(NSUInteger, MIAProfileCellType) {

    MIAProfileCellTypeLive, // 正在直播
    MIAProfileCellTypeAlbum, //专辑
    MIAProfileCellTypeVideo, //视频
    MIAProfileCellTypeReplay, //直播回放
};

#pragma mark - Profile头部需要的数据模型
@interface MIAProfileHeadModel : NSObject


@property (nonatomic, copy) NSString *uid; //uid
@property (nonatomic, copy) NSString *nickName;//昵称
@property (nonatomic, copy) NSString *gender; // 0为未知 1为男性 2为女性
@property (nonatomic, copy) NSString *summary; //介绍
@property (nonatomic, copy) NSString *followState;
@property (nonatomic, copy) NSString *avatarURL;//图片的地址
@property (nonatomic, copy) NSString *fansCount;//粉丝数
@property (nonatomic, copy) NSString *followCount;//关注数
@property (nonatomic, copy) NSString *userpic; //用户的图片

@end

#pragma mark - 直播cell需要的数据模型
@interface MIAProfileLiveModel : NSObject

@property (nonatomic, copy) NSString *nickName;//主播的昵称
@property (nonatomic, copy) NSString *liveState;//直播的状态
@property (nonatomic, copy) NSString *liveViewCount; //总共多少人看
@property (nonatomic, copy) NSString *liveOnlineCount; //多少人正在观看直播
@property (nonatomic, copy) NSString *liveRoomID;//直播的房间ID
@property (nonatomic, copy) NSString *liveTitle; //直播的标题
@property (nonatomic, copy) NSString *liveCoverURL;//直播的地址
@property (nonatomic, copy) NSString *liveDate;//直播的时间

@end

@interface MIAProfileViewModel : MIAViewModel

@property (nonatomic, strong, readonly) RACCommand *attentionCommand;
@property (nonatomic, strong, readonly) RACCommand *unAttentionCommand;

@property (nonatomic, assign, readonly) NSInteger sections;
@property (nonatomic, strong, readonly) NSMutableArray *cellTypes;

@property (nonatomic, copy, readonly) NSString *uid;

@property (nonatomic, strong) MIAProfileHeadModel *profileHeadModel;
@property (nonatomic, strong) MIAProfileLiveModel *profileLiveModel;

@property (nonatomic, strong) NSMutableArray *cellDataArray;


//@property (nonatomic, strong, readonly) HXProfileModel *profileModel;

- (instancetype)initWithUID:(NSString *)uid;

@end
