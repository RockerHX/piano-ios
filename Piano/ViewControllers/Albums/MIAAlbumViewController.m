//
//  MIAAlbumViewController.m
//  Piano
//
//  Created by 刘维 on 16/5/11.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAAlbumViewController.h"
#import "MIAAlbumRewardViewController.h"
#import "UIImageView+WebCache.h"
#import "UIViewController+HXClass.h"
#import "MIAAlbumBarView.h"
#import "MIAAlbumDetailView.h"
#import "MIAAlbumEnterCommentView.h"
#import "MIABaseCellHeadView.h"
#import "MIAAlbumViewModel.h"
#import "MIACellManage.h"
#import "FXBlurView.h"
#import "JOBaseSDK.h"

@interface MIAAlbumViewController()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIImageView *maskImageView;

@property (nonatomic, strong) MIAAlbumBarView *albumBarView;
@property (nonatomic, strong) UITableView *albumTableView;
@property (nonatomic, strong) MIAAlbumDetailView *albumTableHeadView;
@property (nonatomic, strong) MIAAlbumEnterCommentView *enterCommentView;

@property (nonatomic, strong) MIAAlbumViewModel *albumViewModel;


@end

@implementation MIAAlbumViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)loadView{

    [super loadView];
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    [self createCoverImageView];
    
    [self loadViewModel];
    [self createAlbumBarView];
    [self createAlbumEnterCommentView];
    [self createAlbumTableHeadView];
    [self createAlbumTableView];
}

- (void)createCoverImageView{

    self.coverImageView = [UIImageView newAutoLayoutView];
    [self.view addSubview:_coverImageView];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_coverImageView superView:self.view];

    self.maskImageView = [UIImageView newAutoLayoutView];
    [_maskImageView setImage:[UIImage imageNamed:@"PR-MaskBG"]];
    [self.view addSubview:_maskImageView];
    
    [JOAutoLayout autoLayoutWithSameView:_coverImageView selfView:_maskImageView superView:self.view];
}

- (void)loadViewModel{

    self.albumViewModel = [[MIAAlbumViewModel alloc] initWithUid:_albumUID];
    RACSignal *fetchSignal = [_albumViewModel.fetchCommand execute:nil];
    
    [self showHUD];
    
    @weakify(self);
    [fetchSignal subscribeError:^(NSError *error) {
    @strongify(self);
        [self hiddenHUD];
        
        if (![error.domain isEqualToString:RACCommandErrorDomain]) {
            [self showBannerWithPrompt:error.domain];
        }
        
    } completed:^{
    @strongify(self);
        [self hiddenHUD];
        //更新视图的数据
        [self.albumTableView reloadData];
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:self.albumViewModel.albumModel.coverUrl]
                               placeholderImage:nil
                                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.coverImageView.image = [image blurredImageWithRadius:5.0f iterations:5 tintColor:[UIColor whiteColor]];
        }];
//        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:self.albumViewModel.albumModel.coverUrl] placeholderImage:nil];
        [self.albumTableHeadView setAlbumHeadDetailData:self.albumViewModel.albumModel];
    }];
}

- (void)createAlbumBarView{

    self.albumBarView = [MIAAlbumBarView newAutoLayoutView];
    @weakify(self);
    [_albumBarView popActionHandler:^{
    @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:_albumBarView];
    
    [JOAutoLayout autoLayoutWithTopSpaceDistance:20. selfView:_albumBarView superView:self.view];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_albumBarView superView:self.view];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_albumBarView superView:self.view];
    [JOAutoLayout autoLayoutWithHeight:kAlbumBarViewHeight selfView:_albumBarView superView:self.view];
}

