//
//  MIAProfileViewModel.m
//  Piano
//
//  Created by 刘维 on 16/5/9.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAProfileViewModel.h"
#import "MIAProfileModel.h"

CGFloat const kProfileLiveCellHeight = 100.;
CGFloat const kProfileAlbumCellHeight = 150.;
CGFloat const kProfileVideoCellHeight = 140.;
CGFloat const kProfileReplayCellHeight = 210.;

@implementation MIAProfileHeadModel
@end

@implementation MIAProfileLiveModel
@end

@interface MIAProfileViewModel()

@property (nonatomic, strong) MIAProfileModel *profileModel;

@end

@implementation MIAProfileViewModel

- (instancetype)initWithUID:(NSString *)uid{

    self = [super init];
    if (self) {
        _uid = uid;
        [self initConfigure];
    }
    return self;
}

- (void)initConfigure{

    _sections = 0;
    _cellTypes = [NSMutableArray array];
    self.cellDataArray = [NSMutableArray array];
    self.profileHeadModel = [MIAProfileHeadModel new];
    self.profileLiveModel = [MIAProfileLiveModel new];
    
    [self fetchProfileDataCommand];
    [self attentionOperationCommand];
}

- (void)fetchProfileDataCommand{

    @weakify(self);
    self.fetchCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           
            [self fetchProfileRequestWithSubscriber:subscriber];
            return nil;
        }];
    }];
}

- (void)attentionOperationCommand{

    _attentionCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [self attentionRequestWithSubscriber:subscriber];
            return nil;
        }];
    }];
    
    _unAttentionCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
       
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           
            [self unAttentionRequestWithSubscriber:subscriber];
            return nil;
        }];
    }];
}

#pragma mark - Data Operation

- (void)attentionRequestWithSubscriber:(id<RACSubscriber>)subscriber{
    
    [MiaAPIHelper followWithUID:_uid
                  completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                  
                      if (success) {
                          
                          [subscriber sendNext:@(YES)];
                          [subscriber sendCompleted];
                      }else{
                         
                          [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
                      }
                  }
                   timeoutBlock:^(MiaRequestItem *requestItem) {
                       [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
                   }];
}

- (void)unAttentionRequestWithSubscriber:(id<RACSubscriber>)subscriber{

    [MiaAPIHelper unfollowWithUID:_uid
                    completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                        
                        if (success) {
                            
                            [subscriber sendNext:@(NO)];
                            [subscriber sendCompleted];
                        }else{
                            
                            [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
                        }
                        
                    } timeoutBlock:^(MiaRequestItem *requestItem) {
                        [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
                    }];
}

- (void)fetchProfileRequestWithSubscriber:(id<RACSubscriber>)subscriber{

    [MiaAPIHelper getMusicianProfileWithUID:_uid
                              completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        
                                    if (success) {
                                        
//                                        NSLog(@"^^^^^^^^^^^^^^^^:%@",userInfo[MiaAPIKey_Values][MiaAPIKey_Data]);
                                        [self parseProfileWithData:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
                                        [subscriber sendCompleted];
                                    }else{
                                    
                                        [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
                                    }
                                }
                               timeoutBlock:^(MiaRequestItem *requestItem) {
                                   [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
    }];
}

- (void)parseProfileWithData:(NSDictionary *)data{

    self.profileModel = [MIAProfileModel mj_objectWithKeyValues:data];
    [self updateCellData];
}

- (void)updateHeadModelData{

    _profileHeadModel.uid = _profileModel.uID;
    _profileHeadModel.nickName = _profileModel.nick;
    _profileHeadModel.gender = _profileModel.gender;
    _profileHeadModel.summary = _profileModel.bio;
    _profileHeadModel.followState = _profileModel.follow;
    _profileHeadModel.avatarURL = _profileModel.coverUrl;
    _profileHeadModel.fansCount = _profileModel.fansCnt;
    _profileHeadModel.followState = _profileModel.followCnt;
    _profileHeadModel.userpic = _profileModel.userpic;
}

- (void)updateLiveModelData{

    _profileLiveModel.liveState = _profileModel.live;
    _profileLiveModel.nickName = _profileModel.nick;
    _profileLiveModel.liveViewCount = _profileModel.liveViewCnt;
    _profileLiveModel.liveOnlineCount = _profileModel.liveOnlineCnt;
    _profileLiveModel.liveRoomID = _profileModel.liveRoomID;
    _profileLiveModel.liveTitle = _profileModel.liveTitle;
    _profileLiveModel.liveCoverURL = _profileModel.liveRoomCoverUrl;
}

- (void)updateCellData{

    _sections = 0;
    [_cellTypes removeAllObjects];
    [_cellDataArray removeAllObjects];
    
    [self updateHeadModelData];
    
    if (_profileModel.liveRoomID && [_profileModel.live boolValue]) {
        [self updateLiveModelData];
        [_cellTypes addObject:@(MIAProfileCellTypeLive)];
        [_cellDataArray addObject:@[_profileLiveModel]];
    }
    if (_profileModel.musicAlbum.count) {
        [_cellTypes addObject:@(MIAProfileCellTypeAlbum)];
        [_cellDataArray addObject:[_profileModel.musicAlbum JOSeparateArrayWithNumber:3]];
    }
    if (_profileModel.video.count) {
        [_cellTypes addObject:@(MIAProfileCellTypeVideo)];
        [_cellDataArray addObject:[_profileModel.video JOSeparateArrayWithNumber:2]];
    }
    if (_profileModel.replay.count) {
        [_cellTypes addObject:@(MIAProfileCellTypeReplay)];
        [_cellDataArray addObject:[_profileModel.replay JOSeparateArrayWithNumber:2]];
    }
    
     _sections = [_cellTypes count];
}

@end
