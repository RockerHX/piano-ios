//
//  MIAAlbumRewardViewController.m
//  Piano
//
//  Created by 刘维 on 16/5/13.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAAlbumRewardViewController.h"
#import "MIAPaymentViewController.h"
#import "UIImageView+WebCache.h"
#import "UIViewController+HXClass.h"
#import "MIAAlbumRewardViewModel.h"
#import "MIAAlbumModel.h"
#import "FXBlurView.h"
#import "MIAFontManage.h"
#import "JOBaseSDK.h"
#import "MIAMCoinManage.h"
#import "HXSectorSlider.h"

static NSString *const kRewardTipString = @" ";//@"打赏,下载该专辑的无损音质版";
static CGFloat const kRewardSliderViewHeight = 75.;//打赏的Slider的高度

@interface MIAAlbumRewardViewController()<HXSectorSliderDelegate>

@property (nonatomic, strong) UIView *baseView;

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIImageView *maskImageView;

@property (nonatomic, strong) UIButton *popButton;

@property (nonatomic, strong) UIView *albumInfoView;
@property (nonatomic, strong) UIImageView *albumCoverImageView;
@property (nonatomic, strong) UILabel *albumNameLabel;
@property (nonatomic, strong) UILabel *singerNameLabel;

@property (nonatomic, strong) UILabel *rewardTipLabel;

@property (nonatomic, strong) UILabel *rewardMCoinLabel;
@property (nonatomic, strong) HXSectorSlider *rewardSlider;

@property (nonatomic, strong) UIButton *rewardButton;

@property (nonatomic, strong) UIView *accountView;
@property (nonatomic, strong) UILabel *accountLabel;
@property (nonatomic, strong) UIButton *rechargeButton;

@property (nonatomic, copy) NSString *rewardMCoin;

@end

@implementation MIAAlbumRewardViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [[MIAMCoinManage shareMCoinManage] updateMCoinWithMCoinSuccess:^{
        
        [_accountLabel setText:[NSString stringWithFormat:@"账户余额:%@M币",[[MIAMCoinManage shareMCoinManage] mCoin]]];
        [self updateMCoinAccountLabelLayout];
        
    } mCoinFailed:^(NSString *failed) {
        
        [self showBannerWithPrompt:failed];
    }];
}


- (void)loadView{

    [super loadView];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    self.rewardMCoin = @"10";
    
    self.baseView = [UIView newAutoLayoutView];
    [self.view addSubview:_baseView];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_baseView superView:self.view];
    
    [self createCoverMaskView];
    [self createAlbumInfoView];
    [self createRewardView];

}

#pragma mark - view create

- (void)createCoverMaskView{

    self.coverImageView = [UIImageView newAutoLayoutView];
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:_albumModel.coverUrl]
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [_coverImageView setImage:[image blurredImageWithRadius:5.0f iterations:5 tintColor:[UIColor whiteColor]]];
    }];
    [_baseView addSubview:_coverImageView];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_coverImageView superView:_baseView];
    
    self.maskImageView = [UIImageView newAutoLayoutView];
    [_maskImageView setImage:[UIImage imageNamed:@"PR-MaskBG"]];
    [_baseView addSubview:_maskImageView];
    
    [JOAutoLayout autoLayoutWithSameView:_coverImageView selfView:_maskImageView superView:_baseView];
}

