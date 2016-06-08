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
//#import "MJ"
#import "UIViewController+HXClass.h"
#import "MIAAlbumBarView.h"
#import "MIAAlbumDetailView.h"
#import "MIAAlbumEnterCommentView.h"
#import "MIABaseCellHeadView.h"
#import "MIAAlbumViewModel.h"
#import "MIACommentModel.h"
#import "HXSongModel.h"
#import "MIACellManage.h"
#import "FXBlurView.h"
#import "JOBaseSDK.h"
#import "MJRefresh.h"

#import "MIASongManage.h"


@interface MIAAlbumViewController()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIImageView *maskImageView;

@property (nonatomic, strong) MIAAlbumBarView *albumBarView;
@property (nonatomic, strong) UITableView *albumTableView;
@property (nonatomic, strong) MIAAlbumDetailView *albumTableHeadView;
@property (nonatomic, strong) MIAAlbumEnterCommentView *enterCommentView;

@property (nonatomic, strong) MIAAlbumViewModel *albumViewModel;

@property (nonatomic, strong) HXSongModel *playSongModel;
@property (nonatomic, assign) NSInteger playSongIndex;

@end

@implementation MIAAlbumViewController

- (void)dealloc{
    
    if (_rewardType == MIAAlbumRewardTypeMyReward) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kMIASongDownloadFinishedNoticeKey object:nil];
    }
    
    [_enterCommentView removeKeyBoardShowObbserve];
}

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
    
    if (_rewardType == MIAAlbumRewardTypeMyReward) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSongSection) name:kMIASongDownloadFinishedNoticeKey object:nil];
    }
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
    [self fetchAlbumData];
}

- (void)createAlbumBarView{

    self.albumBarView = [MIAAlbumBarView newAutoLayoutView];
    @weakify(self);
    [_albumBarView popActionHandler:^{
    @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:_albumBarView];
    
    [JOAutoLayout autoLayoutWithTopSpaceDistance:10. selfView:_albumBarView superView:self.view];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_albumBarView superView:self.view];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_albumBarView superView:self.view];
    [JOAutoLayout autoLayoutWithHeight:kAlbumBarViewHeight selfView:_albumBarView superView:self.view];
}

- (void)createAlbumEnterCommentView{

    self.enterCommentView  = [MIAAlbumEnterCommentView newAutoLayoutView];
    @weakify(self);
    
    //键盘出现的Block
    [_enterCommentView keyBoardShowHandler:^(CGFloat height) {
    @strongify(self);
        
        [JOAutoLayout removeAutoLayoutWithBottomSelfView:self.enterCommentView superView:self.view];
        [JOAutoLayout autoLayoutWithBottomSpaceDistance:-height selfView:self.enterCommentView superView:self.view];
        
        [UIView animateWithDuration:0.5 animations:^{
            [self.albumTableView layoutIfNeeded];
            [self.enterCommentView layoutIfNeeded];
        }];
    }];
    
    //输入框高度发生变化
    [_enterCommentView textViewHeightChangeHandler:^(CGFloat textViewHeight) {
    @strongify(self);
    
        [JOAutoLayout removeAutoLayoutWithHeightSelfView:self.enterCommentView superView:self.view];
        [JOAutoLayout autoLayoutWithHeight:textViewHeight+20. selfView:self.enterCommentView superView:self.view];

    }];
    
    //发送按钮点击的Block
    [_enterCommentView sendAlbumCommentHanlder:^(NSString *commentConent) {
    @strongify(self);
        [self sendAlbumCommentWithContent:commentConent];
        
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
    if (_rewardType == MIAAlbumRewardTypeNormal) {
        [_albumTableView setMj_footer:[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(fetchMoreCommentList)]];
    }
    [self.view addSubview:_albumTableView];
    
    [JOAutoLayout autoLayoutWithTopView:_albumBarView distance:0. selfView:_albumTableView superView:self.view];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_albumTableView superView:self.view];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_albumTableView superView:self.view];
    
    if (_rewardType == MIAAlbumRewardTypeNormal) {
        [JOAutoLayout autoLayoutWithBottomView:_enterCommentView distance:0. selfView:_albumTableView superView:self.view];
    }else{
        [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_albumTableView superView:self.view];
        [_enterCommentView setHidden:YES];
    }
}

