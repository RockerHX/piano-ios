//
//  MIAMCoinManage.m
//  Piano
//
//  Created by 刘维 on 16/5/19.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAMCoinManage.h"
#import "MIAMCoinModel.h"
#import "MiaAPIHelper.h"
#import "JOBaseSDK.h"

static NSString *const kVerifyPurchaseCacheKey = @"kVerifyPurchaseCacheKey";
static NSString *const kVerifyPurchaseTransactionIDKey = @"TransactionIDKey";
static NSString *const kVerifyPuurchaseProductIDKey = @"ProductIDKey";
static NSString *const kVerifyPurchaseVerifyKey = @"VerifyKey";

@interface MIAMCoinManage()

@property (nonatomic, copy) NSString *mCoinBalance;

@property (nonatomic, copy) NSString *productID;
@property (nonatomic, copy) NSString *transactionID;

@property (nonatomic, copy) MCoinManageSuccess success;
@property (nonatomic, copy) MCoinManageFailed failed;

@property (nonatomic, copy) MCoinManageSuccess mCoinSuccess;
@property (nonatomic, copy) MCoinManageFailed mCoinFailed;

@end

@implementation MIAMCoinManage

+ (MIAMCoinManage *)shareMCoinManage{

    static MIAMCoinManage * mCoinManage;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        mCoinManage = [[self alloc] init];
    });
    return mCoinManage;
}

- (instancetype)init{

    self = [super init];
    if (self) {
        
        if (![[NSUserDefaults standardUserDefaults] objectForKey:kVerifyPurchaseCacheKey]) {
            //第一次初始化的时候
            NSMutableArray *verifyPurchaseArray = [NSMutableArray array];
            NSData *verifyPurchaseData = [NSKeyedArchiver archivedDataWithRootObject:verifyPurchaseArray];
            [[NSUserDefaults standardUserDefaults] setValue:verifyPurchaseData forKey:kVerifyPurchaseCacheKey];
        }
        
        self.mCoinBalance = nil;
        self.mCoinBalance = @"0";
        
        [self updateMCoin];
    }
    return self;
}

- (void)setSuccess:(MCoinManageSuccess)success failed:(MCoinManageFailed)failed{

    self.success = nil;
    self.success = success;
    
    self.failed = nil;
    self.failed = failed;
}

- (void)setMCoinSuccess:(MCoinManageSuccess)mCoinSuccess mCoinFailed:(MCoinManageFailed)mCoinFailed{

    self.mCoinSuccess = nil;
    self.mCoinSuccess = mCoinSuccess;
    
    self.mCoinFailed = nil;
    self.mCoinFailed = mCoinFailed;
}

- (void)successHandler{

    if (_success) {
        _success();
        
        self.success = nil;
    }
}

- (void)failedHandlerWithReason:(NSString *)reason{

    if (_failed) {
        _failed(reason);
        
        self.failed = nil;
    }
}

- (void)mCoinSuccessHandler{

    if (_mCoinSuccess) {
        _mCoinSuccess();
        
        self.mCoinSuccess = nil;
    }
}

- (void)mCoinFailedHandlerWithReason:(NSString *)reason{

    if (_mCoinFailed) {
        _mCoinFailed(reason);
        
        self.mCoinFailed = nil;
    }
}

- (void)checkLocalVerifyPurchaseWithSuccess:(MCoinManageSuccess)success
                                     failed:(MCoinManageFailed)failed
                               mCoinSuccess:(MCoinManageSuccess)mCoinSuccess
                                mCoinFailed:(MCoinManageFailed)mCoinFailed{
    
    [self setSuccess:success failed:failed];
    [self setMCoinSuccess:mCoinSuccess mCoinFailed:mCoinFailed];

    NSMutableArray *localVerifyPurchaseArray = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:kVerifyPurchaseCacheKey]];
    
    for (int i = 0; i < [localVerifyPurchaseArray count]; i++) {
        //将本地存放的还未到服务器验证的的数据发送到服务器验证
        NSDictionary *dic = [localVerifyPurchaseArray objectAtIndex:i];
        [self verifyPurchaseWithProductID:[dic objectForKey:kVerifyPuurchaseProductIDKey]
                            transactionID:[dic objectForKey:kVerifyPurchaseTransactionIDKey]
                             verifyString:[dic objectForKey:kVerifyPurchaseVerifyKey]];
    }
}

