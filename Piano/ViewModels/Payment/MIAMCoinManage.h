//
//  MIAMCoinManage.h
//  Piano
//
//  Created by 刘维 on 16/5/19.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  操作成功的block
 */
typedef void(^MCoinManageSuccess)();

/**
 *  操作失败的block
 *
 *  @param failed 失败的描述
 */
typedef void(^MCoinManageFailed)(NSString *failed);


@interface MIAMCoinManage : NSObject

+ (MIAMCoinManage *)shareMCoinManage;

- (void)checkLocalVerifyPurchaseWithSuccess:(MCoinManageSuccess)success
                                     failed:(MCoinManageFailed)failed
                               mCoinSuccess:(MCoinManageSuccess)mCoinSuccess
                                mCoinFailed:(MCoinManageFailed)mCoinFailed;

/**
 *  充值M币
 *
 *  @param productIdString  产品的id (服务器给定的id)  用于二次验证
 *  @param purchaseIdString 内购产品的id (苹果那边设置的id)  用于内购
 */
- (void)rechargeMCoinWithProductID:(NSString *)productID
                        purchaseID:(NSString *)purchaseID
                           success:(MCoinManageSuccess)success
                            failed:(MCoinManageFailed)failed
                      mCoinSuccess:(MCoinManageSuccess)mCoinSuccess
                       mCoinFailed:(MCoinManageFailed)mCoinFailed;

/**
 *  打赏专辑
 *
 *  @param mCoinCount 打赏的数量
 */
- (void)rewardAlbumWithMCoin:(NSString *)mCoin
                     albumID:(NSString *)albumID
                      roomID:(NSString *)roomID
                     success:(MCoinManageSuccess)success
                      failed:(MCoinManageFailed)failed
                mCoinSuccess:(MCoinManageSuccess)mCoinSuccess
                 mCoinFailed:(MCoinManageFailed)mCoinFailed;


/**
 *  送礼物
 *
 *  @param giftID 礼物的id
 *  @param roomID 房间的id
 */
- (void)sendGiftWithGiftID:(NSString *)giftID
                    roomID:(NSString *)roomID
                   success:(MCoinManageSuccess)success
                    failed:(MCoinManageFailed)failed
              mCoinSuccess:(MCoinManageSuccess)mCoinSuccess
               mCoinFailed:(MCoinManageFailed)mCoinFailed;

/**
 *  更新M币
 */
- (void)updateMCoinWithMCoinSuccess:(MCoinManageSuccess)mCoinSuccess
                        mCoinFailed:(MCoinManageFailed)mCoinFailed;


/**
 *  获取M币的值
 *
 *  @return M币的数量
 */
- (NSString *)mCoin;

@end
