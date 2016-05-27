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
#import "UIImageView+WebCache.h"
#import "JOBaseSDK.h"

#import "MIAProfileViewModel.h"

//用于选择性的向下传递事件链的左右
static NSInteger const kTableViewTag = 10001;//tableView的tag值
static NSInteger const kHeadViewTag = 10002; //headView的tag值

static CGFloat const kCoverImageWidthHeightRaito = 9./16.;//图片的宽高比.

@interface MIAProfileView : UIView

@end

@implementation MIAProfileView

- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event{

    UIView *hitView = [super hitTest:point withEvent:event];
    
    if ([hitView isKindOfClass:[MIABaseCellHeadView class]]) {
        
        CGPoint tablePoint = [self convertPoint:point toView:[self viewWithTag:kTableViewTag]];
        UIView *view = [[self viewWithTag:kHeadViewTag] viewWithTag:kAttentionButtonTag] ;
        CGPoint headPoint = [self convertPoint:point toView:view];
        
        BOOL buttonState = [view pointInside:headPoint withEvent:nil];
        BOOL state = CGRectContainsPoint(CGRectMake(0., 0., JOScreenSize.width, JOScreenSize.height), tablePoint);
        if (state && buttonState) {
            return [[self viewWithTag:kHeadViewTag] hitTest:point withEvent:event];
        }
    }
    return hitView;
}

@end

@interface MIAProfileViewController()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>{

    CGFloat profileTableHeadViewHeight;
}

@property (nonatomic, strong) MIAProfileViewModel *profileViewModel;

@property (nonatomic, strong) MIAProfileView *profileView;

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIImageView *maskImageView;

@property (nonatomic, strong) MIAProfileHeadView *profileHeadView;
@property (nonatomic, strong) UITableView *profileTableView;

@end

//16:9 高/宽
@implementation MIAProfileViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)loadView{

    [super loadView];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    CGFloat coverImageHeight = View_Width(self.view)/kCoverImageWidthHeightRaito;
    profileTableHeadViewHeight = View_Height(self.view) - kProfileAlbumCellHeight - kBaseCellHeadViewHeight;
    
    self.coverImageView = [UIImageView newAutoLayoutView];
    [self.view addSubview:_coverImageView];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_coverImageView superView:self.view];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_coverImageView superView:self.view];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_coverImageView superView:self.view];
    [JOAutoLayout autoLayoutWithHeight:coverImageHeight selfView:_coverImageView superView:self.view];
    
    self.maskImageView = [UIImageView newAutoLayoutView];
    [_maskImageView setImage:[UIImage imageNamed:@"PR-MaskBG"]];
    [_maskImageView setAlpha:0.];
    [self.view addSubview:_maskImageView];

    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_maskImageView superView:self.view];
    
    self.profileView = [MIAProfileView newAutoLayoutView];
    [_profileView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_profileView];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_profileView superView:self.view];
    
    [self createProfileHeadView];
    [self createProfileTableView];
    [self createPopButton];
    
     self.profileViewModel = [[MIAProfileViewModel alloc] initWithUID:_uid];
    [self loadViewModels];
}

- (void)createProfileHeadView{

    self.profileHeadView = [MIAProfileHeadView newAutoLayoutView];
    @weakify(self);
    [_profileHeadView attentionActionHandler:^(BOOL state){
    @strongify(self);
        [self showHUD];
        RACSignal *attentionSignal = nil;
        
        if (state) {
            attentionSignal = [self.profileViewModel.unAttentionCommand execute:nil];
        }else{
            attentionSignal = [self.profileViewModel.attentionCommand execute:nil];
        }
        
        [attentionSignal subscribeNext:^(id x) {
            [self.profileHeadView setAttentionButtonState:[x boolValue]];
        } error:^(NSError *error) {
           
            [self hiddenHUD];
            if (![error.domain isEqualToString:RACCommandErrorDomain]) {
                [self showBannerWithPrompt:error.domain];
            }
        } completed:^{
            [self hiddenHUD];
        }];
    }];
    
    [_profileHeadView setTag:kHeadViewTag];
    [_profileView addSubview:_profileHeadView];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_profileHeadView superView:_profileView];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_profileHeadView superView:_profileView];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_profileHeadView superView:_profileView];
    [JOAutoLayout autoLayoutWithHeight:profileTableHeadViewHeight selfView:_profileHeadView superView:_profileView];
}

