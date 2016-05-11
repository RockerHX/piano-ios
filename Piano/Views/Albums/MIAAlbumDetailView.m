//
//  MIAAlbumDetailView.m
//  Piano
//
//  Created by 刘维 on 16/5/11.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAAlbumDetailView.h"
#import "MIAFontManage.h"
#import "JOBaseSDK.h"
#import "MIAAlbumRewardView.h"
#import "MIAAlbumPlayView.h"
#import "MIAAlbumSongView.h"

static CGFloat const kLeftSpaceDistance = 10.; //视图左空隙大小
static CGFloat const kRightSpaceDistance = 10.; //视图右空隙大小

static CGFloat const kRewardDownloadViewHeight = 60.; //打赏下载按钮视图的高度
static CGFloat const kRewardViewHeight = 70.; //打赏视图的高度
static CGFloat const kPlayViewHeight = 50.; //播放视图的高度

static NSString *const kRewardDownloadTitle = @"打赏,下载高品质版本";

@interface MIAAlbumDetailView()

@property (nonatomic, strong) UIImageView *albumCoverImageView;
@property (nonatomic, strong) UIView *rewardForDownloadView;
@property (nonatomic, strong) MIAAlbumRewardView *rewardView;
@property (nonatomic, strong) MIAAlbumPlayView *playView;

@end

@implementation MIAAlbumDetailView

- (instancetype)init{

    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self createAlbumDetailView];
    }
    return self;
}

#pragma mark - view create

- (void)createAlbumDetailView{

    [self createCoverImageView];
    [self createRewardDownloadView];
    [self createRewardView];
    [self createPlayView];
}

- (void)createCoverImageView{

    if (!self.albumCoverImageView) {
        self.albumCoverImageView = [UIImageView newAutoLayoutView];
        [_albumCoverImageView setBackgroundColor:[UIColor purpleColor]];
        [self addSubview:_albumCoverImageView];
        
        [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_albumCoverImageView superView:self];
        [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_albumCoverImageView superView:self];
        [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_albumCoverImageView superView:self];
        [JOAutoLayout autoLayoutWithWidthEqualHeightWithselfView:_albumCoverImageView superView:self];
    }
}

- (void)createRewardDownloadView{

    if (!self.rewardForDownloadView) {
        
        self.rewardForDownloadView = [UIView newAutoLayoutView];
        [_rewardForDownloadView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_rewardForDownloadView];
        
        [JOAutoLayout autoLayoutWithTopView:_albumCoverImageView distance:0. selfView:_rewardForDownloadView superView:self];
        [JOAutoLayout autoLayoutWithLeftSpaceDistance:kLeftSpaceDistance selfView:_rewardForDownloadView superView:self];
        [JOAutoLayout autoLayoutWithRightSpaceDistance:-kRightSpaceDistance selfView:_rewardForDownloadView superView:self];
        [JOAutoLayout autoLayoutWithHeight:kRewardDownloadViewHeight selfView:_rewardForDownloadView superView:self];
        
        CGFloat topSpaceDistance = 10.;
         UIButton *rewardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [[rewardButton titleLabel] setJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_PayDownloadButtonTitle]];
        [rewardButton setTitle:kRewardDownloadTitle forState:UIControlStateNormal];
        [rewardButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [rewardButton setBackgroundColor:JORGBSameCreate(30.)];
        [[rewardButton layer] setCornerRadius:(kRewardDownloadViewHeight-2*topSpaceDistance)/2.];
        [[rewardButton layer] setMasksToBounds:YES];
        [_rewardForDownloadView addSubview:rewardButton];
        
        [JOAutoLayout autoLayoutWithTopSpaceDistance:topSpaceDistance selfView:rewardButton superView:_rewardForDownloadView];
        [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:rewardButton superView:_rewardForDownloadView];
        [JOAutoLayout autoLayoutWithBottomSpaceDistance:-topSpaceDistance selfView:rewardButton superView:_rewardForDownloadView];
        [JOAutoLayout autoLayoutWithRightSpaceDistance:.0 selfView:rewardButton superView:_rewardForDownloadView];
        
    }
}

- (void)createRewardView{

    if (!self.rewardView) {
        self.rewardView = [MIAAlbumRewardView newAutoLayoutView];
        [_rewardView setRewardViewHeight:kRewardViewHeight];
        [_rewardView setRewardData:@[@"1",@"2",@"1",@"1",@"1",@"1",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
        [self addSubview:_rewardView];
        
        [JOAutoLayout autoLayoutWithTopView:_rewardForDownloadView distance:0. selfView:_rewardView superView:self];
        [JOAutoLayout autoLayoutWithLeftSpaceDistance:kLeftSpaceDistance selfView:_rewardView superView:self];
        [JOAutoLayout autoLayoutWithRightSpaceDistance:-kRightSpaceDistance selfView:_rewardView superView:self];
        [JOAutoLayout autoLayoutWithHeight:kRewardViewHeight selfView:_rewardView superView:self];
    }
}

- (void)createPlayView{

    if (!self.playView) {
        self.playView = [MIAAlbumPlayView newAutoLayoutView];
        [_playView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_playView];
        
        [JOAutoLayout autoLayoutWithTopView:_rewardView distance:0. selfView:_playView superView:self];
        [JOAutoLayout autoLayoutWithLeftSpaceDistance:kLeftSpaceDistance selfView:_playView superView:self];
        [JOAutoLayout autoLayoutWithRightSpaceDistance:-kRightSpaceDistance selfView:_playView superView:self];
        [JOAutoLayout autoLayoutWithHeight:kPlayViewHeight selfView:_playView superView:self];
    }
}

- (CGFloat)albumDetailViewHeight{

    return kPlayViewHeight + kRewardViewHeight + kRewardDownloadViewHeight;
}

@end
