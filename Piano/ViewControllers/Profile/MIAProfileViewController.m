//
//  MIAProfileViewController.m
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAProfileViewController.h"
#import "UIViewController+HXClass.h"
#import "MIACellManage.h"
#import "MIAProfileLiveCell.h"
#import "MIAProfileAlbumCell.h"
#import "MIAProfileVideoCell.h"
#import "MIAProfileReplayCell.h"
#import "MIAProfileHeadView.h"
#import "MIABaseCellHeadView.h"
#import "MBProgressHUDHelp.h"
#import "JOBaseSDK.h"

#import "MIAProfileViewModel.h"

@interface MIAProfileViewController()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) MIAProfileViewModel *profileViewModel;

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
    
     self.profileViewModel = [[MIAProfileViewModel alloc] initWithUID:@"112"];
    [self loadViewModels];
}

- (void)createProfileHeadView{

    self.profileHeadView = [MIAProfileHeadView newAutoLayoutView];
    [self.view addSubview:_profileHeadView];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_profileHeadView superView:self.view];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_profileHeadView superView:self.view];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_profileHeadView superView:self.view];
    [JOAutoLayout autoLayoutWithHeight:kProfileHeadViewHeight selfView:_profileHeadView superView:self.view];
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

#pragma mark - view models

- (void)loadViewModels{
    [self showHUD];
    @weakify(self)
    RACSignal *fetchSignal = [_profileViewModel.fetchCommand execute:nil];
    [fetchSignal subscribeError:^(NSError *error) {
        @strongify(self)
        [self hiddenHUD];
        if (![error.domain isEqualToString:RACCommandErrorDomain]) {
            [self showBannerWithPrompt:error.domain];
        }
    } completed:^{
        @strongify(self)
        [self hiddenHUD];
        
        [self updateViews];
    }];
}

- (void)updateViews{

    MIAProfileHeadModel *headModel = _profileViewModel.profileHeadModel;
    [_profileHeadView setProfileHeadImageURL:headModel.avatarURL name:headModel.nickName summary:headModel.summary];
    [_profileHeadView setProfileFans:headModel.fansCount attention:headModel.followCount attentionState:headModel.followState];
    
    [_profileTableView reloadData];
}

#pragma mark - table data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [_profileViewModel.cellDataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[_profileViewModel.cellDataArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MIABaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    MIACellType cellType = ({
        switch ([[_profileViewModel.cellTypes objectAtIndex:indexPath.section] integerValue]) {
            case MIAProfileCellTypeLive:
                cellType = MIACellTypeLive;
                break;
            case MIAProfileCellTypeAlbum:
                cellType = MIACellTypeAlbum;
                break;
            case MIAProfileCellTypeVideo:
                cellType = MIACellTypeVideo;
                break;
            case MIAProfileCellTypeReplay:
                cellType = MIACellTypeReplay;
                break;
            default:
                cellType = MIACellTypeNormal;
                break;
        }
        cellType;
    });
    
    if (!cell) {
        
        cell = [MIACellManage getCellWithType:cellType];
        [cell setCellWidth:View_Width(self.view)];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setCellData:[[_profileViewModel.cellDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return kProfileHeadViewHeight + kBaseCellHeadViewHeight;
    }
    return kBaseCellHeadViewHeight ;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    MIAProfileCellType profileCellType = [[_profileViewModel.cellTypes objectAtIndex:section] integerValue];
    
    BaseCellHeadColorType headColorType ;
    
    if (section == 0) {
        headColorType = BaseCellHeadColorTypeSpecial;
    }else{
    
        headColorType = BaseCellHeadColorTypeWhiter;
    }
    
    if (profileCellType == MIAProfileCellTypeLive) {
        
        return [MIABaseCellHeadView cellHeadViewWithImage:[UIImage imageNamed:@"PR-AlbumIcon"]
                                                    title:@"正在直播"
                                                 tipTitle:@"12124235人观看"
                                                    frame:CGRectMake(0., 0., View_Width(self.view), kProfileHeadViewHeight + kBaseCellHeadViewHeight)
                                            cellColorType:headColorType];
        
    }else if (profileCellType == MIAProfileCellTypeAlbum){
    
        return [MIABaseCellHeadView cellHeadViewWithImage:[UIImage imageNamed:@"PR-AlbumIcon"]
                                                    title:@"专辑"
                                                 tipTitle:nil
                                                    frame:CGRectMake(0., 0., View_Width(self.view), kBaseCellHeadViewHeight)
                                            cellColorType:headColorType];
    }else if (profileCellType == MIAProfileCellTypeVideo){
        
        return [MIABaseCellHeadView cellHeadViewWithImage:[UIImage imageNamed:@"PR-AlbumIcon"]
                                                    title:@"视频"
                                                 tipTitle:nil
                                                    frame:CGRectMake(0., 0., View_Width(self.view), kBaseCellHeadViewHeight)
                                            cellColorType:headColorType];
    }else if (profileCellType == MIAProfileCellTypeReplay){
        
        return  [MIABaseCellHeadView cellHeadViewWithImage:[UIImage imageNamed:@"PR-AlbumIcon"]
                                                     title:@"直播回放"
                                                  tipTitle:nil
                                                     frame:CGRectMake(0., 0., View_Width(self.view), kBaseCellHeadViewHeight)
                                             cellColorType:headColorType];
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    MIAProfileCellType profileCellType = [[_profileViewModel.cellTypes objectAtIndex:indexPath.section] integerValue];
    
    if (profileCellType == MIAProfileCellTypeLive) {
        
        return kProfileLiveCellHeight;
        
    }else if (profileCellType == MIAProfileCellTypeAlbum){
        
        return kProfileAlbumCellHeight;
    }else if (profileCellType == MIAProfileCellTypeVideo){
        
        return kProfileVideoCellHeight;
    }else if (profileCellType == MIAProfileCellTypeReplay){
        
        return  kProfileReplayCellHeight;
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
