//
//  MIAProfileViewController.m
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAProfileViewController.h"
#import "MIAProfileLiveCell.h"
#import "MIAProfileAlbumCell.h"
#import "MIAProfileVideoCell.h"
#import "MIAProfileReplayCell.h"
#import "MIAProfileHeadView.h"
#import "MIABaseCellHeadView.h"
#import "JOBaseSDK.h"

static CGFloat const kProfileHeadViewHeight = 500.;

@interface MIAProfileViewController()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) MIAProfileHeadView *profileHeadView;
@property (nonatomic, strong) UITableView *profileTableView;

@end

@implementation MIAProfileViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)loadView{

    [super loadView];
    
    [self createProfileHeadView];
    [self createProfileTableView];
}

- (void)createProfileHeadView{

    self.profileHeadView = [MIAProfileHeadView newAutoLayoutView];
    [self.view addSubview:_profileHeadView];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_profileHeadView superView:self.view];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_profileHeadView superView:self.view];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_profileHeadView superView:self.view];
    [JOAutoLayout autoLayoutWithHeight:kProfileHeadViewHeight selfView:_profileHeadView superView:self.view];
    
    [_profileHeadView setProfileHeadImageURL:@"" name:@"小出家人" summary:@"色即是空,空即是色"];
    [_profileHeadView setProfileFans:@"1" attention:@"43" attentionState:YES];
}

- (void)createProfileTableView{

    self.profileTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_profileTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_profileTableView setBackgroundColor:[UIColor clearColor]];
    [_profileTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_profileTableView setSectionFooterHeight:CGFLOAT_MIN];
    [_profileTableView setDataSource:self];
    [_profileTableView setDelegate:self];
    [self.view addSubview:_profileTableView];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_profileTableView superView:self.view];
}

#pragma mark - table data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MIABaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        if (indexPath.section == 0) {
            //直播
            cell = [[MIAProfileLiveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"0cell"];
            [cell setCellWidth:View_Width(self.view)];
        }else if (indexPath.section == 1){
            //专辑
            cell = [[MIAProfileAlbumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"0cell"];
            [cell setCellWidth:View_Width(self.view)];
        }else if (indexPath.section == 2){
        
            //视频
            cell = [[MIAProfileVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"0cell"];
            [cell setCellWidth:View_Width(self.view)];
        }else if (indexPath.section == 3){
        
            //直播回放
            cell = [[MIAProfileReplayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"0cell"];
            [cell setCellWidth:View_Width(self.view)];
        }
        else{
        
            cell = [[MIABaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"0cell"];
        }
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    [cell setCellData:nil];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return kProfileHeadViewHeight + kBaseCellHeadViewHeight;
    }
    return kBaseCellHeadViewHeight ;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        
        return [MIABaseCellHeadView cellHeadViewWithImage:[UIImage imageNamed:@"PR-AlbumIcon"]
                                                    title:@"正在直播"
                                                 tipTitle:@"12124235人观看"
                                                    frame:CGRectMake(0., 0., View_Width(self.view), kProfileHeadViewHeight + kBaseCellHeadViewHeight)
                                            cellColorType:BaseCellHeadColorTypeSpecial];
    }else if (section == 1){
    
        return [MIABaseCellHeadView cellHeadViewWithImage:[UIImage imageNamed:@"PR-AlbumIcon"]
                                                    title:@"专辑"
                                                 tipTitle:nil
                                                    frame:CGRectMake(0., 0., View_Width(self.view), kBaseCellHeadViewHeight)
                                            cellColorType:BaseCellHeadColorTypeWhiter];
    }else if (section == 2){
        
        return [MIABaseCellHeadView cellHeadViewWithImage:[UIImage imageNamed:@"PR-AlbumIcon"]
                                                    title:@"视频"
                                                 tipTitle:nil
                                                    frame:CGRectMake(0., 0., View_Width(self.view), kBaseCellHeadViewHeight)
                                            cellColorType:BaseCellHeadColorTypeWhiter];
    }else if (section == 3){
        
        return [MIABaseCellHeadView cellHeadViewWithImage:[UIImage imageNamed:@"PR-AlbumIcon"]
                                                    title:@"直播回放"
                                                 tipTitle:nil
                                                    frame:CGRectMake(0., 0., View_Width(self.view), kBaseCellHeadViewHeight)
                                            cellColorType:BaseCellHeadColorTypeWhiter];
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        //直播
        return 100.;
    }else if (indexPath.section == 1){
        //专辑
        return 150.;
    }else if (indexPath.section == 2){
        //专辑
        return 120.;
    }else if (indexPath.section == 3){
        //专辑
        return 210.;
    }
    return 100.;
}

#pragma mark - table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    [_profileHeadView setProfileMaskAlpha:scrollView.contentOffset.y/kProfileHeadViewHeight];
}

@end
