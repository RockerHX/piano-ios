//
//  MIAHostProfileViewModel.m
//  Piano
//
//  Created by 刘维 on 16/6/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAHostProfileViewModel.h"
#import "JOBaseSDK.h"
#import "MIAFontManage.h"
#import "HXUserSession.h"

#import "MIAHostAttentionCell.h"
#import "MIAHostAttentionView.h"
#import "MIAHostRewardAlbumCell.h"
#import "MIAHostRewardAlbumView.h"

CGFloat const kHostProfileViewHeadLeftSpaceDistance = 84.;//头像与左边的间距大小
CGFloat const kHostProfileViewHeadRightSpaceDistance = 84.;//头像与右边的间距大小
CGFloat const kHostProfileViewHeadTopSpaceDistance = 58.;//头像与头部的间距大小.
CGFloat const kHostProfileViewDefaultCellHeight = 58.;//默认的cell的高度

@interface MIAHostProfileViewModel()

@property (nonatomic, strong) id<RACSubscriber> viewUpdateSubscriber;

@end

@implementation MIAHostProfileViewModel

- (void)initConfigure{
    
    _hostProfileDataArray = [NSMutableArray array];
    
    @weakify(self);
    _viewUpdateSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    @strongify(self);
        self.viewUpdateSubscriber = subscriber;
        return nil;
    }];
    [self fetchHostProfileDataCommand];
}

- (void)fetchHostProfileDataCommand{

    @weakify(self);
    self.fetchCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           
            [self hostProfileRequest];
            return nil;
        }];
    }];
}

#pragma mark - Data Operation

- (void)hostProfileRequest{

    [MiaAPIHelper getUserProfileWithUID:[HXUserSession session].uid
                          completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                          
                              if (success) {
                                  [self parseHostProfileWithData:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
                                  [_viewUpdateSubscriber sendCompleted];
                              } else {
                                  [_viewUpdateSubscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
                              }
                              
                          } timeoutBlock:^(MiaRequestItem *requestItem) {
                          
                              [_viewUpdateSubscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
                          }];
}


- (void)parseHostProfileWithData:(NSDictionary *)data{

    _hostProfileModel = [MIAHostProfileModel mj_objectWithKeyValues:data];
    
    [_hostProfileDataArray removeAllObjects];
    
    if([[HXUserSession session] role] == HXUserRoleAnchor){
    
        [_hostProfileDataArray addObject:@[@"我的M币(充值)",@"我的购买记录"]];//,@"我的收益"
    }else{
        [_hostProfileDataArray addObject:@[@"我的M币(充值)",@"我的购买记录"]];
    }
    
    if ([_hostProfileModel.followList count]) {
        [_hostProfileDataArray addObject:[_hostProfileModel.followList JOSeparateArrayWithNumber:4]];
    }else{
        [_hostProfileDataArray addObject:@"还没有关注的人"];
    }
    if ([_hostProfileModel.musicAlbum count]) {
        [_hostProfileDataArray addObject:[_hostProfileModel.musicAlbum JOSeparateArrayWithNumber:3]];
    }else{
        [_hostProfileDataArray addObject:@"还没有打赏的专辑"];
    }
}

#pragma mark - cell height

+ (CGFloat)hostProfileAttentionCellHeightWitWidth:(CGFloat)width topState:(BOOL)state{

    CGFloat viewWidth = (width - kContentViewRightSpaceDistance -kContentViewLeftSpaceDistance -kContentViewInsideLeftSpaceDistance - kContentViewInsideRightSpaceDistance - 3*kAttentionViewItemSpaceDistance)/4.;
    
    UILabel *label1 = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Host_Attention_Title]];
    [label1 setText:@" "];
    CGFloat height1 = [label1 sizeThatFits:JOMAXSize].height;
    
    if (state) {
        return viewWidth + kAttentionImageToTitleSpaceDistance+ height1 + 5. + kContentViewInsideBottomSpaceDistance*2;
    }
    return viewWidth + kAttentionImageToTitleSpaceDistance+ height1 + kContentViewInsideTopSpaceDistance*2 + kContentViewInsideBottomSpaceDistance*2;
}

+ (CGFloat)hostProfileRewardAlbumCellHeightWithWidth:(CGFloat)width{

    CGFloat viewWidth = (width - kContentViewRightSpaceDistance -kContentViewLeftSpaceDistance -kContentViewInsideLeftSpaceDistance - kContentViewInsideRightSpaceDistance - 2*kHostProfileAlbumItemSpaceDistance)/3.;
    
    UILabel *label1 = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Host_Album_Name]];
    [label1 setText:@" "];
    CGFloat height1 = [label1 sizeThatFits:JOMAXSize].height;
    
    return viewWidth + kRewardAlbumImageToTitleDistanceSpace + height1 + kContentViewInsideTopSpaceDistance + kContentViewInsideBottomSpaceDistance;
}

@end
