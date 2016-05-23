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

@interface MIAAlbumDetailView()

@property (nonatomic, strong) UIImageView *albumCoverImageView;
@property (nonatomic, strong) UIView *rewardForDownloadView;
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
         UIButton *rewardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [[rewardButton titleLabel] setJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_PayDownloadButtonTitle]];
        [rewardButton setTitle:kRewardDownloadTitle forState:UIControlStateNormal];
        [rewardButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [rewardButton setBackgroundColor:JORGBSameCreate(30.)];
        [[rewardButton layer] setCornerRadius:(kRewardDownloadViewHeight-2*topSpaceDistance)/2.];
        [[rewardButton layer] setMasksToBounds:YES];
        [rewardButton addTarget:self action:@selector(rewardButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_rewardForDownloadView addSubview:rewardButton];
        
        [JOAutoLayout autoLayoutWithTopSpaceDistance:topSpaceDistance selfView:rewardButton superView:_rewardForDownloadView];
        [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:rewardButton superView:_rewardForDownloadView];
        [JOAutoLayout autoLayoutWithBottomSpaceDistance:-topSpaceDistance selfView:rewardButton superView:_rewardForDownloadView];
        [JOAutoLayout autoLayoutWithRightSpaceDistance:-0. selfView:rewardButton superView:_rewardForDownloadView];
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

    return kPlayViewHeight + kRewardViewHeight + kRewardDownloadViewHeight + JOScreenSize.width - kLeftSpaceDistance - kRightSpaceDistance;
}

#pragma mark - Button click

- (void)rewardButtonClick{

    if (_rewardAlbumActionBlock) {
        _rewardAlbumActionBlock();
    }
}

#pragma mark - Data 

- (void)setAlbumHeadDetailData:(id)data{

    if ([data isKindOfClass:[MIAAlbumModel class]]) {
        
        self.albumModel = nil;
        self.albumModel = data;
        
        [_albumCoverImageView sd_setImageWithURL:[NSURL URLWithString:_albumModel.coverUrl] placeholderImage:nil];
        [_rewardView setRewardData:_albumModel.backList];
    }else{
    
        [JOFException exceptionWithName:@"MIAAlbumDetailView exception!" reason:@"data必须是MIAAlbumModel类型"];
    }
}

- (void)setAlbumSongModelData:(id)data{

    if ([data isKindOfClass:[NSArray class]]) {

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
