//
//  MIAIncomeViewController.m
//  Piano
//
//  Created by 刘维 on 16/6/15.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAIncomeViewController.h"
#import "UIViewController+HXClass.h"
#import "MIAFontManage.h"
#import "MIANavBarView.h"
#import "MIAIncomeViewModel.h"

static CGFloat const kIncomeNavBarHeight = 50.;//Bar的高度

static CGFloat const kIncomeMoneyTipTopSpaceDistance = 20.;//头部的间距大小.
static CGFloat const kIncomeMoneyTipToMoneySpaceDistance = 20.;//提示与金额之间的间距大小
static CGFloat const kIncomeMoneyToTipSpaceDistance = 20.;//金额与底部的提示之间的间距大小
static CGFloat const kIncomeTipBottomSpaceDistance = 15.;  //提示与底部之间的间距大小

static NSString *const kMoneyTipString = @"可提现的金额:";
static NSString *const kIncomeTipString = @"温馨提示:可使用电脑端登录www.miamusic.com提现";

@interface MIAIncomeViewController ()<UITableViewDelegate, UITableViewDataSource>{

    CGFloat headViewHeight;
}

@property (nonatomic, strong) MIANavBarView *navBarView;

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UITableView *incomeTableView;

@property (nonatomic, strong) MIAIncomeViewModel *incomeViewModel;

@end

@implementation MIAIncomeViewController

//- (void)dealloc{
//
//    JOLog(@"MIAIncomeViewController release");
//}

- (void)loadView{
    
    [super loadView];
    [self loadViewModel];
    
    [self createNaveBarView];
    [self createHeadView];
    [self createIncomeTableView];
}

- (void)loadViewModel{

    self.incomeViewModel = [MIAIncomeViewModel new];
    
    [self showHUD];
    RACSignal *signal = [_incomeViewModel.fetchCommand execute:nil];
    @weakify(self);
    [signal subscribeError:^(NSError *error) {
        @strongify(self);
        if (![error.domain isEqualToString:RACCommandErrorDomain]) {
            [self showBannerWithPrompt:error.domain];
        }
        [self hiddenHUD];
    } completed:^{
            @strongify(self);
        
        [self.incomeTableView reloadData];
        NSMutableAttributedString *attributedString = [[NSString stringWithFormat:@"%@ 元",self.incomeViewModel.availableMoney] JOAttributedStringwithMarkString:@"元"
                                                                                                                                                       markFont:[MIAFontManage getFontWithType:MIAFontType_Income_MoneyUnit]->font
                                                                                                                                                      markColor:[MIAFontManage getFontWithType:MIAFontType_Income_MoneyUnit]->color];
        [self.moneyLabel setAttributedText:attributedString];
        [self hiddenHUD];
    }];
}

- (void)createNaveBarView{

    self.navBarView = [MIANavBarView newAutoLayoutView];
    [_navBarView setBackgroundColor:[UIColor whiteColor]];
    [[_navBarView navBarTitleLabel] setTextColor:[UIColor blackColor]];
    [_navBarView setTitle:@"我的收益"];
    [_navBarView setLeftButtonImageName:@"C-BackIcon-Gray"];
    [_navBarView setLeftButtonImageEdge:UIEdgeInsetsMake(0., -15., 0., 0.)];
    [_navBarView showBottomLineView];
    
    @weakify(self);
    [_navBarView navBarLeftClickHanlder:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    } rightClickHandler:nil];
    [self.view addSubview:_navBarView];
    
    [_navBarView layoutLeft:0. layoutItemHandler:nil];
    [_navBarView layoutRight:0. layoutItemHandler:nil];
    [_navBarView layoutTop:0. layoutItemHandler:nil];
    [_navBarView layoutHeight:kIncomeNavBarHeight layoutItemHandler:nil];
}

