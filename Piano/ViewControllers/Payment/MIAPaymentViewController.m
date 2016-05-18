//
//  MIAPaymentViewController.m
//  Piano
//
//  Created by 刘维 on 16/5/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAPaymentViewController.h"
#import "MIAPayHistoryViewController.h"
#import "UIViewController+HXClass.h"
#import "MIAPaymentViewModel.h"
#import "MIACellManage.h"
#import "MIAPaymentBarView.h"
#import "MIARechargeModel.h"
#import "MIAFontManage.h"

#import <StoreKit/StoreKit.h>

@interface MIAPaymentViewController()<UITableViewDataSource, UITableViewDelegate,SKPaymentTransactionObserver,SKProductsRequestDelegate>

@property (nonatomic, strong) MIAPaymentBarView *paymentBarView;
@property (nonatomic, strong) UITableView *paymentTableView;

@property (nonatomic, strong) MIAPaymentViewModel *paymentViewModel;

@property (nonatomic, copy) NSString *productIDString;
@property (nonatomic, copy) NSString *productID;

@end

@implementation MIAPaymentViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)loadView{

    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self loadViewModel];
    
    [self createBarView];
    [self createTableView];
    
//    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

- (void)loadViewModel{

    self.paymentViewModel = [MIAPaymentViewModel new];
    [self showHUD];
    
    @weakify(self);
    RACSignal *fetchSignal = [_paymentViewModel.fetchCommand execute:nil];
    [fetchSignal subscribeError:^(NSError *error) {
    @strongify(self);
        
        [self hiddenHUD];
        
        if (![error.domain isEqualToString:RACCommandErrorDomain]) {
            [self showBannerWithPrompt:error.domain];
        }
        
    } completed:^{
    @strongify(self);
        [self hiddenHUD];
        [self.paymentTableView reloadData];
    }];
    
    [self refreshMCoin];
    
}

- (void)refreshMCoin{

    //获取M币的余额
    @weakify(self);
    RACSignal *fetchMCoinSignal = [_paymentViewModel.fetchMCoinBalanceCommand execute:nil];
    [fetchMCoinSignal subscribeError:^(NSError *error) {
    @strongify(self);
        
        if (![error.domain isEqualToString:RACCommandErrorDomain]) {
            [self showBannerWithPrompt:error.domain];
        }
        
    } completed:^{
    @strongify(self);
        
        [self.paymentBarView setMAmount:_paymentViewModel.mCoin];
    }];
}

- (void)createBarView{

    self.paymentBarView = [MIAPaymentBarView newAutoLayoutView];
    
    @weakify(self);
    [_paymentBarView paymentBarButtonClickHandler:^(PaymentBarButtonItemType type) {
    @strongify(self);
        if (type == PaymentBarButtonItemType_Pop) {
            //POP
            [self.navigationController popViewControllerAnimated:YES];
            
        }else if(type == PaymentBarButtonItemType_PayHistory){
            //消费记录
            MIAPayHistoryViewController *payHistoryViewController = [MIAPayHistoryViewController new];
            [self.navigationController pushViewController:payHistoryViewController animated:YES];
        }
    }];
    [self.view addSubview:_paymentBarView];
 
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_paymentBarView superView:self.view];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_paymentBarView superView:self.view];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_paymentBarView superView:self.view];
    [JOAutoLayout autoLayoutWithHeight:kPaymentBarViewHeight selfView:_paymentBarView superView:self.view];
}

- (void)createTableView{

    self.paymentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_paymentTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_paymentTableView setSectionFooterHeight:CGFLOAT_MIN];
    [_paymentTableView setDelegate:self];
    [_paymentTableView setDataSource:self];
//    [_paymentTableView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_paymentTableView];
    
    [JOAutoLayout autoLayoutWithTopView:_paymentBarView distance:0. selfView:_paymentTableView superView:self.view];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_paymentTableView superView:self.view];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_paymentTableView superView:self.view];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_paymentTableView superView:self.view];
}

