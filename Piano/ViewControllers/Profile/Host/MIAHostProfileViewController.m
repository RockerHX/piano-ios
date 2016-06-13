//
//  MIAHostProfileViewController.m
//  Piano
//
//  Created by 刘维 on 16/6/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAHostProfileViewController.h"
#import "MIABaseTableViewCell.h"
#import "MIACellManage.h"
#import "JOBaseSDK.h"
#import "MIAFontManage.h"
#import "UIImageView+WebCache.h"

@interface MIAHostProfileViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIImageView *maskImageView;

@property (nonatomic, strong) UITableView *profileTableView;

@end

@implementation MIAHostProfileViewController

- (void)loadView{

    [super loadView];
    
    [self createProfileTableView];
}

- (void)createBackImageView{

//    self.coverImageView
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
    [self.view addSubview:_profileTableView];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_profileTableView superView:self.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MIABaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    MIACellType cellType;
    
    if (indexPath.section == 0) {
        //M币 消费记录
        cellType = MIACellTypeHostNormal;
    }else if (indexPath.section == 1){
        //关注的人
        cellType = MIACellTypeHostAttention;
    }else if (indexPath.section == 2){
        //打赏过的专辑
        cellType = MIACellTypeHostRewardAlbum;
    }else{
        cellType = MIACellTypeHostNormal;
    }
    
    if (!cell) {
        cell = [MIACellManage getCellWithType:cellType];
        [cell setCellWidth:View_Width(self.view)];
    }
    
    
    if (indexPath.section == 1) {
        
        [cell setCellData:@[@"",@"",@"",@""]];
    }else if (indexPath.section == 2){
    
        [cell setCellData:@[@"",@"",@""]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 50.;
    }else if(indexPath.section == 1){
        
        return 120.;
    }else if (indexPath.section == 2){
        
        return 140.;
    }else{
        
        return 50.;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return CGFLOAT_MIN;
}

#pragma mark - table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

@end