- (void)addVerifyPurchaseToLocalWithProductID:(NSString *)productID transactionID:(NSString *)transactionID verifyString:(NSString *)verifyString{

    NSDictionary *dic = @{kVerifyPuurchaseProductIDKey:productID,kVerifyPurchaseTransactionIDKey:transactionID, kVerifyPurchaseVerifyKey:verifyString};
    NSMutableArray *localVerifyPurchaseArray = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:kVerifyPurchaseCacheKey]];
    
    if (![localVerifyPurchaseArray containsObject:dic]) {
     
        [localVerifyPurchaseArray addObject:dic];
    }
    
    NSData *verifyPurchaseData = [NSKeyedArchiver archivedDataWithRootObject:localVerifyPurchaseArray];
    [[NSUserDefaults standardUserDefaults] setValue:verifyPurchaseData forKey:kVerifyPurchaseCacheKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)removeLocalVerifyPurchaseWithTransactionID:(NSString *)transactionID{

    NSMutableArray *localVerifyPurchaseArray = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:kVerifyPurchaseCacheKey]];
    for (NSDictionary *dic in localVerifyPurchaseArray) {
        
        if ([[dic objectForKey:kVerifyPurchaseTransactionIDKey] isEqualToString:transactionID]) {
            [localVerifyPurchaseArray removeObject:dic];
            break;
        }
    }
    NSData *verifyPurchaseData = [NSKeyedArchiver archivedDataWithRootObject:localVerifyPurchaseArray];
    [[NSUserDefaults standardUserDefaults] setValue:verifyPurchaseData forKey:kVerifyPurchaseCacheKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)rechargeMCoinWithProductID:(NSString *)productID
                        purchaseID:(NSString *)purchaseID
                           success:(MCoinManageSuccess)success
                            failed:(MCoinManageFailed)failed
                      mCoinSuccess:(MCoinManageSuccess)mCoinSuccess
                       mCoinFailed:(MCoinManageFailed)mCoinFailed{

    self.productID = nil;
    self.productID = productID;
    
    [self setSuccess:success failed:failed];
    [self setMCoinSuccess:mCoinSuccess mCoinFailed:mCoinFailed];
    
    [[JOPurchaseManage sharePurchaseManage] purchaseWithProductID:purchaseID
                                                   successHanlder:^(NSString *productID, NSString *transactionID, NSString *verifyString) {
                                                   
                                                       //苹果返回支付结果后 需要将结果存放起来 只有在自己的服务器验证完之后才能删除
                                                       [self addVerifyPurchaseToLocalWithProductID:_productID
                                                                                     transactionID:transactionID
                                                                                      verifyString:verifyString];
                                                       
                                                       [self verifyPurchaseWithProductID:_productID
                                                                           transactionID:transactionID
                                                                            verifyString:verifyString];
                                                       
                                                   }
                                                    failedHanlder:^(NSString *failed) {
                                                    
                                                        [self failedHandlerWithReason:failed];
                                                    }];
}


- (void)rewardAlbumWithMCoin:(NSString *)mCoin
                     albumID:(NSString *)albumID
                      roomID:(NSString *)roomID
                     success:(MCoinManageSuccess)success
                      failed:(MCoinManageFailed)failed
                mCoinSuccess:(MCoinManageSuccess)mCoinSuccess
                 mCoinFailed:(MCoinManageFailed)mCoinFailed{
    
    [self setSuccess:success failed:failed];
    [self setMCoinSuccess:mCoinSuccess mCoinFailed:mCoinFailed];

    [MiaAPIHelper rewardAlbumWithAlbumID:albumID
                                  roomID:roomID
                                   mCoin:mCoin
                           completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
//                               JOLog(@"打赏专辑userInfo:%@",userInfo);
                               if (success) {
                                   
                                   [self successHandler];
                                   [self updateMCoin];
                               }else{
                               
                                   [self failedHandlerWithReason:userInfo[MiaAPIKey_Values][MiaAPIKey_Error]];
                               }
                            
                           } timeoutBlock:^(MiaRequestItem *requestItem) {
                               
                               [self failedHandlerWithReason:TimtOutPrompt];
                           }];
}

