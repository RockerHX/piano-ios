//
//  MIAHostProfileViewController.m
//  Piano
//
//  Created by 刘维 on 16/6/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAHostProfileViewController.h"
#import "MIASettingViewController.h"
#import "MIAPayHistoryViewController.h"
#import "MIAPaymentViewController.h"
#import "MIAIncomeViewController.h"

#import "UIViewController+HXClass.h"
#import "MIABaseTableViewCell.h"
#import "MIABaseCellHeadView.h"
#import "HXUserSession.h"
#import "FXBlurView.h"
#import "MIACellManage.h"
#import "JOBaseSDK.h"
#import "MIAFontManage.h"
#import "UIImageView+WebCache.h"
#import "MIAHostProfileViewModel.h"

@interface MIAHostProfileViewController ()<UITableViewDataSource, UITableViewDelegate>{

    CGFloat headHeight;
}

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIImageView *maskImageView;

@property (nonatomic, strong) UITableView *profileTableView;

@property (nonatomic, strong) UIView *meHeadView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *summaryLabel;

@property (nonatomic, strong) MIAHostProfileViewModel *hostProfileViewModel;

@end

@implementation MIAHostProfileViewController

- (void)loadView{

    [super loadView];
    
    self.hostProfileViewModel = [MIAHostProfileViewModel new];
    [self viewUpdate];
    
    [self createBackImageView];
    [self createHeadView];
    [self createProfileTableView];
    [self createHeadButtonView];
}

- (void)createBackImageView{

    self.coverImageView = [UIImageView newAutoLayoutView];
    [_coverImageView setContentMode:UIViewContentModeScaleAspectFill];
    [[_coverImageView layer] setMasksToBounds:YES];
    [self.view addSubview:_coverImageView];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0.0, 0., 0.) selfView:_coverImageView superView:self.view];
    
    self.maskImageView = [UIImageView newAutoLayoutView];
    [_maskImageView setImage:[UIImage imageNamed:@"PR-MaskBG"]];
    [self.view addSubview:_maskImageView];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_maskImageView superView:self.view];
}

- (void)createProfileTableView{

    self.profileTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_profileTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_profileTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_profileTableView setDelegate:self];
    [_profileTableView setDataSource:self];
    [_profileTableView setShowsVerticalScrollIndicator:NO];
    [_profileTableView setShowsHorizontalScrollIndicator:NO];
    [_profileTableView setSectionFooterHeight:CGFLOAT_MIN];
    [_profileTableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_profileTableView];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_profileTableView superView:self.view];
}

- (void)createHeadButtonView{

    UIButton *popButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [popButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [popButton setImage:[UIImage imageNamed:@"C-BackIcon-White"] forState:UIControlStateNormal];
    [popButton addTarget:self action:@selector(popClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:popButton];
    
    [JOAutoLayout autoLayoutWithTopSpaceDistance:20. selfView:popButton superView:self.view];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:10. selfView:popButton superView:self.view];
    [JOAutoLayout autoLayoutWithSize:JOSize(30., 30.) selfView:popButton superView:self.view];
    
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [settingButton setImage:[UIImage imageNamed:@"PH-SettingIcon-White"] forState:UIControlStateNormal];
    [settingButton addTarget:self action:@selector(settingButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingButton];
    
    [JOAutoLayout autoLayoutWithTopSpaceDistance:20. selfView:settingButton superView:self.view];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-10. selfView:settingButton superView:self.view];
    [JOAutoLayout autoLayoutWithSize:JOSize(30., 30.) selfView:settingButton superView:self.view];
}

- (CGFloat)getHeadHeight{

    CGFloat headImageViewHeight = View_Width(self.view) - kHostProfileViewHeadLeftSpaceDistance - kHostProfileViewHeadRightSpaceDistance;
    
    UILabel *label1 = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Host_Head_Nick]];
    [label1 setText:@" "];
    CGFloat height1 = [label1 sizeThatFits:JOMAXSize].height;
    
    UILabel *label2 = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Host_Head_Summary]];
    [label2 setText:@" "];
    CGFloat height2 = [label2 sizeThatFits:JOMAXSize].height;
    
    return kHostProfileViewHeadTopSpaceDistance + headImageViewHeight + 28. + height1 + 7. + height2 + 28.;
}

