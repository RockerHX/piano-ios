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
#import "MIAFontManage.h"
#import "NSString+JOExtend.h"

CGFloat const kAlbumSongCellHeight = 50.;//歌曲的cell的高度
CGFloat const kAlbumBarViewHeight = 50.;//头部Bar的高度
CGFloat const kAlbumEnterCommentViewHeight = 55.;//底部输入评论的框的高度
CGFloat const kAlbumComentCellDefaultHeight = 70.;//默认的评论的cell的高度
NSInteger const kAlbumCommentLimitCount = 10;

@interface MIAAlbumViewModel(){

    CGFloat albumDetailViewHeight;
}

@property (nonatomic, strong) MIAAlbumDetailModel *albumDetailModel;

@property (nonatomic, copy) NSString *albumComment;
@property (nonatomic, copy) NSString *albumID;
@property (nonatomic, copy) NSString *commentID;
@property (nonatomic, strong) RACCommand *sendCommentCommand;
@property (nonatomic, strong) RACCommand *getCommentListCommand;

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
    [self sendAlbumCommentCommand];
    [self fetchAlbumCommentCommand];
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

- (void)sendAlbumCommentCommand{

    @weakify(self);
    self.sendCommentCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [self sendCommentDataRequestWithSubscriber:subscriber];
            return nil;
        }];
    }];
}

- (void)fetchAlbumCommentCommand{

    @weakify(self);
    self.getCommentListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [self fetchCommandListDataRequestWithSubscriber:subscriber];
            return nil;
        }];
    }];
}

#pragma mark - Data operation

- (void)fetchAlbumDataRequestWithSubscriber:(id<RACSubscriber>)subscriber{

    [MiaAPIHelper getAlbumWithID:_uid
                   completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                       
                       if (success) {
//                           NSLog(@"专辑页面数据:%@",userInfo[MiaAPIKey_Values][MiaAPIKey_Data]);
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

- (void)sendCommentDataRequestWithSubscriber:(id<RACSubscriber>)subscriber{

    [MiaAPIHelper postAlbumComment:_albumID
                           content:_albumComment
                         commentID:_commentID
                     completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                     
                         if (success) {
                             [subscriber sendCompleted];
                         }else{
                             
                             [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
                         }
                         
                     } timeoutBlock:^(MiaRequestItem *requestItem) {
                         [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
                     }];
}

- (void)fetchCommandListDataRequestWithSubscriber:(id<RACSubscriber>)subscriber{

    [MiaAPIHelper getAlbumComment:_albumID
                    lastCommentID:_commentID
                            limit:kAlbumCommentLimitCount
                    completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                        
                        if (success) {
//                            NSLog(@"评论的数据:%@",userInfo[MiaAPIKey_Values][MiaAPIKey_Data]);
                            [self parseAlbumCommentListWithData:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
                            [subscriber sendCompleted];
                        }else{
                            
                            [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
                        }
                        
                    } timeoutBlock:^(MiaRequestItem *requestItem) {
                        [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
                    }];
}

- (RACSignal *)sendCommentWithContent:(NSString *)content albumID:(NSString *)albumID commentID:(NSString *)commentID{

    self.albumComment = nil;
    self.albumComment = content;
    
    self.albumID = nil;
    self.albumID = albumID;
    
    self.commentID = nil;
    self.commentID = JOConvertStringToNormalString(commentID);
    
    return [_sendCommentCommand execute:nil];
}

- (RACSignal *)getCommentListWithAlbumID:(NSString *)albumID lastCommentID:(NSString *)lastCommentID{

    self.albumID = nil;
    self.albumID = albumID;
    
    self.commentID = nil;
    self.commentID = JOConvertStringToNormalString(lastCommentID);
    
    return [_getCommentListCommand execute:nil];
}

//解析拉取专辑的数据
- (void)parseAlbumWithData:(NSDictionary *)data{

    self.albumDetailModel = nil;
    self.albumDetailModel = [MIAAlbumDetailModel mj_objectWithKeyValues:data];
    [self updateCellData];
}

//解析拉取评论的数据
- (void)parseAlbumCommentListWithData:(NSArray *)data{
    
    NSMutableArray *commentArray = [NSMutableArray array];
    for (int i = 0; i < [data count]; i++) {
        MIACommentModel *commentModel = [MIACommentModel mj_objectWithKeyValues:[data objectAtIndex:i]];
        [commentArray addObject:commentModel];
    }
    
    if ([_commentID length]) {
        //存在这个值的时候将是拉取更多评论的操作
        NSMutableArray *finalCommentArray = [NSMutableArray arrayWithArray:_cellDataArray.lastObject];
        [finalCommentArray addObjectsFromArray:commentArray];
        
        if ([_cellDataArray count] == 2) {
            [_cellDataArray removeLastObject];
        }
        [_cellDataArray addObject:[finalCommentArray copy]];
    }else{
        //只是更新评论的数据  是在提交了评论之后需要更新的数据 所以需要将commentCount的值+1的操作
        if ([_cellDataArray count] == 2) {
            [_cellDataArray removeLastObject];
        }
        [_cellDataArray addObject:[commentArray copy]];
        _commentCount ++;
    }
}

- (void)updateCellData{

    [_cellDataArray removeAllObjects];
    
    self.albumModel = nil;
    self.albumModel = _albumDetailModel.album;
    
    _commentCount = [_albumDetailModel.commentsCnt integerValue];
    
    [_cellDataArray addObject:_albumDetailModel.song];
    
    if ([_albumDetailModel.commentList count]) {
        [_cellDataArray addObject:_albumDetailModel.commentList];
    }
}

- (CGFloat)albumDetailViewHeight{

    return albumDetailViewHeight;
}

- (CGFloat)commentCellHeightWithIndex:(NSInteger)index viewWidth:(CGFloat)width{

    if ([_cellDataArray count] > 1 && index < [[_cellDataArray lastObject] count]) {
        //先保证数组是存在的
        MIACommentModel *commentModel = [[_cellDataArray lastObject] objectAtIndex:index];
        
        CGFloat nickHeight,commentHeight,dateHeight;  //名字 评论 时间的高度
        CGFloat commentWidth = width - 2*10 - 2*10 - 40. - 15.;
        
        UILabel *nickNameLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_Comment_Name]];
        [nickNameLabel setText:commentModel.nick];
        nickHeight = [nickNameLabel sizeThatFits:JOMAXSize].height+4.;
        
        UILabel *commentLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_Comment_Content]];
        [commentLabel setNumberOfLines:0];
        [commentLabel setText:commentModel.content];
        commentHeight = [commentLabel sizeThatFits:JOSize(commentWidth, CGFLOAT_MAX)].height+4.;
        
        UILabel *dateLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_Comment_Time]];
        [dateLabel setText:@" "];
        dateHeight = [dateLabel sizeThatFits:JOMAXSize].height;
        
        return nickHeight + commentHeight + dateHeight + 20.;
    }
    
    return 0.;
}

@end
