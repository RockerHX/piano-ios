//
//  MIAAlbumViewModel.m
//  Piano
//
//  Created by 刘维 on 16/5/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAAlbumViewModel.h"
#import "MIAAlbumHeadDetailViewModel.h"
#import "MIAAlbumDetailModel.h"

CGFloat const kAlbumSongCellHeight = 50.;//歌曲的cell的高度
CGFloat const kAlbumBarViewHeight = 50.;//头部Bar的高度
CGFloat const kAlbumEnterCommentViewHeight = 55.;//底部输入评论的框的高度

@interface MIAAlbumViewModel(){

    CGFloat albumDetailViewHeight;
}

@property (nonatomic, strong) MIAAlbumDetailModel *albumDetailModel;

@end

@implementation MIAAlbumViewModel

- (instancetype)initWithUid:(NSString *)uid{

    self = [super init];
    if (self) {
        
        _uid = uid;
        [self initConfigure];
    }
    return self;
}

- (void)initConfigure{

    _cellDataArray = [NSMutableArray array];
    [self fetchAlbumDataCommand];
}

- (void)fetchAlbumDataCommand{

    @weakify(self);
    self.fetchCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [self fetchAlbumDataRequestWithSubscriber:subscriber];
            return nil;
        }];
    }];
}

#pragma mark - Data operation

- (void)fetchAlbumDataRequestWithSubscriber:(id<RACSubscriber>)subscriber{

    [MiaAPIHelper getAlbumWithID:_uid
                   completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                       
                       if (success) {
                           NSLog(@"专辑页面数据:%@",userInfo[MiaAPIKey_Values][MiaAPIKey_Data]);
                           [self parseAlbumWithData:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
                           [subscriber sendCompleted];
                       }else{
                       
                           [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
                       }
                   }
                    timeoutBlock:^(MiaRequestItem *requestItem) {
                       [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
                    }];
}

- (void)parseAlbumWithData:(NSDictionary *)data{

    self.albumDetailModel = nil;
    self.albumDetailModel = [MIAAlbumDetailModel mj_objectWithKeyValues:data];
    [self updateCellData];
}

- (void)updateCellData{

    [_cellDataArray removeAllObjects];
    
    self.albumModel = nil;
    self.albumModel = _albumDetailModel.album;
    
    [_cellDataArray addObject:_albumDetailModel.song];
    
    if ([_albumDetailModel.commentList count]) {
        [_cellDataArray addObject:_albumDetailModel.commentList];
    }
}

- (CGFloat)albumDetailViewHeight{

    return albumDetailViewHeight;
}

@end