- (void)createAlbumInfoView{
    
    self.popButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_popButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_popButton setImage:[UIImage imageNamed:@"VP-Close"] forState:UIControlStateNormal];
    [_popButton addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    [_baseView addSubview:_popButton];
    
    [JOAutoLayout autoLayoutWithTopSpaceDistance:kAlbumRewardTopSpaceDistance selfView:_popButton superView:_baseView];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-kAlbumRewardRightSpaceDistance selfView:_popButton superView:_baseView];
    [JOAutoLayout autoLayoutWithSize:JOSize(kAlbumRewardPopButtonHeight, kAlbumRewardPopButtonHeight) selfView:_popButton superView:_baseView];

    self.albumInfoView = [UIView newAutoLayoutView];
    [_baseView addSubview:_albumInfoView];
    
    self.singerNameLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_AlbumReward_Singer]];
    [_singerNameLabel setTextAlignment:NSTextAlignmentCenter];
    [_singerNameLabel setText:_albumModel.nick];
    [_albumInfoView addSubview:_singerNameLabel];
    
    CGFloat singerNameLabelHeight = [_singerNameLabel sizeThatFits:JOMAXSize].height+1;
    
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_singerNameLabel superView:_albumInfoView];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_singerNameLabel superView:_albumInfoView];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_singerNameLabel superView:_albumInfoView];
    [JOAutoLayout autoLayoutWithHeight:singerNameLabelHeight selfView:_singerNameLabel superView:_albumInfoView];
    
    self.albumNameLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_AlbumReward_Title]];
    [_albumNameLabel setTextAlignment:NSTextAlignmentCenter];
    [_albumNameLabel setText:_albumModel.title];
    [_albumInfoView addSubview:_albumNameLabel];
    
    CGFloat albumNameLabelHeight = [_albumNameLabel sizeThatFits:JOMAXSize].height;
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_albumNameLabel superView:_albumInfoView];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_albumNameLabel superView:_albumInfoView];
    [JOAutoLayout autoLayoutWithBottomView:_singerNameLabel distance:-kAlbumInfoAlbumNameToSingerNameSpaceDistance selfView:_albumNameLabel superView:_albumInfoView];
    [JOAutoLayout autoLayoutWithHeight:albumNameLabelHeight selfView:_albumNameLabel superView:_albumInfoView];

    self.albumCoverImageView = [UIImageView newAutoLayoutView];
    [_albumCoverImageView sd_setImageWithURL:[NSURL URLWithString:_albumModel.coverUrl] placeholderImage:nil];
    [[_albumCoverImageView layer] setCornerRadius:4.];
    [[_albumCoverImageView layer] setMasksToBounds:YES];
    [_albumInfoView addSubview:_albumCoverImageView];
    
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_albumCoverImageView superView:_albumInfoView];
    [JOAutoLayout autoLayoutWithCenterXWithView:_albumInfoView selfView:_albumCoverImageView superView:_albumInfoView];
    [JOAutoLayout autoLayoutWithWidth:kAlbumInfoImageViewWidth selfView:_albumCoverImageView superView:_albumInfoView];
    [JOAutoLayout autoLayoutWithWidthEqualHeightWithselfView:_albumCoverImageView superView:_albumInfoView];
    
    
    CGFloat albumInfoHeight =singerNameLabelHeight+albumNameLabelHeight+kAlbumInfoImageViewWidth + kAlbumInfoImageToAlbumNameSpaceDistance + kAlbumInfoAlbumNameToSingerNameSpaceDistance;
    
    [JOAutoLayout autoLayoutWithTopView:_popButton distance:kButtonToAlbumInfoViewSpaceDistance selfView:_albumInfoView superView:_baseView];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:kAlbumRewardLeftSpaceDistance selfView:_albumInfoView superView:_baseView];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-kAlbumRewardRightSpaceDistance selfView:_albumInfoView superView:_baseView];
    [JOAutoLayout autoLayoutWithHeight:albumInfoHeight selfView:_albumInfoView superView:_baseView];
    
    self.rewardTipLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_AlbumReward_Tip]];
    [_rewardTipLabel setTextAlignment:NSTextAlignmentCenter];
    [_rewardTipLabel setText:kRewardTipString];
    [_baseView addSubview:_rewardTipLabel];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:kAlbumRewardLeftSpaceDistance selfView:_rewardTipLabel superView:_baseView];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-kAlbumRewardRightSpaceDistance selfView:_rewardTipLabel superView:_baseView];
    [JOAutoLayout autoLayoutWithTopView:_albumInfoView distance:kAlbumInfoViewToTipSpaceDistance selfView:_rewardTipLabel superView:_baseView];
    [JOAutoLayout autoLayoutWithHeight:[_rewardTipLabel sizeThatFits:JOMAXSize].height+1 selfView:_rewardTipLabel superView:_baseView];
}

