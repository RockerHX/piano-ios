//
//  MIAAlbumDetailView.m
//  Piano
//
//  Created by 刘维 on 16/5/11.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAAlbumDetailView.h"
#import "UIImageView+WebCache.h"
#import "MIAFontManage.h"
#import "JOBaseSDK.h"
#import "MIAAlbumRewardView.h"
#import "MIAAlbumPlayView.h"

#import "MIAAlbumModel.h"

#import "MIAAlbumHeadDetailViewModel.h"

static NSString *const kRewardDownloadTitle = @"打赏,下载高品质版本";
static NSString *const kSongDownloadTitle = @"下载专辑";

@interface MIAAlbumDetailView(){

    CGFloat albumDetailViewHeight;
}

@property (nonatomic, strong) UIImageView *albumCoverImageView;
@property (nonatomic, strong) UIView *rewardForDownloadView;
@property (nonatomic, strong) UIButton *rewardButton;
@property (nonatomic, strong) MIAAlbumRewardView *rewardView;
@property (nonatomic, strong) MIAAlbumPlayView *playView;

@property (nonatomic, strong) MIAAlbumModel *albumModel;

@property (nonatomic, copy) RewardAlbumActionBlock rewardAlbumActionBlock;
@property (nonatomic, copy) PlaySongChangeBlock playSongChangeBlock;

@end

@implementation MIAAlbumDetailView

- (instancetype)init{

    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self createAlbumDetailView];
        
        albumDetailViewHeight = kPlayViewHeight + kRewardViewHeight + kRewardDownloadViewHeight + JOScreenSize.width - kLeftSpaceDistance - kRightSpaceDistance;
    }
    return self;
}

#pragma mark - view create

- (void)createAlbumDetailView{

    UIView *backView = [UIView newAutoLayoutView];
    [backView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:backView];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., kLeftSpaceDistance, 0., -kRightSpaceDistance) selfView:backView superView:self];
    
    [self createCoverImageView];
    [self createRewardDownloadView];
    [self createRewardView];
    [self createPlayView];
}

- (void)createCoverImageView{

    if (!self.albumCoverImageView) {
        self.albumCoverImageView = [UIImageView newAutoLayoutView];
        [_albumCoverImageView setBackgroundColor:[UIColor grayColor]];
        [self addSubview:_albumCoverImageView];
        
        [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_albumCoverImageView superView:self];
        [JOAutoLayout autoLayoutWithLeftSpaceDistance:kLeftSpaceDistance selfView:_albumCoverImageView superView:self];
        [JOAutoLayout autoLayoutWithRightSpaceDistance:-kRightSpaceDistance selfView:_albumCoverImageView superView:self];
        [JOAutoLayout autoLayoutWithWidthEqualHeightWithselfView:_albumCoverImageView superView:self];
    }
}

- (void)createRewardDownloadView{

    if (!self.rewardForDownloadView) {
        
        self.rewardForDownloadView = [UIView newAutoLayoutView];
        [_rewardForDownloadView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_rewardForDownloadView];
        
        [JOAutoLayout autoLayoutWithTopView:_albumCoverImageView distance:0. selfView:_rewardForDownloadView superView:self];
        [JOAutoLayout autoLayoutWithLeftXView:_albumCoverImageView distance:kLeftInsideSpaceDistance selfView:_rewardForDownloadView superView:self];
        [JOAutoLayout autoLayoutWithRightXView:_albumCoverImageView distance:-kRightInsideSpaceDistance selfView:_rewardForDownloadView superView:self];
        [JOAutoLayout autoLayoutWithHeight:kRewardDownloadViewHeight selfView:_rewardForDownloadView superView:self];
        
        CGFloat topSpaceDistance = 10.;
        self.rewardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [[_rewardButton titleLabel] setJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_PayDownloadButtonTitle]];
        [_rewardButton setTitle:kRewardDownloadTitle forState:UIControlStateNormal];
        [_rewardButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_rewardButton setBackgroundColor:JORGBSameCreate(30.)];
        [[_rewardButton layer] setCornerRadius:(kRewardDownloadViewHeight-2*topSpaceDistance)/2.];
        [[_rewardButton layer] setMasksToBounds:YES];
        [_rewardButton addTarget:self action:@selector(rewardButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_rewardForDownloadView addSubview:_rewardButton];
        
        [JOAutoLayout autoLayoutWithTopSpaceDistance:topSpaceDistance selfView:_rewardButton superView:_rewardForDownloadView];
        [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_rewardButton superView:_rewardForDownloadView];
        [JOAutoLayout autoLayoutWithBottomSpaceDistance:-topSpaceDistance selfView:_rewardButton superView:_rewardForDownloadView];
        [JOAutoLayout autoLayoutWithRightSpaceDistance:-0. selfView:_rewardButton superView:_rewardForDownloadView];
    }
}

