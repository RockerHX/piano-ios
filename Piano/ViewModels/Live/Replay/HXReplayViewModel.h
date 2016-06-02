//
//  HXReplayViewModel.h
//  Piano
//
//  Created by miaios on 16/4/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "ReactiveCocoa.h"
#import "HXDiscoveryModel.h"
#import "HXBarrageModel.h"


@interface HXReplayViewModel : NSObject

@property (nonatomic, strong, readonly) RACCommand *fetchBarrageCommand;
@property (nonatomic, strong, readonly) RACCommand *checkAttentionStateCommand;
@property (nonatomic, strong, readonly) RACCommand *viewReplayCommand;
@property (nonatomic, strong, readonly) RACCommand *takeAttentionCommand;

@property (nonatomic, strong, readonly) HXDiscoveryModel *model;

@property (nonatomic, assign)                     BOOL  anchorAttented;
@property (nonatomic, assign, readonly) NSTimeInterval  timeNode;

@property (nonatomic, strong, readonly) NSString *anchorAvatar;
@property (nonatomic, strong, readonly) NSString *anchorNickName;
@property (nonatomic, strong, readonly) NSString *viewCount;

@property (nonatomic, strong) NSArray<HXBarrageModel *> *barrages;

- (instancetype)initWithDiscoveryModel:(HXDiscoveryModel *)model;

- (void)updateTimeNode:(NSTimeInterval)node;
- (void)clearBarrages;

@end
