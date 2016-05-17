//
//  MIAPayHistoryViewModel.h
//  Piano
//
//  Created by 刘维 on 16/5/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAViewModel.h"

UIKIT_EXTERN CGFloat const kPayHistoryItemViewHeight; //item的高度
UIKIT_EXTERN CGFloat const kPayHistoryCellHeight; //Cell的高度
UIKIT_EXTERN CGFloat const kPayHistoryCellHeadHeight; //头部的高度

@interface MIAPayHistoryViewModel : MIAViewModel

@property (nonatomic, strong) RACCommand *fetchOrderListCommand;//这个为充值记录的列表拉取 ps:基类的fetchCommand用做送出礼物列表的拉取

@property (nonatomic, strong, readonly) NSMutableArray *sendGiftLsitArray;//送出的礼物的列表
@property (nonatomic, strong, readonly) NSMutableArray *orderListArray; //充值的列表

@end
