//
//  MIAAlbumRewardViewModel.m
//  Piano
//
//  Created by 刘维 on 16/5/13.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAAlbumRewardViewModel.h"

CGFloat const kAlbumRewardPopButtonHeight = 31.;; //pop按钮的大小
CGFloat const kAlbumRewardTopSpaceDistance = 28.; //top的是间距大小
CGFloat const kAlbumRewardLeftSpaceDistance = 10.; //左边的间距大小
CGFloat const kAlbumRewardRightSpaceDistance = 16.; //右边的间距大小
CGFloat const kAlbumRewardBottomSpaceDistance = 27.; //底部的间距大小

CGFloat const kButtonToAlbumInfoViewSpaceDistance = 24.; //pop按钮到专辑信息视图的间距
CGFloat const kAlbumInfoViewHeight = 150.; //专辑信息视图的高度
CGFloat const kAlbumInfoImageViewWidth = 116.;//专辑信息视图中图片的宽度.
CGFloat const kAlbumInfoImageToAlbumNameSpaceDistance = 16.;//图片与专辑名的间距大小
CGFloat const kAlbumInfoAlbumNameToSingerNameSpaceDistance = 9.;//专辑名与歌唱者的间距大小
CGFloat const kAlbumInfoViewToTipSpaceDistance = 20.; //间距视图到提示语的间距
CGFloat const kRewardViewToRewardButtonSpaceDistance = 10.; //打赏的金额调节视图到打赏按钮的间距
CGFloat const kRewardButtonHeight = 45.; //打赏按钮的高度
CGFloat const kRewardButtonWidth = 154.; //打赏按钮的宽度
CGFloat const kRewardButtonToAccountViewSpaceDistance = 45.; //打赏按钮与账户余额的间距大小
CGFloat const kRechargeButtonWidth = 60.; //充值按钮的宽度

@interface MIAAlbumRewardViewModel()


@end

@implementation MIAAlbumRewardViewModel

- (void)initConfigure{

    
}

- (void)fetchBalanceDataCommand{

    @weakify(self);
    self.fetchCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           
            [self fetchBalanceDataWithRequestWith:subscriber];
            return nil;
        }];
    }];
}

#pragma mark - Data operation

- (void)fetchBalanceDataWithRequestWith:(id<RACSubscriber>)subscriber{

}

@end