- (void)createAlbumTableHeadView{

    self.albumTableHeadView = [[MIAAlbumDetailView alloc] init];
    @weakify(self);
    //打赏按钮点击Block
    [_albumTableHeadView rewardAlbumButtonClickHanlder:^(RewardAlbumActionType type) {
     @strongify(self);
        if (type == RewardAlbumActionType_Reward) {
            
            MIAAlbumRewardViewController *rewardViewController = [MIAAlbumRewardViewController new];
            [rewardViewController setAlbumModel:self.albumViewModel.albumModel];
            //        [self.navigationController presentViewController:rewardViewController animated:YES completion:^{
            //
            //        }];
            [self.navigationController pushViewController:rewardViewController animated:YES];
        }else{
        
            NSArray *songModelArray = [self.albumViewModel.cellDataArray firstObject];
            NSMutableArray *songURLArray = [NSMutableArray array];
            for(HXSongModel *model in songModelArray){
                
                [songURLArray addObject:model.mp3Url];
            }
            
            [[MIASongManage shareSongManage] startDownloadSongWithURLArray:songURLArray];
        }
        
    }];
    
    //播放歌曲发生改变的时候Block
    [_albumTableHeadView playSongChangeHandler:^(HXSongModel *songModel, NSInteger songIndex) {
    @strongify(self);
        self.playSongModel = nil;
        self.playSongModel = songModel;
        
        self.playSongIndex = songIndex;
        
        [self.albumTableView reloadData];
//        [self.albumTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    }];
    [_albumTableHeadView setFrame:CGRectMake(0., 0., View_Width(self.view), [_albumTableHeadView albumDetailViewHeight])];
    
    if (_rewardType == MIAAlbumRewardTypeMyReward) {
        [_albumTableHeadView setAlbumRewardState:YES];
    }
}

//是否需要添加Footer的上拉拉取更过评论的事件
- (void)addTableViewFooterRefersh{

    if ([self.albumViewModel.cellDataArray count] == 2 && [[self.albumViewModel.cellDataArray lastObject] count] < self.albumViewModel.commentCount) {

//        [self.albumTableView.mj_footer resetNoMoreData];
        if ([self.albumTableView.mj_footer isRefreshing]) {
            [self.albumTableView.mj_footer endRefreshing];
        }
        
    }else{
    
        [self.albumTableView.mj_footer endRefreshingWithNoMoreData];
        [self.albumTableView.mj_footer setHidden:YES];
    }
}

#pragma mark - song section update

- (void)updateSongSection{

    [_albumTableHeadView setAlbumSongModelData:self.albumViewModel.cellDataArray.firstObject];
    [_albumTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - RACSinger 

//拉取专辑的数据
- (void)fetchAlbumData{

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
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:self.albumViewModel.albumModel.coverUrl]
                               placeholderImage:nil
                                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                          self.coverImageView.image = [image blurredImageWithRadius:5.0f iterations:5 tintColor:[UIColor whiteColor]];
                                      }];
        [self.albumBarView setAlbumName:self.albumViewModel.albumModel.title singerName:self.albumViewModel.albumModel.nick];
        [self.albumTableHeadView setAlbumHeadDetailData:self.albumViewModel.albumModel];
        [self.albumTableHeadView setAlbumSongModelData:self.albumViewModel.cellDataArray.firstObject];
        
        [self.albumTableView reloadData];
        [self addTableViewFooterRefersh];
    }];
}

