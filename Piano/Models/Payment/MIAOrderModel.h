//
//  MIAOrderModel.h
//  Piano
//
//  Created by 刘维 on 16/5/17.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"

@interface MIAOrderModel : NSObject

@property (nonatomic, copy) NSString *amount;  //充值的金额
@property (nonatomic, copy) NSString *body; //增加的M币
@property (nonatomic, copy) NSString *createdTime; //充值的时间
@property (nonatomic, copy) NSString *payType;//1为应用里的微信支付 3微信扫码支付, 5为ios支付, 4支付宝
@property (nonatomic, copy) NSString *id;

@end
