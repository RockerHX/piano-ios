//
//  HXHostProfileViewModel.h
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "ReactiveCocoa.h"
#import "HXProfileModel.h"


typedef NS_ENUM(NSUInteger, HXHostProfileRowType) {
    HXHostProfileRowTypeRecharge,
    HXHostProfileRowTypePurchaseHistory,
    HXHostProfileRowTypeAttentionPrompt,
    HXHostProfileRowTypeAttentions,
    HXHostProfileRowTypeRewardAlbumPrompt,
    HXHostProfileRowTypeRewardAlbums,
};


@interface HXHostProfileViewModel : NSObject

@property (nonatomic, strong, readonly) RACCommand *fetchCommand;

@property (nonatomic, assign, readonly)   CGFloat  normalHeight;
@property (nonatomic, assign, readonly)   CGFloat  attentionHeight;
@property (nonatomic, assign, readonly)   CGFloat  rewardAlbumHeight;

@property (nonatomic, assign, readonly)   CGFloat  attentionItemSpace;
@property (nonatomic, assign, readonly)   CGFloat  albumItemSpace;
@property (nonatomic, assign, readonly)   CGFloat  attentionItemWidth;
@property (nonatomic, assign, readonly)   CGFloat  albumItemWidth;
@property (nonatomic, assign, readonly)   CGFloat  attetionItemHeight;
@property (nonatomic, assign, readonly)   CGFloat  albumItemHeight;

@property (nonatomic, assign, readonly) NSInteger  rows;
@property (nonatomic, strong, readonly)   NSArray *rowTypes;

@property (nonatomic, strong, readonly) HXProfileModel *model;

@end
