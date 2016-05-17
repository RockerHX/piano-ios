//
//  MIASendGiftModel.h
//  Piano
//
//  Created by 刘维 on 16/5/17.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"

@interface MIASendGiftModel : NSObject

@property (nonatomic, copy) NSString *addtime;//送出的时间
@property (nonatomic, copy) NSString *giftID;  //礼物的ID
@property (nonatomic, copy) NSString *giftName; //礼物的名字
@property (nonatomic, copy) NSString *iconUrl; //礼物图片的URL地址
@property (nonatomic, copy) NSString *id; //
@property (nonatomic, copy) NSString *mcoin; //M币的价格
@property (nonatomic, copy) NSString *musicianID; // 送个的musician的 id
@property (nonatomic, copy) NSString *roomID; //房间的id
@property (nonatomic, copy) NSString *status; //
@property (nonatomic, copy) NSString *uID; //uid

@end
