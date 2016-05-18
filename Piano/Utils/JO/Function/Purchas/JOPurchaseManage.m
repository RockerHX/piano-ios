//
//  JOPurchasManage.m
//  Piano
//
//  Created by 刘维 on 16/5/18.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "JOPurchaseManage.h"
#import <StoreKit/StoreKit.h>

@interface JOPurchaseManage()<SKPaymentTransactionObserver,SKProductsRequestDelegate>

@property (nonatomic, copy) PurchaseSuccessBlock purchaseSuccessBlock;
@property (nonatomic, copy) PurchaseFailedBlock purchaseFailedBlock;

@property (nonatomic, copy) NSString *productID;

@end

@implementation JOPurchaseManage

+ (JOPurchaseManage *)sharePurchaseManage{

    static JOPurchaseManage *purchaseManage;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        purchaseManage = [[self alloc] init];
    });
    return purchaseManage;
    
}

- (void)purchaseWithProductID:(NSString *)productId
               successHanlder:(PurchaseSuccessBlock)success
                failedHanlder:(PurchaseFailedBlock)failed{
    
    self.purchaseSuccessBlock = nil;
    self.purchaseSuccessBlock = success;
    
    self.purchaseFailedBlock = nil;
    self.purchaseFailedBlock = failed;
    
    self.productID = nil;
    self.productID = productId;
    
    if([SKPaymentQueue canMakePayments]){
        [self verifyProductID:productId];
    }else{
        
        if (_purchaseFailedBlock) {
            _purchaseFailedBlock(@"不允许程序内付费");
        }
        NSLog(@"不允许程序内付费");
    }
}

//- (void)faildPurchaseWithReason:(NSString *)

- (void)verifyProductID:(NSString *)productId{

    NSArray *product = [[NSArray alloc] initWithObjects:productId,nil];
    
    NSSet *nsset = [NSSet setWithArray:product];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate = self;
    [request start];
}

#pragma mark - product request delegate

//收到产品返回信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    NSLog(@"--------------收到产品反馈消息---------------------");
    NSArray *product = response.products;
    if([product count] == 0){
        NSLog(@"--------------没有商品------------------");
        if (_purchaseFailedBlock) {
            _purchaseFailedBlock(@"商品不存在");
        }
        return;
    }
    
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量:%lu",(unsigned long)[product count]);
    
    SKProduct *p = nil;
    for (SKProduct *pro in product) {
        NSLog(@"%@", [pro description]);
        NSLog(@"%@", [pro localizedTitle]);
        NSLog(@"%@", [pro localizedDescription]);
        NSLog(@"%@", [pro price]);
        NSLog(@"%@", [pro productIdentifier]);
        
        if([pro.productIdentifier isEqualToString:_productID]){
            p = pro;
        }
        
        NSLog(@"p:%@",p);
    }
    
    
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    SKPayment *payment = [SKPayment paymentWithProduct:p];
    
    NSLog(@"发送购买请求");
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    //    [SVProgressHUD showErrorWithStatus:@"支付失败"];
    NSLog(@"------------------错误-----------------:%@", error);
}

- (void)requestDidFinish:(SKRequest *)request{
    //    [SVProgressHUD dismiss];
    NSLog(@"------------反馈信息结束-----------------");
}

#pragma mark - 交易结果

//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction{
    
    
    for(SKPaymentTransaction *tran in transaction){
        
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:{
                NSLog(@"交易完成");
//                [self verifyPurchaseWithPaymentTransaction];
                
                NSURL *receiptUrl=[[NSBundle mainBundle] appStoreReceiptURL];
                NSData *receiptData=[NSData dataWithContentsOfURL:receiptUrl];
                NSString *receiptString=[receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];//转化为base64字符串
                
                if (_purchaseSuccessBlock) {
                    _purchaseSuccessBlock(tran.payment.productIdentifier, tran.transactionIdentifier, receiptString);
                }
                
                [self purchaseFinishTransaction:tran];
//                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
            }
                
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加进列表");
                
                break;
            case SKPaymentTransactionStateRestored:{
                NSLog(@"已经购买过商品");
                
                if (_purchaseFailedBlock) {
                    _purchaseFailedBlock(@"已经购买过商品");
                }
                [self purchaseFinishTransaction:tran];
//                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
            }
                break;
            case SKPaymentTransactionStateFailed:{
                NSLog(@"交易失败");
                
                if (_purchaseFailedBlock) {
                    _purchaseFailedBlock(@"交易失败");
                }
                [self purchaseFinishTransaction:tran];
//                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                //                [SVProgressHUD showErrorWithStatus:@"购买失败"];
            }
                break;
            default:
                break;
        }
    }
}

//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"交易结束");
    
    [self purchaseFinishTransaction:transaction];
//    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)purchaseFinishTransaction:(SKPaymentTransaction *)transaction{

    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

@end
