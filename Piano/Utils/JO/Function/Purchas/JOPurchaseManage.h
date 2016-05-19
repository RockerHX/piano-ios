//
//  JOPurchasManage.h
//  Piano
//
//  Created by 刘维 on 16/5/18.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "JOFunctionObject.h"

/**
 *  购买成功的Block回调.
 *
 *  @param productID     苹果那边设置的产品的id.
 *  @param transactionID 订单号
 *  @param verifyString  用来做二次验证的Base64字符串
 */
typedef void(^PurchaseSuccessBlock) (NSString * productID, NSString *transactionID ,NSString *verifyString);

/**
 *  购买不成功的Block回调
 *
 *  @param failed 失败的说明.
 */
typedef void(^PurchaseFailedBlock) (NSString *failed);

@interface JOPurchaseManage : JOFunctionObject

+ (JOPurchaseManage *)sharePurchaseManage;

- (void)purchaseWithProductID:(NSString *)productId
               successHanlder:(PurchaseSuccessBlock)success
                failedHanlder:(PurchaseFailedBlock)failed;

@end