#pragma mark - table data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[_paymentViewModel rechargeListArray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MIABaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MIAPaymentCell"];
    
    if (!cell) {
        cell =[MIACellManage getCellWithType:MIACellTypePayment];
        [cell setCellWidth:View_Width(self.view)];
    }
    
    [cell setCellData:[[_paymentViewModel rechargeListArray] objectAtIndex:indexPath.row]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return kPaymentCellHeadViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0., 0., View_Width(self.view), kPaymentCellHeadViewHeight)];
    [headView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *headLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Payment_Pay_Head]];
    [headLabel setText:@"请选择充值金额"];
    [headView addSubview:headLabel];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 10., 0., -10.) selfView:headLabel superView:headView];
    
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kPaymentCellHeight;
}

#pragma mark - table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.productID = nil;
    self.productID = [(MIARechargeModel *)[[_paymentViewModel rechargeListArray] objectAtIndex:indexPath.row] id];
    
   RACSignal *signal = [_paymentViewModel purchaseWithProductID:_productID];
    
    [self showHUD];
    @weakify(self);
    [signal subscribeError:^(NSError *error) {
    @strongify(self);
        
        [self hiddenHUD];
        
        if (![error.domain isEqualToString:RACCommandErrorDomain]) {
            [self showBannerWithPrompt:error.domain];
        }
        
    } completed:^{
    @strongify(self);
        
        [self hiddenHUD];
        [self refreshMCoin];
    }];
    
    
//    self.productIDString = nil;
//    self.productIDString = [(MIARechargeModel *)[[_paymentViewModel rechargeListArray] objectAtIndex:indexPath.row] appleProductID];
//    
//    [[JOPurchaseManage sharePurchaseManage] purchaseWithProductID:_productIDString successHanlder:^(NSString *productID, NSString *transactionID, NSString *verifyString) {
//        
//        [MiaAPIHelper verifyPurchaseWithRechargeID:_productID orderID:transactionID auth:verifyString completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
//            
//            if (success) {
//                NSLog(@"uderInfo:%@",userInfo);
//            }else{
//            
//                NSLog(@"error:%@",[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]);
//            }
//            
//        } timeoutBlock:^(MiaRequestItem *requestItem) {
//            
//        }];
//        
//        
//    } failedHanlder:^(NSString *failed) {
//        
//        NSLog(@"error:%@",failed);
//    }];
    
//    if([SKPaymentQueue canMakePayments]){
//        [self requestProductData:_productIDString];
//    }else{
//        NSLog(@"不允许程序内付费");
//    }
}

#pragma mark - 内购相关

- (void)requestProductData:(NSString *)type{
    NSLog(@"-------------请求对应的产品信息----------------");
    
//    [SVProgressHUD showWithStatus:nil maskType:SVProgressHUDMaskTypeBlack];
    
    NSArray *product = [[NSArray alloc] initWithObjects:type,nil];
    
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
        
        if([pro.productIdentifier isEqualToString:_productIDString]){
            p = pro;
        }
        
        NSLog(@"p:%@",p);
    }
    
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
                
                NSURL *receiptUrl=[[NSBundle mainBundle] appStoreReceiptURL];
                NSData *receiptData=[NSData dataWithContentsOfURL:receiptUrl];
                NSString *receiptString=[receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];//转化为base64字符串
                
                [MiaAPIHelper verifyPurchaseWithRechargeID:_productID orderID:tran.transactionIdentifier auth:receiptString completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                    
                    if (success) {
                        NSLog(@"uderInfo:%@",userInfo);
                    }
                    
                } timeoutBlock:^(MiaRequestItem *requestItem) {
                    
                }];
//                [MiaAPIHelper ]
                
//                [self verifyPurchaseWithPaymentTransaction];
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
            }
                
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加进列表");
                
                break;
            case SKPaymentTransactionStateRestored:{
                NSLog(@"已经购买过商品");
                
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
            }
                break;
            case SKPaymentTransactionStateFailed:{
                NSLog(@"交易失败");
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
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
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}


//沙盒测试环境验证
#define SANDBOX @"https://sandbox.itunes.apple.com/verifyReceipt"
//正式环境验证
#define AppStore @"https://buy.itunes.apple.com/verifyReceipt"
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