- (void)createRewardView{

    self.accountView = [UIView newAutoLayoutView];
    [_baseView addSubview:_accountView];
    
    self.accountLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_AlbumReward_Account]];
    [_accountLabel setText:[NSString stringWithFormat:@"账户余额:%@M币",[[MIAMCoinManage shareMCoinManage] mCoin]]];
    [_accountView addSubview:_accountLabel];
    
    CGFloat accountLabelHeight = [_accountLabel sizeThatFits:JOMAXSize].height+2;
    CGFloat accountLabelWidth = [_accountLabel sizeThatFits:JOMAXSize].width+1;
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_accountLabel superView:_accountView];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_accountLabel superView:_accountView];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_accountLabel superView:_accountView];
    [JOAutoLayout autoLayoutWithWidth:accountLabelWidth selfView:_accountLabel superView:_accountView];
    
    self.rechargeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rechargeButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_rechargeButton setTitle:@"充值>" forState:UIControlStateNormal];
    [_rechargeButton addTarget:self action:@selector(rechangeAction) forControlEvents:UIControlEventTouchUpInside];
    [[_rechargeButton titleLabel] setFont:[MIAFontManage getFontWithType:MIAFontType_AlbumReward_Recharge]->font];
    [_rechargeButton setTitleColor:[MIAFontManage getFontWithType:MIAFontType_AlbumReward_Recharge]->color forState:UIControlStateNormal];
    [_accountView addSubview:_rechargeButton];
    
    [JOAutoLayout autoLayoutWithLeftView:_accountLabel distance:0. selfView:_rechargeButton superView:_accountView];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_rechargeButton superView:_accountView];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_rechargeButton superView:_accountView];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0 selfView:_rechargeButton superView:_accountView];
    
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:-kAlbumRewardBottomSpaceDistance selfView:_accountView superView:_baseView];
    [JOAutoLayout autoLayoutWithWidth:accountLabelWidth+kRechargeButtonWidth selfView:_accountView superView:_baseView];
    [JOAutoLayout autoLayoutWithCenterXWithView:_baseView selfView:_accountView superView:_baseView];
    [JOAutoLayout autoLayoutWithHeight:accountLabelHeight selfView:_accountView superView:_baseView];
    
    self.rewardMCoinLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_AlbumReward_RewardMCoin]];
    [_rewardMCoinLabel setText:[NSString stringWithFormat:@"%@M币",_rewardMCoin]];
    [_rewardMCoinLabel setTextAlignment:NSTextAlignmentCenter];
    [_baseView addSubview:_rewardMCoinLabel];
    
    self.rewardSlider = [HXSectorSlider newAutoLayoutView];
    [_rewardSlider setDelegate:self];
    [_baseView addSubview:_rewardSlider];
    
    self.rewardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rewardButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_rewardButton setTitle:@"打赏" forState:UIControlStateNormal];
    [_rewardButton setTitleColor:[MIAFontManage getFontWithType:MIAFontType_AlbumReward_RewardButtonTitle]->color forState:UIControlStateNormal];
    [[_rewardButton layer] setCornerRadius:kRewardButtonHeight/2.];
    [[_rewardButton layer] setMasksToBounds:YES];
    [[_rewardButton layer] setBorderWidth:1.];
    [[_rewardButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    [_rewardButton addTarget:self action:@selector(rewardAction) forControlEvents:UIControlEventTouchUpInside];
    [_baseView addSubview:_rewardButton];
    
    [JOAutoLayout autoLayoutWithBottomView:_accountView distance:-kRewardButtonToAccountViewSpaceDistance selfView:_rewardButton superView:_baseView];
    [JOAutoLayout autoLayoutWithSize:JOSize(kRewardButtonWidth, kRewardButtonHeight) selfView:_rewardButton superView:_baseView];
    [JOAutoLayout autoLayoutWithCenterXWithView:_baseView selfView:_rewardButton superView:_baseView];
    
    //rewardMCoin
    [JOAutoLayout autoLayoutWithBottomView:_rewardSlider distance:-10. selfView:_rewardMCoinLabel superView:_baseView];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:kAlbumRewardLeftSpaceDistance selfView:_rewardMCoinLabel superView:_baseView];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-kAlbumRewardRightSpaceDistance selfView:_rewardMCoinLabel superView:_baseView];
    [JOAutoLayout autoLayoutWithHeight:[_rewardMCoinLabel sizeThatFits:JOMAXSize].height+2 selfView:_rewardMCoinLabel superView:_baseView];
    
    //rewardSlider
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_rewardSlider superView:_baseView];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_rewardSlider superView:_baseView];
    [JOAutoLayout autoLayoutWithBottomView:_rewardButton distance:-10. selfView:_rewardSlider superView:_baseView];
    [JOAutoLayout autoLayoutWithHeight:kRewardSliderViewHeight selfView:_rewardSlider superView:_baseView];
    
}

