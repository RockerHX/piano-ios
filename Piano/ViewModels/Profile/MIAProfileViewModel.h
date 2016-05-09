//
//  MIAProfileViewModel.h
//  Piano
//
//  Created by 刘维 on 16/5/9.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAViewModel.h"
#import "HXProfileModel.h"

UIKIT_EXTERN CGFloat const kProfileHeadViewHeight;

UIKIT_EXTERN CGFloat const kProfileLiveCellHeight;
UIKIT_EXTERN CGFloat const kProfileAlbumCellHeight;
UIKIT_EXTERN CGFloat const kProfileVideoCellHeight;

typedef NS_ENUM(NSUInteger, MIAProfileCellType) {

    MIAProfileCellTypeLive, // 正在直播
    MIAProfileCellTypeAlbum, //专辑
    MIAProfileCellTypeVideo, //视频
    MIAProfileCellTypeReplay, //直播回放
};

@interface MIAProfileViewModel : MIAViewModel

@property (nonatomic, assign, readonly) NSInteger sections;
@property (nonatomic, copy, readonly) NSArray *cellTypes;

@property (nonatomic, copy, readonly) NSString *uid;

@property (nonatomic, strong, readonly) HXProfileModel *model;

- (instancetype)initWithUID:(NSString *)uid;

@end