- (void)createRewardView{

    if (!self.rewardView) {
        self.rewardView = [MIAAlbumRewardView newAutoLayoutView];
        [_rewardView setRewardViewHeight:kRewardViewHeight];
        [self addSubview:_rewardView];
        
        [JOAutoLayout autoLayoutWithTopView:_rewardForDownloadView distance:0. selfView:_rewardView superView:self];
        [JOAutoLayout autoLayoutWithLeftXView:_albumCoverImageView distance:kLeftInsideSpaceDistance selfView:_rewardView superView:self];
        [JOAutoLayout autoLayoutWithRightXView:_albumCoverImageView distance:-kRightInsideSpaceDistance selfView:_rewardView superView:self];
        [JOAutoLayout autoLayoutWithHeight:kRewardViewHeight selfView:_rewardView superView:self];
    }
}

- (void)createPlayView{

    if (!self.playView) {
        self.playView = [MIAAlbumPlayView newAutoLayoutView];
        [_playView setBackgroundColor:[UIColor whiteColor]];
        @weakify(self);
        [_playView songChangeHandler:^(HXSongModel *songModel, NSInteger songIndex) {
        @strongify(self);
            if (self.playSongChangeBlock) {
                self.playSongChangeBlock(songModel, songIndex);
            }
        }];
        [self addSubview:_playView];
        
        [JOAutoLayout autoLayoutWithTopView:_rewardView distance:0. selfView:_playView superView:self];
        [JOAutoLayout autoLayoutWithLeftXView:_albumCoverImageView distance:kLeftInsideSpaceDistance selfView:_playView superView:self];
        [JOAutoLayout autoLayoutWithRightXView:_albumCoverImageView distance:-kRightInsideSpaceDistance selfView:_playView superView:self];
        [JOAutoLayout autoLayoutWithHeight:kPlayViewHeight selfView:_playView superView:self];
    }
}

- (CGFloat)albumDetailViewHeight{

    return albumDetailViewHeight;
}

#pragma mark - Button click

- (void)rewardButtonClick{

    if (_rewardAlbumActionBlock) {
        
        if ([[_rewardButton titleForState:UIControlStateNormal] isEqualToString:kRewardDownloadTitle]) {
            //打赏
            _rewardAlbumActionBlock(RewardAlbumActionType_Reward);
        }else if ([[_rewardButton titleForState:UIControlStateNormal] isEqualToString:kSongDownloadTitle]){
            //下载专辑
            _rewardAlbumActionBlock(RewardAlbumActionType_DownloadAlbum);
        }
    }
}

#pragma mark - Data 

- (void)setAlbumRewardState:(BOOL)state{

    if (state == YES) {
//        [JOAutoLayout removeAutoLayoutWithHeightSelfView:_rewardForDownloadView superView:self];
//        [JOAutoLayout autoLayoutWithHeight:CGFLOAT_MIN selfView:_rewardForDownloadView superView:self];
//        [_rewardForDownloadView setHidden:YES];
        
        //kSongDownloadTitle
        [_rewardButton setTitle:kSongDownloadTitle forState:UIControlStateNormal];
        
        [JOAutoLayout removeAutoLayoutWithHeightSelfView:_rewardView superView:self];
        [JOAutoLayout autoLayoutWithHeight:CGFLOAT_MIN selfView:_rewardView superView:self];
        [_rewardView setHidden:YES];
        [_rewardView removeRewardViewLayout];
        
        albumDetailViewHeight = kPlayViewHeight + kRewardDownloadViewHeight + JOScreenSize.width - kLeftSpaceDistance - kRightSpaceDistance;
    }
    
}

- (void)setAlbumHeadDetailData:(id)data{

    if ([data isKindOfClass:[MIAAlbumModel class]]) {
        
        self.albumModel = nil;
        self.albumModel = data;
        
        [_albumCoverImageView sd_setImageWithURL:[NSURL URLWithString:_albumModel.coverUrl] placeholderImage:nil];
        [_rewardView setRewardData:_albumModel.backList];
        
        if ([_albumModel.backList count]) {
            //有打赏人的时候
        }else{
            //无打赏人的时候
            albumDetailViewHeight = kPlayViewHeight + kRewardNoDataViewHeight + kRewardDownloadViewHeight + JOScreenSize.width - kLeftSpaceDistance - kRightSpaceDistance;
            
            [JOAutoLayout removeAutoLayoutWithHeightSelfView:_rewardView superView:self];
            [JOAutoLayout autoLayoutWithHeight:kRewardNoDataViewHeight selfView:_rewardView superView:self];
        }
    }else{
    
        [JOFException exceptionWithName:@"MIAAlbumDetailView exception!" reason:@"data必须是MIAAlbumModel类型"];
    }
}

- (void)setAlbumSongModelData:(id)data{

    if ([data isKindOfClass:[NSArray class]]){

        [_playView setSongModelArray:data];
    }else{
    
        [JOFException exceptionWithName:@"MIAAlbumDetailView exception!" reason:@"data必须是NSArray类型"];
    }
}

- (void)playAlbumSongWithIndex:(NSInteger)songIndex{

    [_playView playSongIndex:songIndex];
}

- (void)rewardAlbumButtonClickHanlder:(RewardAlbumActionBlock)block{

    self.rewardAlbumActionBlock = nil;
    self.rewardAlbumActionBlock = block;
}

- (void)playSongChangeHandler:(PlaySongChangeBlock)sendBlock{

    self.playSongChangeBlock = nil;
    self.playSongChangeBlock = sendBlock;
}

@end
