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
//        JOLog(@"不允许程序内付费");
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
    
//    JOLog(@"--------------收到产品反馈消息---------------------");
    NSArray *product = response.products;
    if([product count] == 0){
//        JOLog(@"--------------没有商品------------------");
        if (_purchaseFailedBlock) {
            _purchaseFailedBlock(@"商品不存在");
        }
        return;
    }
    
//    JOLog(@"productID:%@", response.invalidProductIdentifiers);
//    JOLog(@"产品付费数量:%lu",(unsigned long)[product count]);
    
    SKProduct *p = nil;
    for (SKProduct *pro in product) {
//        JOLog(@"%@", [pro description]);
//        JOLog(@"%@", [pro localizedTitle]);
//        JOLog(@"%@", [pro localizedDescription]);
//        JOLog(@"%@", [pro price]);
//        JOLog(@"%@", [pro productIdentifier]);
        
        if([pro.productIdentifier isEqualToString:_productID]){
            p = pro;
        }
        
//        JOLog(@"p:%@",p);
    }
    
    
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    SKPayment *payment = [SKPayment paymentWithProduct:p];
    
//    JOLog(@"发送购买请求");
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    //    [SVProgressHUD showErrorWithStatus:@"支付失败"];
//    JOLog(@"------------------错误-----------------:%@", error);
}

- (void)requestDidFinish:(SKRequest *)request{
    //    [SVProgressHUD dismiss];
//    JOLog(@"------------反馈信息结束-----------------");
}

#pragma mark - 交易结果

//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction{
    
    
    for(SKPaymentTransaction *tran in transaction){
        
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:{
//                JOLog(@"交易完成");
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
//                JOLog(@"商品添加进列表");
                
                break;
            case SKPaymentTransactionStateRestored:{
//                JOLog(@"已经购买过商品");
                
                if (_purchaseFailedBlock) {
                    _purchaseFailedBlock(@"已经购买过商品");
                }
                [self purchaseFinishTransaction:tran];
//                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
            }
                break;
            case SKPaymentTransactionStateFailed:{
//                JOLog(@"交易失败");
                
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
//    JOLog(@"交易结束");
    
    [self purchaseFinishTransaction:transaction];
//    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)purchaseFinishTransaction:(SKPaymentTransaction *)transaction{

    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

//沙盒测试环境验证
//#define SANDBOX @"https://sandbox.itunes.apple.com/verifyReceipt"
////正式环境验证
//#define AppStore @"https://buy.itunes.apple.com/verifyReceipt"
/**
 *  验证购买，避免越狱软件模拟苹果请求达到非法购买问题
 *
 */
//-(void)verifyPurchaseWithPaymentTransaction{
//    //从沙盒中获取交易凭证并且拼接成请求体数据
//    NSURL *receiptUrl=[[NSBundle mainBundle] appStoreReceiptURL];
//    NSData *receiptData=[NSData dataWithContentsOfURL:receiptUrl];
//
//    NSString *receiptString=[receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];//转化为base64字符串
//
//    NSString *bodyString = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", receiptString];//拼接请求数据
//    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
//
//
//    //创建请求到苹果官方进行购买验证
//    NSURL *url=[NSURL URLWithString:SANDBOX];
//    NSMutableURLRequest *requestM=[NSMutableURLRequest requestWithURL:url];
//    requestM.HTTPBody=bodyData;
//    requestM.HTTPMethod=@"POST";
//    //创建连接并发送同步请求
//    NSError *error=nil;
//    NSData *responseData=[NSURLConnection sendSynchronousRequest:requestM returningResponse:nil error:&error];
//    if (error) {
//        NSLog(@"验证购买过程中发生错误，错误信息：%@",error.localizedDescription);
//        return;
//    }
//    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
//    NSLog(@"%@",dic);
//    if([dic[@"status"] intValue]==0){
//        NSLog(@"购买成功！");
//        NSDictionary *dicReceipt= dic[@"receipt"];
//        NSDictionary *dicInApp=[dicReceipt[@"in_app"] firstObject];
//        NSString *productIdentifier= dicInApp[@"product_id"];//读取产品标识
//        //如果是消耗品则记录购买数量，非消耗品则记录是否购买过
////        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
////        if ([productIdentifier isEqualToString:@"123"]) {
////            int purchasedCount=[defaults integerForKey:productIdentifier];//已购买数量
////            [[NSUserDefaults standardUserDefaults] setInteger:(purchasedCount+1) forKey:productIdentifier];
////        }else{
////            [defaults setBool:YES forKey:productIdentifier];
////        }
//        //在此处对购买记录进行存储，可以存储到开发商的服务器端
//    }else{
//        NSLog(@"购买失败，未通过验证！");
//    }
//}

@end