- (void)createProfileTableView{

    self.profileTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_profileTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_profileTableView setBackgroundColor:[UIColor clearColor]];
    [_profileTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_profileTableView setSectionFooterHeight:CGFLOAT_MIN];
    [_profileTableView setDataSource:self];
    [_profileTableView setDelegate:self];
    [_profileTableView setTag:kTableViewTag];
    [_profileView addSubview:_profileTableView];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_profileTableView superView:_profileView];
}

- (void)createPopButton{

    UIButton *popButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [popButton setTitle:@"《" forState:UIControlStateNormal];
    [popButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [popButton addTarget:self action:@selector(popClick) forControlEvents:UIControlEventTouchUpInside];
    [popButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_profileView addSubview:popButton];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:10. selfView:popButton superView:_profileView];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:30. selfView:popButton superView:_profileView];
    [JOAutoLayout autoLayoutWithSize:JOSize(30., 30.) selfView:popButton superView:_profileView];
}

#pragma mark - Button action

- (void)popClick{

    [self.navigationController popViewControllerAnimated:YES];
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

    [UIColor whiteColor];
    [UIColor  colorWithRed:0.2 green:0.4 blue:0.5 alpha:0.1];
    
    MIAProfileHeadModel *headModel = _profileViewModel.profileHeadModel;
    
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:headModel.avatarURL] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [JOAutoLayout removeAutoLayoutWithHeightSelfView:_coverImageView superView:self.view];
        [JOAutoLayout autoLayoutWithHeight:View_Width(self.view)/(image.size.width/image.size.height) selfView:_coverImageView superView:self.view];
        
    }];
//    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:headModel.avatarURL] placeholderImage:nil];
    [_profileHeadView setProfileHeadImageURL:headModel.avatarURL name:headModel.nickName summary:headModel.summary];
    [_profileHeadView setProfileFans:headModel.fansCount attention:headModel.followCount];
    [_profileHeadView setAttentionButtonState:[headModel.followState boolValue]];
    
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
    
    if (cellType == MIACellTypeReplay) {
        [(MIAProfileReplayCell *)cell setProfileReplayUID:_uid];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setCellData:[[_profileViewModel.cellDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return profileTableHeadViewHeight + kBaseCellHeadViewHeight;
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
                                                 tipTitle:[NSString stringWithFormat:@"%@人观看",_profileViewModel.profileLiveModel.liveViewCount]
                                                    frame:CGRectMake(0., 0., View_Width(self.view), profileTableHeadViewHeight + kBaseCellHeadViewHeight)
                                            cellColorType:headColorType];
        
    }else if (profileCellType == MIAProfileCellTypeAlbum){
    
        return [MIABaseCellHeadView cellHeadViewWithImage:[UIImage imageNamed:@"PR-AlbumIcon"]
                                                    title:@"专辑"
                                                 tipTitle:nil
                                                    frame:CGRectMake(0., 0., View_Width(self.view), kBaseCellHeadViewHeight)
                                            cellColorType:headColorType];
    }else if (profileCellType == MIAProfileCellTypeVideo){
        
        return [MIABaseCellHeadView cellHeadViewWithImage:[UIImage imageNamed:@"PR-VideoIcon"]
                                                    title:@"视频"
                                                 tipTitle:nil
                                                    frame:CGRectMake(0., 0., View_Width(self.view), kBaseCellHeadViewHeight)
                                            cellColorType:headColorType];
    }else if (profileCellType == MIAProfileCellTypeReplay){
        
        return  [MIABaseCellHeadView cellHeadViewWithImage:[UIImage imageNamed:@"PR-VideoIcon"]
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

//    [_profileHeadView setProfileMaskAlpha:(scrollView.contentOffset.y/profileTableHeadViewHeight)*2.];
    
    [_maskImageView setAlpha:(scrollView.contentOffset.y/profileTableHeadViewHeight)*2.];
    
//    if (scrollView.contentOffset.y > profileTableHeadViewHeight +10) {
//        [_profileTableView setBackgroundColor:[UIColor blackColor]];
//    }else{
//    
//        [_profileTableView setBackgroundColor:[UIColor clearColor]];
//    }
//    NSLog(@"Scoffset.y:%f",scrollView.contentOffset.y);
}

@end
