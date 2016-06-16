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

static CGFloat const kIncomeNavBarHeight = 50.;//Bar的高度
static CGFloat const kIncomeHeadViewHeight = 150.;//head的高度

//static CGFloat const kInComeMoneyTipTopSpaceDistance = 

@interface MIAIncomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MIANavBarView *navBarView;

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UITableView *incomeTableView;

@end

@implementation MIAIncomeViewController

- (void)loadView{
    
    [super loadView];
    
    [self createNaveBarView];
    [self createHeadView];
    [self createIncomeTableView];
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
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_navBarView superView:self.view];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_navBarView superView:self.view];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_navBarView superView:self.view];
    [JOAutoLayout autoLayoutWithHeight:kIncomeNavBarHeight selfView:_navBarView superView:self.view];
}

- (void)createHeadView{

    self.headView = [UIView newAutoLayoutView];
    [_headView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:_headView];
    
    [JOAutoLayout autoLayoutWithTopView:_navBarView distance:0. selfView:_headView superView:self.view];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_headView superView:self.view];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_headView superView:self.view];
    [JOAutoLayout autoLayoutWithHeight:kIncomeHeadViewHeight selfView:_headView superView:self.view];
    
    UILabel *moneyTipLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Income_MoneyTip]];
    [moneyTipLabel setText:@"可提现的金额:"];
    [moneyTipLabel setTextAlignment:NSTextAlignmentCenter];
    [_headView addSubview:moneyTipLabel];
    
    
}

- (void)createIncomeTableView{

    self.incomeTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_incomeTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_incomeTableView setDelegate:self];
    [_incomeTableView setDataSource:self];
    [_incomeTableView setShowsVerticalScrollIndicator:NO];
    [_incomeTableView setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:_incomeTableView];
    
    [JOAutoLayout autoLayoutWithTopView:_headView distance:0. selfView:_incomeTableView superView:self.view];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_incomeTableView superView:self.view];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_incomeTableView superView:self.view];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_incomeTableView superView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [[cell textLabel] setText:@"test"];
    return cell;
}

#pragma mark - table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

@end