- (void)sendGiftWithGiftID:(NSString *)giftID
                 giftCount:(NSString *)giftCount
                    roomID:(NSString *)roomID
                   success:(MCoinManageSuccess)success
                    failed:(MCoinManageFailed)failed
              mCoinSuccess:(MCoinManageSuccess)mCoinSuccess
               mCoinFailed:(MCoinManageFailed)mCoinFailed{
    
    [self setSuccess:success failed:failed];
    [self setMCoinSuccess:mCoinSuccess mCoinFailed:mCoinFailed];

    [MiaAPIHelper sendGiftWithGiftID:giftID
                           giftCount:giftCount
                              roomID:roomID
                       completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                       
                            JOLog(@"送礼物userInfo:%@",userInfo);
                           if (success) {
                               [self successHandler];
                               [self updateMCoin];
                           }else{
                           
                               [self failedHandlerWithReason:userInfo[MiaAPIKey_Values][MiaAPIKey_Error]];
                           }
                           
                       } timeoutBlock:^(MiaRequestItem *requestItem) {
                       
                           [self failedHandlerWithReason:TimtOutPrompt];
                       }];
}

- (void)updateMCoin{

    [self fetchMCoinBalance];
}

- (void)updateMCoinWithMCoinSuccess:(MCoinManageSuccess)mCoinSuccess
                        mCoinFailed:(MCoinManageFailed)mCoinFailed{
    
    [self setMCoinSuccess:mCoinSuccess mCoinFailed:mCoinFailed];
    [self updateMCoin];
}

- (NSString *)mCoin{
    
    return _mCoinBalance;
}

#pragma mark - M coin operation

- (void)fetchMCoinBalance{

    [MiaAPIHelper getMCoinBalancesWithCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        
        if (success) {
            
            [self parseMCoinBalanceWithData:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
            [self mCoinSuccessHandler];
        }else{
            
            [self mCoinFailedHandlerWithReason:userInfo[MiaAPIKey_Values][MiaAPIKey_Error]];
        }
        
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        
        [self mCoinFailedHandlerWithReason:TimtOutPrompt];
    }];
}

- (void)verifyPurchaseWithProductID:(NSString *)productID transactionID:(NSString *)transactionID verifyString:(NSString *)verifyString{

    
    [MiaAPIHelper verifyPurchaseWithRechargeID:productID
                                       orderID:transactionID
                                          auth:verifyString
                                 completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                                     
                                     if (success) {
                                         
                                         if ([userInfo[MiaAPIKey_Values][MiaAPIKey_Return] integerValue] == 0) {
                                             //验证成功
                                             [self updateMCoin];
                                             [self successHandler];
                                         }else{
                                             //验证失败
                                             [self failedHandlerWithReason:@"充值验证结果失败"];
                                         }
                                     }else{
                                         
                                         [self failedHandlerWithReason:userInfo[MiaAPIKey_Values][MiaAPIKey_Error]];
                                     }
                                     //服务器验证完之后 需要删除本地的数据
                                     [self removeLocalVerifyPurchaseWithTransactionID:transactionID];
                                 } timeoutBlock:^(MiaRequestItem *requestItem) {
                                     
                                     [self failedHandlerWithReason:TimtOutPrompt];
                                 }];
}

#pragma mark - data

- (void)parseMCoinBalanceWithData:(NSDictionary *)dic{

    MIAMCoinModel *mCoinModel = [MIAMCoinModel mj_objectWithKeyValues:dic];
    
    self.mCoinBalance = nil;
    self.mCoinBalance = [mCoinModel.mcoinApple copy];
}

@end
