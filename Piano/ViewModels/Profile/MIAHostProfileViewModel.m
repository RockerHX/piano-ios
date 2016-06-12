//
//  MIAHostProfileViewModel.m
//  Piano
//
//  Created by 刘维 on 16/6/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAHostProfileViewModel.h"
#import "HXUserSession.h"

CGFloat const kHostProfileViewHeadHeight = 360.; //头部的高度.
CGFloat const kHostProfiltViewHeadImageWidth = 200.; //头部视图中图片的宽度.
CGFloat const kHostProfileViewDefaultCellHeight = 58.;//默认的cell的高度

@interface MIAHostProfileViewModel()

@end

@implementation MIAHostProfileViewModel

- (void)initConfigure{

    [self fetchHostProfileDataCommand];
}

- (void)fetchHostProfileDataCommand{

    @weakify(self);
    self.fetchCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           
            [self hostProfileRequestWithSubscriber:subscriber];
            return nil;
        }];
    }];
}

#pragma mark - Data Operation

- (void)hostProfileRequestWithSubscriber:(id<RACSubscriber>)subscriber{

    [MiaAPIHelper getUserProfileWithUID:[HXUserSession session].uid
                          completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                          
                              if (success) {
                                  [self parseHostProfileWithData:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
                                  [subscriber sendCompleted];
                              } else {
                                  [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
                              }
                              
                          } timeoutBlock:^(MiaRequestItem *requestItem) {
                          
                              [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
                          }];
}


- (void)parseHostProfileWithData:(NSDictionary *)data{

    
}

#pragma mark - cell height

+ (CGFloat)hostProfileAttentionCellHeightWitWidth:(CGFloat)width{

    return 10.;
}

+ (CGFloat)hostProfileRewardAlbumCellHeightWithWidth:(CGFloat)width{

    return 20.;
}

@end