- (void)createHeadView{
    
    self.meHeadView = [[UIView alloc] initWithFrame:CGRectMake(0., 0., self.view.frame.size.width, [self getHeadHeight])];
    [_meHeadView setBackgroundColor:[UIColor clearColor]];
    
    CGFloat headImageViewWidth = View_Width(self.view) - kHostProfileViewHeadLeftSpaceDistance - kHostProfileViewHeadRightSpaceDistance;
    self.headImageView = [UIImageView newAutoLayoutView];
    [[_headImageView layer] setCornerRadius:headImageViewWidth/2.];
    [[_headImageView layer] setMasksToBounds:YES];
    [_meHeadView addSubview:_headImageView];
    
    self.nickNameLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Host_Head_Nick]];
    [_nickNameLabel setTextAlignment:NSTextAlignmentCenter];
    [_nickNameLabel setText:@" "];
    [_meHeadView addSubview:_nickNameLabel];
    
    self.summaryLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Host_Head_Summary]];
    [_summaryLabel setText:@" "];
    [_summaryLabel setTextAlignment:NSTextAlignmentCenter];
    [_meHeadView addSubview:_summaryLabel];
    
    [JOAutoLayout autoLayoutWithTopSpaceDistance:kHostProfileViewHeadTopSpaceDistance selfView:_headImageView superView:_meHeadView];
//    [JOAutoLayout autoLayoutWithCenterXWithView:_meHeadView selfView:_headImageView superView:_meHeadView];
//    [JOAutoLayout autoLayoutWithSize:JOSize(headImageViewWidth, headImageViewWidth) selfView:_headImageView superView:_meHeadView];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:kHostProfileViewHeadLeftSpaceDistance selfView:_headImageView superView:_meHeadView];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-kHostProfileViewHeadRightSpaceDistance selfView:_headImageView superView:_meHeadView];
    [JOAutoLayout autoLayoutWithWidthEqualHeightWithselfView:_headImageView superView:_meHeadView];
    
    [JOAutoLayout autoLayoutWithTopView:_headImageView distance:28. selfView:_nickNameLabel superView:_meHeadView];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:20. selfView:_nickNameLabel superView:_meHeadView];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-20. selfView:_nickNameLabel superView:_meHeadView];
    [JOAutoLayout autoLayoutWithHeight:[_nickNameLabel sizeThatFits:JOMAXSize].height selfView:_nickNameLabel superView:_meHeadView];
    
    [JOAutoLayout autoLayoutWithTopView:_nickNameLabel distance:7. selfView:_summaryLabel superView:_meHeadView];
    [JOAutoLayout autoLayoutWithHeight:[_summaryLabel sizeThatFits:JOMAXSize].height selfView:_summaryLabel superView:_meHeadView];
    [JOAutoLayout autoLayoutWithLeftXView:_nickNameLabel selfView:_summaryLabel superView:_meHeadView];
    [JOAutoLayout autoLayoutWithRightXView:_nickNameLabel selfView:_summaryLabel superView:_meHeadView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Action

- (void)popClick{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)settingButtonClick{

    MIASettingViewController *settingViewController = [MIASettingViewController new];
    [settingViewController setMaskImage:[UIImage JOImageWithView:self.view]];
    @weakify(self);
    [settingViewController settingDataChangeHandler:^{
        @strongify(self);
        [self.summaryLabel setText:[HXUserSession session].user.bio];
        [self.nickNameLabel setText:[HXUserSession session].user.nickName];
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[HXUserSession session].user.avatarUrl] placeholderImage:[UIImage imageNamed:@"PH-DefaultAvatar"]];
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:[HXUserSession session].user.avatarUrl]
                               placeholderImage:[UIImage imageNamed:@"PH-DefaultAvatar"]
                                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                          
                                          [self.coverImageView setImage:[image blurredImageWithRadius:8.0f iterations:8 tintColor:[UIColor blackColor]]];
                                      }];
    }];
    [self.navigationController pushViewController:settingViewController animated:YES];
}