//发送评论
- (void)sendAlbumCommentWithContent:(NSString *)content{

    [self.enterCommentView resignTextViewFirstResponder];
    
    RACSignal *sendCommentSingnal = [self.albumViewModel sendCommentWithContent:content albumID:self.albumUID commentID:@""];
    
    [self showHUD];
    [sendCommentSingnal subscribeError:^(NSError *error) {
        
        [self hiddenHUD];
        if (![error.domain isEqualToString:RACCommandErrorDomain]) {
            [self showBannerWithPrompt:error.domain];
        }
    } completed:^{
        
        [self hiddenHUD];
        [self showBannerWithPrompt:@"评论发送成功"];
        [self.enterCommentView cleanTextView];
        //从新拉取评论列表重新更新列表
        [self fetchAlbumCommentList];
    }];
}

- (void)fetchAlbumCommentList{

    RACSignal *fetchCommentSingnal = [self.albumViewModel getCommentListWithAlbumID:self.albumUID lastCommentID:@""];
    [self showHUD];
    [fetchCommentSingnal subscribeError:^(NSError *error) {
        [self hiddenHUD];
        if (![error.domain isEqualToString:RACCommandErrorDomain]) {
            [self showBannerWithPrompt:error.domain];
        }
        
    } completed:^{
        [self hiddenHUD];
        //更新评论的Section的数据
        [self.albumTableView reloadData];
        [self addTableViewFooterRefersh];
    }];
}

- (void)fetchMoreCommentList{

    RACSignal *fetchCommentSingnal = [self.albumViewModel getCommentListWithAlbumID:self.albumUID lastCommentID:[(MIACommentModel *)[[self.albumViewModel.cellDataArray lastObject] lastObject] id]];
    [self showHUD];
    [fetchCommentSingnal subscribeError:^(NSError *error) {
        [self hiddenHUD];
        if (![error.domain isEqualToString:RACCommandErrorDomain]) {
            [self showBannerWithPrompt:error.domain];
        }
        
    } completed:^{
        [self hiddenHUD];
        //更新评论的Section的数据
        [self.albumTableView reloadData];
        [self addTableViewFooterRefersh];
    }];
}

#pragma mark - table data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_rewardType == MIAAlbumRewardTypeNormal) {
    
        return [_albumViewModel.cellDataArray count];
    }else{
    
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([_albumViewModel.cellDataArray count]) {
        return [[_albumViewModel.cellDataArray objectAtIndex:section] count];
    }else{
    
        return 0;
    }
    
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
    [cell setCellData:[[_albumViewModel.cellDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    
    if (indexPath.section == 0) {
        //歌曲Section

        if (indexPath.row == _playSongIndex && _playSongModel) {
            [(MIAAlbumSongCell *)cell setSongPlayState:YES];
        }else{
        
            [(MIAAlbumSongCell *)cell setSongPlayState:NO];
        }
        
         [(MIAAlbumSongCell *)cell setSongCellIndex:indexPath.row+1];
        
        if (_rewardType == MIAAlbumRewardTypeMyReward) {
            //打开下载的状态提示
            [(MIAAlbumSongCell *)cell openSongDownloadState];
        }
        
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        
        return _albumTableHeadView;
    }else if (section == 1){
    
        return [MIABaseCellHeadView cellHeadViewWithImage:nil
                                                    title:[NSString stringWithFormat:@"评论 %ld",(long)_albumViewModel.commentCount]
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
        return kAlbumSongCellHeight;
    }else{
        
        return MAX(kAlbumComentCellDefaultHeight, [_albumViewModel commentCellHeightWithIndex:indexPath.row viewWidth:View_Width(self.view)]);
    }
    return 50.;
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return CGFLOAT_MIN;
}

#pragma mark - table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        //歌曲的section处理,播放当前的歌曲
        [_albumTableHeadView playAlbumSongWithIndex:indexPath.row];
    }else if (indexPath.section == 1){
        //评论的点击
        
    }
}

#pragma mark - Scroll delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    [_enterCommentView resignTextViewFirstResponder];
}

@end
