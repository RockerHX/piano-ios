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

@interface MIAPayHistoryViewController()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *leftItemButton;
@property (nonatomic, strong) UIButton *rightItemButton;
@property (nonatomic, strong) UIView *itemView;
@property (nonatomic, strong) UIView *animationView;

@property (nonatomic, strong) UIScrollView *payHistoryScrollView;
@property (nonatomic, strong) UITableView *sendGiftTableView;
@property (nonatomic, strong) UITableView *paymentHistoryTableView;

@property (nonatomic, strong) MIAPayHistoryViewModel *payHistoryViewModel;

@end

@implementation MIAPayHistoryViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)loadView{

    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTitle:@"消费记录"];
    
    [self createItemView];
    [self createTableView];
    
    [self loadViewModel];
}

- (void)createItemView{

    self.itemView = [UIView newAutoLayoutView];
    [_itemView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_itemView];
    
    [JOAutoLayout autoLayoutWithTopSpaceDistance:64. selfView:_itemView superView:self.view];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_itemView superView:self.view];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_itemView superView:self.view];
    [JOAutoLayout autoLayoutWithHeight:kPayHistoryItemViewHeight selfView:_itemView superView:self.view];
    
    self.leftItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftItemButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_leftItemButton setTitle:@"送出礼物" forState:UIControlStateNormal];
    [_leftItemButton setTitleColor:[MIAFontManage getFontWithType:MIAFontType_PayHistory_HeadTip]->color forState:UIControlStateNormal];
    [[_leftItemButton titleLabel] setFont:[MIAFontManage getFontWithType:MIAFontType_PayHistory_HeadTip]->font];
    [_leftItemButton addTarget:self action:@selector(leftItemButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_itemView addSubview:_leftItemButton];
    
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_leftItemButton superView:_itemView];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_leftItemButton superView:_itemView];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_leftItemButton superView:_itemView];
    [JOAutoLayout autoLayoutWithWidthWithView:_itemView ratioValue:1./2. selfView:_leftItemButton superView:_itemView];
    
    self.rightItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightItemButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_rightItemButton setTitle:@"充值记录" forState:UIControlStateNormal];
    [_rightItemButton setTitleColor:[MIAFontManage getFontWithType:MIAFontType_PayHistory_HeadTip]->color forState:UIControlStateNormal];
    [[_rightItemButton titleLabel] setFont:[MIAFontManage getFontWithType:MIAFontType_PayHistory_HeadTip]->font];
    [_rightItemButton addTarget:self action:@selector(rightItemButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_itemView addSubview:_rightItemButton];
    
    [JOAutoLayout autoLayoutWithLeftView:_leftItemButton distance:0. selfView:_rightItemButton superView:_itemView];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_rightItemButton superView:_itemView];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_rightItemButton superView:_itemView];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_rightItemButton superView:_itemView];
    
    self.animationView = [UIView newAutoLayoutView];
    [_animationView setBackgroundColor:JORGBCreate(1., 195., 170., 1.)];
    [_itemView addSubview:_animationView];
    
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_animationView superView:_itemView];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_animationView superView:_itemView];
    [JOAutoLayout autoLayoutWithHeight:2. selfView:_animationView superView:_itemView];
    [JOAutoLayout autoLayoutWithWidthWithView:_itemView ratioValue:1./2. selfView:_animationView superView:_itemView];
}

- (void)createTableView{
    
    self.payHistoryScrollView = [UIScrollView newAutoLayoutView];
    [_payHistoryScrollView setShowsHorizontalScrollIndicator:NO];
    [_payHistoryScrollView setShowsVerticalScrollIndicator:NO];
    [_payHistoryScrollView setPagingEnabled:YES];
    [_payHistoryScrollView setDelegate:self];
    [self.view addSubview:_payHistoryScrollView];
    
    [_payHistoryScrollView setContentSize:JOSize(View_Width(self.view)*2., View_Height(self.view)-kPayHistoryItemViewHeight-64.)];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_payHistoryScrollView superView:self.view];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_payHistoryScrollView superView:self.view];
    [JOAutoLayout autoLayoutWithTopView:_itemView distance:0. selfView:_payHistoryScrollView superView:self.view];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_payHistoryScrollView superView:self.view];
    

    self.sendGiftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_sendGiftTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_sendGiftTableView setDataSource:self];
    [_sendGiftTableView setDelegate:self];
    [_sendGiftTableView setBackgroundColor:JORGBSameCreate(247.)];
    [_payHistoryScrollView addSubview:_sendGiftTableView];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_sendGiftTableView superView:_payHistoryScrollView];
    [JOAutoLayout autoLayoutWithSize:JOSize(_payHistoryScrollView.contentSize.width/2., _payHistoryScrollView.contentSize.height) selfView:_sendGiftTableView superView:_payHistoryScrollView];
    
    self.paymentHistoryTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_paymentHistoryTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_paymentHistoryTableView setDataSource:self];
    [_paymentHistoryTableView setDelegate:self];
    [_paymentHistoryTableView setBackgroundColor:JORGBSameCreate(247.)];
    [_payHistoryScrollView addSubview:_paymentHistoryTableView];
    
    [JOAutoLayout autoLayoutWithLeftView:_sendGiftTableView distance:0. selfView:_paymentHistoryTableView superView:_payHistoryScrollView];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_paymentHistoryTableView superView:_payHistoryScrollView];
    [JOAutoLayout autoLayoutWithSize:JOSize(_payHistoryScrollView.contentSize.width/2., _payHistoryScrollView.contentSize.height) selfView:_paymentHistoryTableView superView:_payHistoryScrollView];

}

- (void)viewWillLayoutSubviews{

    [super viewWillLayoutSubviews];
    [_payHistoryScrollView setContentSize:JOSize(View_Width(self.view)*2., View_Height(self.view)-kPayHistoryItemViewHeight-64.)];
}

- (void)setAnimationViewOffsetX:(CGFloat)offsetx{
    
    [JOAutoLayout removeAutoLayoutWithLeftSelfView:_animationView superView:_itemView];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:offsetx selfView:_animationView superView:_itemView];
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
        
//        [self hiddenHUD];
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
        
        NSLog(@"row:%d",indexPath.row);
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    id data = nil;
    
    if ([tableView isEqual:_sendGiftTableView]) {
        
        data = [_payHistoryViewModel.sendGiftLsitArray objectAtIndex:indexPath.row];
        
    }else if([tableView isEqual:_paymentHistoryTableView]){
        
        data =  [_payHistoryViewModel.orderListArray objectAtIndex:indexPath.row];
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
        [self setAnimationViewOffsetX:scrollView.contentOffset.x/2.];
    }
    
}

@end