#pragma mark - view mode

- (void)viewUpdate{

    [self showHUD];
    [_hostProfileViewModel.fetchCommand execute:nil];
    @weakify(self);
    [_hostProfileViewModel.viewUpdateSignal subscribeError:^(NSError *error) {
        [self hiddenHUD];
    } completed:^{
    @strongify(self);
        [self hiddenHUD];
        [self.profileTableView reloadData];
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:self.hostProfileViewModel.hostProfileModel.userpic]
                               placeholderImage:[UIImage imageNamed:@"PH-DefaultAvatar"]
                                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                      
                                          [self.coverImageView setImage:[image blurredImageWithRadius:8.0f iterations:8 tintColor:[UIColor blackColor]]];
                                      }];
        
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.hostProfileViewModel.hostProfileModel.userpic] placeholderImage:[UIImage imageNamed:@"PH-DefaultAvatar"]];
        [self.nickNameLabel setText:self.hostProfileViewModel.hostProfileModel.nick];
        [self.summaryLabel setText:self.hostProfileViewModel.hostProfileModel.bio];
    }];
}

#pragma mark - table data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [_hostProfileViewModel.hostProfileDataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        //关注的人
        NSInteger followCount = 1;
        if ([[_hostProfileViewModel.hostProfileDataArray objectAtIndex:section] isKindOfClass:[NSArray class]]) {
            followCount = [[_hostProfileViewModel.hostProfileDataArray objectAtIndex:section] count];
        }
        return followCount;
    }
    
    if (section == 2) {
        //打赏的专辑
        NSInteger rewardAlbumCount = 1;
        if ([[_hostProfileViewModel.hostProfileDataArray objectAtIndex:section] isKindOfClass:[NSArray class]]) {
            rewardAlbumCount = [[_hostProfileViewModel.hostProfileDataArray objectAtIndex:section] count];
        }
        return rewardAlbumCount;
    }
    return [[_hostProfileViewModel.hostProfileDataArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MIABaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    MIACellType cellType;
    
    if (indexPath.section == 0) {
        //M币 消费记录
        cellType = MIACellTypeHostNormal;
    }else if (indexPath.section == 1){
        //关注的人
        if ([[_hostProfileViewModel.hostProfileDataArray objectAtIndex:indexPath.section] isKindOfClass:[NSArray class]]){
            cellType = MIACellTypeHostAttention;
        }else{
            cellType = MIACellTypeNormal;
        }
        
    }else if (indexPath.section == 2){
        //打赏过的专辑
        if ([[_hostProfileViewModel.hostProfileDataArray objectAtIndex:indexPath.section] isKindOfClass:[NSArray class]]){
            cellType = MIACellTypeHostRewardAlbum;
        }else{
            cellType = MIACellTypeNormal;
        }
        
    }else{
        cellType = MIACellTypeHostNormal;
    }
    
    if (!cell) {
        cell = [MIACellManage getCellWithType:cellType];
        [cell setCellWidth:View_Width(self.view)];
    }

    if (indexPath.section == 0) {
        
        id cellData = [[_hostProfileViewModel.hostProfileDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        if (indexPath.row == 0) {
            [(MIASettingCell *)cell setCellTitleAttributedText:[cellData JOAttributedStringwithMarkString:@"(充值)"
                                                                                                    markFont:[UIFont systemFontOfSize:16]
                                                                                                   markColor:[UIColor grayColor]]];
        }else{
            [(MIASettingCell *)cell setSettingCellTitle:cellData contnet:@""];
        }
        
        [(MIASettingCell *)cell setCellAccessoryImage:[UIImage imageNamed:@"C-ArrowIcon-Right-Gray"]];
    }else if(indexPath.section == 1){
    
        if (![[_hostProfileViewModel.hostProfileDataArray objectAtIndex:indexPath.section] isKindOfClass:[NSArray class]]) {
            [[cell textLabel] setText:@"还没有关注的人"];
            [[cell textLabel] setFont:[MIAFontManage getFontWithType:MIAFontType_Host_Attention_Empty]->font];
            [[cell textLabel] setTextColor:[MIAFontManage getFontWithType:MIAFontType_Host_Attention_Empty]->color];
            [[cell textLabel] setTextAlignment:NSTextAlignmentCenter];
            [cell setBackgroundColor:JORGBCreate(0., 0., 0, 0.4)];
            [cell.contentView setBackgroundColor:[UIColor clearColor]];
            [cell.cellContentView  setBackgroundColor:[UIColor clearColor]];
        }else{
            id cellData = [[_hostProfileViewModel.hostProfileDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            [cell setCellData:cellData];
            [(MIAHostAttentionCell *)cell setHostAttentionTopState:indexPath.row];
        }
        
    }else if (indexPath.section == 2){
    
        if (![[_hostProfileViewModel.hostProfileDataArray objectAtIndex:indexPath.section] isKindOfClass:[NSArray class]]) {
            [[cell textLabel] setText:@"还没有打赏的专辑"];
            [[cell textLabel] setFont:[MIAFontManage getFontWithType:MIAFontType_Host_Attention_Empty]->font];
            [[cell textLabel] setTextColor:[MIAFontManage getFontWithType:MIAFontType_Host_Attention_Empty]->color];
            [[cell textLabel] setTextAlignment:NSTextAlignmentCenter];
            [cell setBackgroundColor:JORGBCreate(0., 0., 0, 0.4)];
            [cell.contentView setBackgroundColor:[UIColor clearColor]];
            [cell.cellContentView  setBackgroundColor:[UIColor clearColor]];
        }else{
            id cellData = [[_hostProfileViewModel.hostProfileDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            [cell setCellData:cellData];
        }
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        //头部
        return _meHeadView;
    }else if(section == 1){
        //关注的人
        
        return [MIABaseCellHeadView cellHeadViewWithImage:[UIImage imageNamed:@"PH-AttentionIcon"]
                                                    title:[NSString stringWithFormat:@"关注 %@",self.hostProfileViewModel.hostProfileModel.followCnt]
                                                 tipTitle:nil
                                                    frame:CGRectMake(0., 0., View_Width(self.view), kBaseCellHeadViewHeight)
                                             imageOffsetX:-3
                                            cellColorType:BaseCellHeadColorTypeBlack];
        
    }else if (section == 2){
        //打赏的专辑
        return [MIABaseCellHeadView cellHeadViewWithImage:[UIImage imageNamed:@"PH-RewardAlbumIcon"]
                                                    title:@"打赏的专辑"
                                                 tipTitle:nil
                                                    frame:CGRectMake(0., 0., View_Width(self.view), kBaseCellHeadViewHeight)
                                            cellColorType:BaseCellHeadColorTypeBlack];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return [self getHeadHeight];
    }else if (section == 1){
    
        return kBaseCellHeadViewHeight;
    }else if (section == 2){
    
        return kBaseCellHeadViewHeight;
    }
    return kBaseCellHeadViewHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return kHostProfileViewDefaultCellHeight;
    }else if(indexPath.section == 1){
        
        return [MIAHostProfileViewModel hostProfileAttentionCellHeightWitWidth:View_Width(self.view) topState:indexPath.row];
    }else if (indexPath.section == 2){
        
        return [MIAHostProfileViewModel hostProfileRewardAlbumCellHeightWithWidth:View_Width(self.view)];
    }else{
        
        return kHostProfileViewDefaultCellHeight;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return CGFLOAT_MIN;
}

#pragma mark - table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //充值
            MIAPaymentViewController *paymentViewController = [MIAPaymentViewController new];
            [self.navigationController pushViewController:paymentViewController animated:YES];
        }else if (indexPath.row == 1){
            //购买记录
            MIAPayHistoryViewController *payHistoryViewController = [MIAPayHistoryViewController new];
            [self.navigationController pushViewController:payHistoryViewController animated:YES];
            
//            MIAIncomeViewController *incomeViewController = [MIAIncomeViewController new];
//            [self.navigationController pushViewController:incomeViewController animated:YES];
        }else if (indexPath.row == 2){
            //我的收益
            MIAIncomeViewController *incomeViewController = [MIAIncomeViewController new];
            [self.navigationController pushViewController:incomeViewController animated:YES];
        }
    }
}

@end