- (void)updateMCoinAccountLabelLayout{

    CGFloat accountLabelWidth = [_accountLabel sizeThatFits:JOMAXSize].width+1;
    
    [JOAutoLayout removeAutoLayoutWithWidthSelfView:_accountLabel superView:_accountView];
    [JOAutoLayout removeAutoLayoutWithWidthSelfView:_accountView superView:_baseView];
    
    [JOAutoLayout autoLayoutWithWidth:accountLabelWidth selfView:_accountLabel superView:_accountView];
    [JOAutoLayout autoLayoutWithWidth:accountLabelWidth+kRechargeButtonWidth selfView:_accountView superView:_baseView];
}

#pragma mark - Button click

- (void)popAction{
    
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:^{
//
//    }];
}

- (void)rechangeAction{

    MIAPaymentViewController *paymentViewController = [MIAPaymentViewController new];
    [self.navigationController pushViewController:paymentViewController animated:YES];
}

- (void)rewardAction{

    [self showHUD];
    [[MIAMCoinManage shareMCoinManage] rewardAlbumWithMCoin:_rewardMCoin
                                                    albumID:_albumModel.id
                                                     roomID:@"0" success:^{
                                                     
                                                         [self hiddenHUD];
                                                         [self showBannerWithPrompt:@"打赏成功"];
                                                         [self popAction];
//                                                         JOLog(@"打赏成功");
                                                     }
                                                     failed:^(NSString *failed) {
                                                     
                                                         [self hiddenHUD];
                                                         [self showBannerWithPrompt:failed];
                                                     } mCoinSuccess:^{
//                                                         [_accountLabel setText:[NSString stringWithFormat:@"账户余额:%@M币",[[MIAMCoinManage shareMCoinManage] mCoin]]];
//                                                         [self updateMCoinAccountLabelLayout];
                                                         
                                                     } mCoinFailed:^(NSString *failed) {
//                                                         [self showBannerWithPrompt:failed];
                                                     }];
}

#pragma mark - HXSectorSliderDelegate

- (void)sectorSlider:(HXSectorSlider *)slider selectedLevel:(HXSectorSliderLevel)level{

    self.rewardMCoin = nil;
    
    if (level == HXSectorSliderLevelLow) {
        //10
        self.rewardMCoin = @"10";
        
    }else if (level == HXSectorSliderLevelNormal){
        //50
        self.rewardMCoin = @"20";
    }else if (level == HXSectorSliderLevelMedium){
        //100
        self.rewardMCoin = @"30";
    }else if (level == HXSectorSliderLevelHigh){
        //150
        self.rewardMCoin = @"50";
    }else if (level == HXSectorSliderLevelVeryHigh){
        //200
        self.rewardMCoin = @"100";
    }
    
    [_rewardMCoinLabel setText:[NSString stringWithFormat:@"%@M币",_rewardMCoin]];
}

@end
