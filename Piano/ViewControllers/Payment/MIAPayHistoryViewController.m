//
//  MIAPayHistoryViewController.m
//  Piano
//
//  Created by 刘维 on 16/5/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAPayHistoryViewController.h"
#import "UIViewController+HXClass.h"
#import "MIAPayHistoryViewModel.h"
#import "MIACellManage.h"
#import "MIAFontManage.h"
#import "HXUserSession.h"
#import "MIANavBarView.h"
#import "MIAItemsView.h"

static CGFloat const kPayHistoryNavbarHeight = 50.;

@interface MIAPayHistoryViewController()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>{

    NSInteger itemCount;
}

@property (nonatomic, strong) MIANavBarView *navBarView;

@property (nonatomic, strong) MIAItemsView *itemsView;

@property (nonatomic, strong) UIScrollView *payHistoryScrollView;
@property (nonatomic, strong) UITableView *receiveGiftTableView;
@property (nonatomic, strong) UITableView *sendGiftTableView;
@property (nonatomic, strong) UITableView *paymentHistoryTableView;

@property (nonatomic, strong) MIAPayHistoryViewModel *payHistoryViewModel;

@end

@implementation MIAPayHistoryViewController

- (void)loadView{

    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    if ([[HXUserSession session] role] == HXUserRoleNormal) {
        //非主播
        itemCount = 2;
    }else if([[HXUserSession session] role] == HXUserRoleAnchor){
        //主播
        itemCount = 3;
    }
    
    [self createNavBarView];
    [self createItemView];
    [self createTableView];
    
    [self loadViewModel];
}

- (void)createNavBarView{

    self.navBarView = [MIANavBarView newAutoLayoutView];
    [_navBarView setBackgroundColor:[UIColor whiteColor]];
    [[_navBarView navBarTitleLabel] setTextColor:[UIColor blackColor]];
    [_navBarView setTitle:@"消费记录"];
    [_navBarView setLeftButtonImageName:@"C-BackIcon-Gray"];
    [_navBarView showBottomLineView];
    
    @weakify(self);
    [_navBarView navBarLeftClickHanlder:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    } rightClickHandler:nil];
    [self.view addSubview:_navBarView];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_navBarView superView:self.view];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_navBarView superView:self.view];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_navBarView superView:self.view];
    [JOAutoLayout autoLayoutWithHeight:kPayHistoryNavbarHeight selfView:_navBarView superView:self.view];
}

- (void)createItemView{
    
    self.itemsView = [MIAItemsView newAutoLayoutView];
    
    if ([[HXUserSession session] role] == HXUserRoleNormal) {
        //非主播
        [_itemsView setItemArray:@[@"送出礼物",@"充值记录"]];
    }else if([[HXUserSession session] role] == HXUserRoleAnchor){
        //主播
        [_itemsView setItemArray:@[@"收到礼物",@"送出礼物",@"充值记录"]];
    }
    [_itemsView setItemTitleColor:[MIAFontManage getFontWithType:MIAFontType_PayHistory_HeadTip]->color
                        titleFont:[MIAFontManage getFontWithType:MIAFontType_PayHistory_HeadTip]->font];
    [_itemsView setAnimationColor:JORGBCreate(1., 195., 170., 1.)];
    
    @weakify(self);
    [_itemsView itemClickHanlder:^(NSInteger index, NSString *itemTitel) {
    @strongify(self);
        
        if (index == 0) {
            //送出的礼物
            [self leftItemButtonClick];
        }else if (index == 1){
            //充值记录
            [self rightItemButtonClick];
        }
        
    }];
    [self.view addSubview:_itemsView];
    
    [JOAutoLayout autoLayoutWithTopView:_navBarView distance:0. selfView:_itemsView superView:self.view];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_itemsView superView:self.view];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_itemsView superView:self.view];
    [JOAutoLayout autoLayoutWithHeight:kPayHistoryItemViewHeight selfView:_itemsView superView:self.view];
}