- (void)createHeadView{
    
    self.headView = [UIView newAutoLayoutView];
    [_headView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:_headView];
    
    UILabel *moneyTipLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Income_MoneyTip]];
    [moneyTipLabel setText:kMoneyTipString];
    [moneyTipLabel setTextAlignment:NSTextAlignmentCenter];
    [_headView addSubview:moneyTipLabel];
    
    CGFloat moneyTipLabelHeight = [moneyTipLabel sizeThatFits:JOMAXSize].height;
    
    [moneyTipLabel layoutTop:kIncomeMoneyTipTopSpaceDistance layoutItemHandler:nil];
    [moneyTipLabel layoutLeft:10. layoutItemHandler:nil];
    [moneyTipLabel layoutRight:-10. layoutItemHandler:nil];
    [moneyTipLabel layoutHeight:moneyTipLabelHeight layoutItemHandler:nil];
    
    self.moneyLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Income_Money]];
    [_moneyLabel setText:@"  "];
    [_moneyLabel setTextAlignment:NSTextAlignmentCenter];
    [_headView addSubview:_moneyLabel];
    
    CGFloat moneyLabelHeight = [_moneyLabel sizeThatFits:JOMAXSize].height;
    
    [_moneyLabel layoutLeft:10. layoutItemHandler:nil];
    [_moneyLabel layoutRight:-10. layoutItemHandler:nil];
    [_moneyLabel layoutTopView:moneyTipLabel distance:kIncomeMoneyTipToMoneySpaceDistance layoutItemHandler:nil];
    [_moneyLabel layoutHeight:moneyLabelHeight layoutItemHandler:nil];
    
    UILabel *tipLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Income_Tip]];
    [tipLabel setText:kIncomeTipString];
    [tipLabel setTextAlignment:NSTextAlignmentCenter];
    [_headView addSubview:tipLabel];
    
    CGFloat tipLabelHeight = [tipLabel sizeThatFits:JOMAXSize].height;
    
    [tipLabel layoutTopView:_moneyLabel distance:kIncomeMoneyToTipSpaceDistance layoutItemHandler:nil];
    [tipLabel layoutLeft:10. layoutItemHandler:nil];
    [tipLabel layoutRight:-10. layoutItemHandler:nil];
    [tipLabel layoutHeight:tipLabelHeight layoutItemHandler:nil];
    
    CGFloat headHeight = moneyTipLabelHeight + kIncomeMoneyTipTopSpaceDistance + moneyLabelHeight + kIncomeMoneyTipToMoneySpaceDistance + tipLabelHeight + kIncomeMoneyToTipSpaceDistance + kIncomeTipBottomSpaceDistance;
    
    [_headView layoutTopView:_navBarView distance:0. layoutItemHandler:nil];
    [_headView layoutLeft:0. layoutItemHandler:nil];
    [_headView layoutRight:0. layoutItemHandler:nil];
    [_headView layoutHeight:headHeight layoutItemHandler:nil];
}

- (void)createIncomeTableView{

    self.incomeTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_incomeTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_incomeTableView setDelegate:self];
    [_incomeTableView setDataSource:self];
    [_incomeTableView setShowsVerticalScrollIndicator:NO];
    [_incomeTableView setShowsHorizontalScrollIndicator:NO];
    [_incomeTableView setSectionHeaderHeight:CGFLOAT_MIN];
    [self.view addSubview:_incomeTableView];
    
    [_incomeTableView layoutTopView:_headView distance:0. layoutItemHandler:nil];
    [_incomeTableView layoutLeft:0. layoutItemHandler:nil];
    [_incomeTableView layoutRight:0. layoutItemHandler:nil];
    [_incomeTableView layoutBottom:0. layoutItemHandler:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [_incomeViewModel.cellArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[_incomeViewModel.cellArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    [[cell textLabel] setFont:[MIAFontManage getFontWithType:MIAFontType_Income_Cell_Title]->font];
    [[cell textLabel] setTextColor:[MIAFontManage getFontWithType:MIAFontType_Income_Cell_Title]->color];
    [[cell detailTextLabel] setFont:[MIAFontManage getFontWithType:MIAFontType_Income_Cell_Content]->font];
    [[cell detailTextLabel] setTextColor:[MIAFontManage getFontWithType:MIAFontType_Income_Cell_Content]->color];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSDictionary *data = [[_incomeViewModel.cellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [[cell textLabel] setText:[data objectForKey:kIncomeCellTitleKey]];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%@ 元",[data objectForKey:kIncomeCellContentKey]]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50.;
}

#pragma mark - table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

@end
