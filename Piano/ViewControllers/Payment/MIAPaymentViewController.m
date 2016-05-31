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

#import "MIAMCoinManage.h"

@interface MIAPaymentViewController()<UITableViewDataSource, UITableViewDelegate>

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
    
    
    [[MIAMCoinManage shareMCoinManage] checkLocalVerifyPurchaseWithSuccess:^{
        
    } failed:^(NSString *failed) {
        
    } mCoinSuccess:^{
        [_paymentBarView setMAmount:[[MIAMCoinManage shareMCoinManage] mCoin]];
    } mCoinFailed:^(NSString *failed) {
        
    }];
    
    [[MIAMCoinManage shareMCoinManage] updateMCoinWithMCoinSuccess:^{
        
        [_paymentBarView setMAmount:[[MIAMCoinManage shareMCoinManage] mCoin]];
        
    } mCoinFailed:^(NSString *failed) {
        
        [self showBannerWithPrompt:failed];
    }];
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
    
}

- (void)createBarView{

    self.paymentBarView = [MIAPaymentBarView newAutoLayoutView];
    
    @weakify(self);
    [_paymentBarView paymentBarButtonClickHandler:^(PaymentBarButtonItemType type) {
    @strongify(self);
        if (type == PaymentBarButtonItemType_Pop) {
            //POP
            if (_present) {
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }else if(type == PaymentBarButtonItemType_PayHistory){
            //消费记录
            MIAPayHistoryViewController *payHistoryViewController = [MIAPayHistoryViewController new];
            [payHistoryViewController setHistoryType:HistoryType_Guest];
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
    
    self.productIDString = nil;
    self.productIDString = [(MIARechargeModel *)[[_paymentViewModel rechargeListArray] objectAtIndex:indexPath.row] appleProductID];
    
    [self showHUD];
    
    [[MIAMCoinManage shareMCoinManage] rechargeMCoinWithProductID:_productID purchaseID:_productIDString success:^{
        
        [self hiddenHUD];
        
    } failed:^(NSString *failed) {
        
        [self hiddenHUD];
        [self showBannerWithPrompt:failed];
    } mCoinSuccess:^{
        
        [_paymentBarView setMAmount:[[MIAMCoinManage shareMCoinManage] mCoin]];
        
    } mCoinFailed:^(NSString *failed) {
        
        [self showBannerWithPrompt:failed];
    }];
    
}

@end