- (void)createAlbumEnterCommentView{

    self.enterCommentView  = [MIAAlbumEnterCommentView newAutoLayoutView];
    @weakify(self);
    [_enterCommentView keyBoardShowHandler:^(CGFloat height) {
    @strongify(self);
        
        [JOAutoLayout removeAutoLayoutWithBottomSelfView:self.enterCommentView superView:self.view];
        [JOAutoLayout autoLayoutWithBottomSpaceDistance:-height selfView:self.enterCommentView superView:self.view];
        
        [UIView animateWithDuration:0.5 animations:^{
            [self.albumTableView layoutIfNeeded];
            [self.enterCommentView layoutIfNeeded];
        }];
    }];
    
    [_enterCommentView textViewHeightChangeHandler:^(CGFloat textViewHeight,BOOL enableState) {
    @strongify(self);
        
        CGFloat tempHeight = 36.;
        
        CGFloat addHeight = textViewHeight - tempHeight;
//        NSLog(@"addHeight:%f",addHeight);
        
//        [self.enterCommentView updateTextViewWithEnableState:enableState];
            [JOAutoLayout removeAutoLayoutWithHeightSelfView:self.enterCommentView superView:self.view];
            [JOAutoLayout autoLayoutWithHeight:kAlbumEnterCommentViewHeight+addHeight selfView:self.enterCommentView superView:self.view];
        
        [self.enterCommentView updateTextViewWithEnableState:enableState];
        
    }];
    [self.view addSubview:_enterCommentView];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_enterCommentView superView:self.view];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_enterCommentView superView:self.view];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_enterCommentView superView:self.view];
    [JOAutoLayout autoLayoutWithHeight:kAlbumEnterCommentViewHeight selfView:_enterCommentView superView:self.view];
}

- (void)createAlbumTableView{

    self.albumTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_albumTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_albumTableView setBackgroundColor:[UIColor clearColor]];
    [_albumTableView setDataSource:self];
    [_albumTableView setDelegate:self];
    [_albumTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_albumTableView setSectionFooterHeight:CGFLOAT_MIN];
    [self.view addSubview:_albumTableView];
    
    [JOAutoLayout autoLayoutWithTopView:_albumBarView distance:0. selfView:_albumTableView superView:self.view];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_albumTableView superView:self.view];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_albumTableView superView:self.view];
    [JOAutoLayout autoLayoutWithBottomView:_enterCommentView distance:0. selfView:_albumTableView superView:self.view];
}

- (void)createAlbumTableHeadView{

    self.albumTableHeadView = [[MIAAlbumDetailView alloc] init];
    @weakify(self);
    [_albumTableHeadView rewardAlbumButtonClickHanlder:^{
    @strongify(self);
        MIAAlbumRewardViewController *rewardViewController = [MIAAlbumRewardViewController new];
        [rewardViewController setAlbumModel:self.albumViewModel.albumModel];
        [self.navigationController presentViewController:rewardViewController animated:YES completion:^{
            
        }];
    }];
    [_albumTableHeadView setFrame:CGRectMake(0., 0., View_Width(self.view), [_albumTableHeadView albumDetailViewHeight])];
    
}

#pragma mark - table data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [_albumViewModel.cellDataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[_albumViewModel.cellDataArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MIABaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    MIACellType cellType;
    
    if (indexPath.section == 0) {
        cellType = MIACellTypeAlbumSong;
    }else{
    
        cellType = MIACellTypeAlbumComment;
    }
    
    if (!cell) {
        
        cell = [MIACellManage getCellWithType:cellType];
        [cell setCellWidth:View_Width(self.view)];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    [[cell textLabel] setText:@"text"];
    [cell setCellData:[[_albumViewModel.cellDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        
        return _albumTableHeadView;
    }else if (section == 1){
    
        return [MIABaseCellHeadView cellHeadViewWithImage:nil
                                                    title:@"评论 3"
                                                 tipTitle:nil
                                                    frame:CGRectMake(0., 0., View_Width(self.view), kBaseCellHeadViewHeight)
                                            cellColorType:BaseCellHeadColorTypeWhiter];
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        
        return [_albumTableHeadView albumDetailViewHeight];
    }else{
    
        return kBaseCellHeadViewHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 50.;
    }else{
        return 70.;
    }
    return 50.;
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return CGFLOAT_MIN;
}

#pragma mark - table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - Scroll delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    [_enterCommentView resignTextViewFirstResponder];
}

@end