- (void)createTableView{
    
    self.payHistoryScrollView = [UIScrollView newAutoLayoutView];
    [_payHistoryScrollView setShowsHorizontalScrollIndicator:NO];
    [_payHistoryScrollView setShowsVerticalScrollIndicator:NO];
    [_payHistoryScrollView setPagingEnabled:YES];
    [_payHistoryScrollView setDelegate:self];
    [self.view addSubview:_payHistoryScrollView];
    
    [_payHistoryScrollView setContentSize:JOSize(View_Width(self.view)*itemCount, View_Height(self.view)-kPayHistoryItemViewHeight-kPayHistoryNavbarHeight)];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_payHistoryScrollView superView:self.view];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_payHistoryScrollView superView:self.view];
    [JOAutoLayout autoLayoutWithTopView:_itemsView distance:0. selfView:_payHistoryScrollView superView:self.view];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_payHistoryScrollView superView:self.view];
    
    self.sendGiftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_sendGiftTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_sendGiftTableView setDataSource:self];
    [_sendGiftTableView setDelegate:self];
    [_sendGiftTableView setBackgroundColor:JORGBSameCreate(247.)];
    [_payHistoryScrollView addSubview:_sendGiftTableView];
    
    if ([[HXUserSession session] role] == HXUserRoleAnchor) {
        //主播状态
        self.receiveGiftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_receiveGiftTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_receiveGiftTableView setDataSource:self];
        [_receiveGiftTableView setDelegate:self];
        [_receiveGiftTableView setBackgroundColor:JORGBSameCreate(247.)];
        [_payHistoryScrollView addSubview:_receiveGiftTableView];
        
        [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_receiveGiftTableView superView:_payHistoryScrollView];
        [JOAutoLayout autoLayoutWithSize:JOSize(_payHistoryScrollView.contentSize.width/itemCount, _payHistoryScrollView.contentSize.height) selfView:_receiveGiftTableView superView:_payHistoryScrollView];
        
        [JOAutoLayout autoLayoutWithLeftView:_receiveGiftTableView distance:0. selfView:_sendGiftTableView superView:_payHistoryScrollView];
        [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_sendGiftTableView superView:_payHistoryScrollView];
        [JOAutoLayout autoLayoutWithSize:JOSize(_payHistoryScrollView.contentSize.width/itemCount, _payHistoryScrollView.contentSize.height) selfView:_sendGiftTableView superView:_payHistoryScrollView];
        
    }else if ([[HXUserSession session] role] == HXUserRoleNormal){
        //客人状态
        [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_sendGiftTableView superView:_payHistoryScrollView];
        [JOAutoLayout autoLayoutWithSize:JOSize(_payHistoryScrollView.contentSize.width/itemCount, _payHistoryScrollView.contentSize.height) selfView:_sendGiftTableView superView:_payHistoryScrollView];
    }
    
    self.paymentHistoryTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_paymentHistoryTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_paymentHistoryTableView setDataSource:self];
    [_paymentHistoryTableView setDelegate:self];
    [_paymentHistoryTableView setBackgroundColor:JORGBSameCreate(247.)];
    [_payHistoryScrollView addSubview:_paymentHistoryTableView];
    
    [JOAutoLayout autoLayoutWithLeftView:_sendGiftTableView distance:0. selfView:_paymentHistoryTableView superView:_payHistoryScrollView];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_paymentHistoryTableView superView:_payHistoryScrollView];
    [JOAutoLayout autoLayoutWithSize:JOSize(_payHistoryScrollView.contentSize.width/itemCount, _payHistoryScrollView.contentSize.height) selfView:_paymentHistoryTableView superView:_payHistoryScrollView];
}

- (void)viewWillLayoutSubviews{

    [super viewWillLayoutSubviews];
    [_payHistoryScrollView setContentSize:JOSize(View_Width(self.view)*itemCount, View_Height(self.view)-kPayHistoryItemViewHeight-kPayHistoryNavbarHeight)];
}


- (void)loadViewModel{

    self.payHistoryViewModel = [MIAPayHistoryViewModel new];
    [self showHUDWithView:_sendGiftTableView];
    [self showHUDWithView:_paymentHistoryTableView];
    
    @weakify(self);
    RACSignal *fetchSendGiftListSignal = [_payHistoryViewModel.fetchCommand execute:nil];
    [fetchSendGiftListSignal subscribeError:^(NSError *error) {
    @strongify(self);
        
        [self hiddenHUDWithView:self.sendGiftTableView];
        
        if (![error.domain isEqualToString:RACCommandErrorDomain]) {
            [self showBannerWithPrompt:error.domain];
        }
    } completed:^{
    @strongify(self);
        
        [self hiddenHUDWithView:self.sendGiftTableView];
        [self.sendGiftTableView reloadData];
    }];
    
    RACSignal *fetchOrderListSignal = [_payHistoryViewModel.fetchOrderListCommand execute:nil];
    [fetchOrderListSignal subscribeError:^(NSError *error) {
    @strongify(self);
        [self hiddenHUDWithView:self.paymentHistoryTableView];
        if (![error.domain isEqualToString:RACCommandErrorDomain]) {
            [self showBannerWithPrompt:error.domain];
        }
        
    } completed:^{
    @strongify(self);
        
        [self hiddenHUDWithView:self.paymentHistoryTableView];
        [self.paymentHistoryTableView reloadData];
    }];
}

#pragma mark - Button action

- (void)leftItemButtonClick{

    [_payHistoryScrollView scrollRectToVisible:CGRectMake(0., 0., View_Width(self.view), _payHistoryScrollView.contentSize.height) animated:YES];
}

- (void)rightItemButtonClick{

    [_payHistoryScrollView scrollRectToVisible:CGRectMake(View_Width(self.view), 0., View_Width(self.view), _payHistoryScrollView.contentSize.height) animated:YES];
}

#pragma mark - table data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([tableView isEqual:_sendGiftTableView]) {
        
        return _payHistoryViewModel.sendGiftLsitArray.count;
        
    }else if([tableView isEqual:_paymentHistoryTableView]){
    
        return _payHistoryViewModel.orderListArray.count;
    }else if ([tableView isEqual:_receiveGiftTableView]){
    
        return _payHistoryViewModel.recevierGiftListArray.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MIABaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MIAPayHistoryCell"];
    
    if (!cell) {
        cell = [MIACellManage getCellWithType:MIACellTypePayHistory];
        [cell setCellWidth:View_Width(self.view)];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    id data = nil;
    
    if ([tableView isEqual:_sendGiftTableView]) {
        
        data = [_payHistoryViewModel.sendGiftLsitArray objectAtIndex:indexPath.section];
    }else if([tableView isEqual:_paymentHistoryTableView]){
        
        data =  [_payHistoryViewModel.orderListArray objectAtIndex:indexPath.section];
    }else if ([tableView isEqual:_receiveGiftTableView]){
        
//        
    }
    
    [cell setCellData:data];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return kPayHistoryCellHeadHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kPayHistoryCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return CGFLOAT_MIN;
}

#pragma mark - table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - Scroll delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if ([scrollView isEqual:_payHistoryScrollView]) {
//        [self setAnimationViewOffsetX:scrollView.contentOffset.x/2.];
        [_itemsView setAnimationOffsetX:scrollView.contentOffset.x/itemCount];
    }
    
}

@end
