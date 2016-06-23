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
#import "HXVersion.h"

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

@property (nonatomic, strong) UIView *rewardMCoinView;
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
    
    [_baseView layoutEdge:UIEdgeInsetsMake(0., 0., 0., 0.) layoutItemHandler:nil];
    
    [self createCoverMaskView];
    [self createAlbumInfoView];
    [self createRewardView];

}

#pragma mark - view create

- (void)createCoverMaskView{

    self.coverImageView = [UIImageView newAutoLayoutView];
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:_albumModel.coverUrl]
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [_coverImageView setImage:[image blurredImageWithRadius:23.0f iterations:23. tintColor:[UIColor blackColor]]];
    }];
    [_baseView addSubview:_coverImageView];
    
    [_coverImageView layoutEdge:UIEdgeInsetsMake(0., 0., 0., 0.) layoutItemHandler:nil];
    
    self.maskImageView = [UIImageView newAutoLayoutView];
    [_maskImageView setImage:[UIImage imageNamed:@"PR-MaskBG"]];
    [_baseView addSubview:_maskImageView];
    
    [_maskImageView layoutSameView:_coverImageView layoutItemHandler:nil];
}

- (void)createAlbumInfoView{
    
    self.popButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_popButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_popButton setImage:[UIImage imageNamed:@"VP-Close"] forState:UIControlStateNormal];
    [_popButton addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    [_baseView addSubview:_popButton];
    
    [_popButton layoutTop:kAlbumRewardTopSpaceDistance layoutItemHandler:nil];
    [_popButton layoutRight:-kAlbumRewardRightSpaceDistance layoutItemHandler:nil];
    [_popButton layoutSize:JOSize(kAlbumRewardPopButtonHeight, kAlbumRewardPopButtonHeight) layoutItemHandler:nil];

    self.albumInfoView = [UIView newAutoLayoutView];
    [_baseView addSubview:_albumInfoView];
    
    self.singerNameLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_AlbumReward_Singer]];
    [_singerNameLabel setTextAlignment:NSTextAlignmentCenter];
    [_singerNameLabel setText:_albumModel.nick];
    [_albumInfoView addSubview:_singerNameLabel];
    
    CGFloat singerNameLabelHeight = [_singerNameLabel sizeThatFits:JOMAXSize].height+1;
    
    [_singerNameLabel layoutBottom:5. layoutItemHandler:nil];
    [_singerNameLabel layoutLeft:0. layoutItemHandler:nil];
    [_singerNameLabel layoutRight:0. layoutItemHandler:nil];
    [_singerNameLabel layoutHeight:singerNameLabelHeight layoutItemHandler:nil];
    
    self.albumNameLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_AlbumReward_Title]];
    [_albumNameLabel setTextAlignment:NSTextAlignmentCenter];
    [_albumNameLabel setText:_albumModel.title];
    [_albumInfoView addSubview:_albumNameLabel];
    
    CGFloat albumNameLabelHeight = [_albumNameLabel sizeThatFits:JOMAXSize].height;
    
    [_albumNameLabel layoutLeft:0. layoutItemHandler:nil];
    [_albumNameLabel layoutRight:0. layoutItemHandler:nil];
    [_albumNameLabel layoutBottomView:_singerNameLabel distance:-kAlbumInfoAlbumNameToSingerNameSpaceDistance layoutItemHandler:nil];
    [_albumNameLabel layoutHeight:albumNameLabelHeight layoutItemHandler:nil];

    self.albumCoverImageView = [UIImageView newAutoLayoutView];
    [_albumCoverImageView sd_setImageWithURL:[NSURL URLWithString:_albumModel.coverUrl] placeholderImage:nil];
    [[_albumCoverImageView layer] setBorderWidth:1.];
    [[_albumCoverImageView layer] setBorderColor:JORGBCreate(159., 144., 98.,1.).CGColor];
    [_albumInfoView addSubview:_albumCoverImageView];
    
    [_albumCoverImageView layoutTop:0. layoutItemHandler:nil];
    [_albumCoverImageView layoutCenterXView:_albumInfoView layoutItemHandler:nil];
    [_albumCoverImageView layoutWidth:kAlbumInfoImageViewWidth layoutItemHandler:nil];
    [_albumCoverImageView layoutHeightWidthRatio:1. layoutItemHandler:nil];
    
    CGFloat albumInfoHeight =singerNameLabelHeight+albumNameLabelHeight+kAlbumInfoImageViewWidth + kAlbumInfoImageToAlbumNameSpaceDistance + kAlbumInfoAlbumNameToSingerNameSpaceDistance;
    
    CGFloat topSpaceDistance = kButtonToAlbumInfoViewSpaceDistance;
    if ([HXVersion isIPhone5SPrior]) {
        topSpaceDistance = kButtonToAlbumInfoViewSpaceDistance - 30.;
    }
    
    [_albumInfoView layoutTopView:_popButton distance:topSpaceDistance layoutItemHandler:nil];
    [_albumInfoView layoutLeft:kAlbumRewardLeftSpaceDistance layoutItemHandler:nil];
    [_albumInfoView layoutRight:-kAlbumRewardRightSpaceDistance layoutItemHandler:nil];
    [_albumInfoView layoutHeight:albumInfoHeight layoutItemHandler:nil];
    
    self.rewardTipLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_AlbumReward_Tip]];
    [_rewardTipLabel setTextAlignment:NSTextAlignmentCenter];
    [_rewardTipLabel setText:kRewardTipString];
    [_baseView addSubview:_rewardTipLabel];
    
    [_rewardTipLabel layoutLeft:kAlbumRewardLeftSpaceDistance layoutItemHandler:nil];
    [_rewardTipLabel layoutRight:-kAlbumRewardRightSpaceDistance layoutItemHandler:nil];
    [_rewardTipLabel layoutTopView:_albumInfoView distance:kAlbumInfoViewToTipSpaceDistance layoutItemHandler:nil];
    [_rewardTipLabel layoutHeight:[_rewardTipLabel sizeThatFits:JOMAXSize].height+1 layoutItemHandler:nil];
}

- (void)createRewardView{

    self.accountView = [UIView newAutoLayoutView];
    [_baseView addSubview:_accountView];
    
    self.accountLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_AlbumReward_Account]];
    [_accountLabel setText:[NSString stringWithFormat:@"账户余额:%@M币",[[MIAMCoinManage shareMCoinManage] mCoin]]];
    [_accountView addSubview:_accountLabel];
    
    CGFloat accountLabelHeight = [_accountLabel sizeThatFits:JOMAXSize].height+2;
    CGFloat accountLabelWidth = [_accountLabel sizeThatFits:JOMAXSize].width+1;
    
    [_accountLabel layoutLeft:0. layoutItemHandler:nil];
    [_accountLabel layoutTop:0. layoutItemHandler:nil];
    [_accountLabel layoutBottom:0. layoutItemHandler:nil];
    [_accountLabel layoutWidth:accountLabelWidth layoutItemHandler:nil];
    
    self.rechargeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rechargeButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_rechargeButton setTitle:@"充值>" forState:UIControlStateNormal];
    [_rechargeButton addTarget:self action:@selector(rechangeAction) forControlEvents:UIControlEventTouchUpInside];
    [[_rechargeButton titleLabel] setFont:[MIAFontManage getFontWithType:MIAFontType_AlbumReward_Recharge]->font];
    [_rechargeButton setTitleColor:[MIAFontManage getFontWithType:MIAFontType_AlbumReward_Recharge]->color forState:UIControlStateNormal];
    [_accountView addSubview:_rechargeButton];
    
    [_rechargeButton layoutLeftView:_accountLabel distance:0. layoutItemHandler:nil];
    [_rechargeButton layoutTop:0. layoutItemHandler:nil];
    [_rechargeButton layoutBottom:0. layoutItemHandler:nil];
    [_rechargeButton layoutRight:0. layoutItemHandler:nil];
    
    [_accountView layoutBottom:-kAlbumRewardBottomSpaceDistance layoutItemHandler:nil];
    [_accountView layoutWidth:accountLabelWidth+kRechargeButtonWidth layoutItemHandler:nil];
    [_accountView layoutCenterXView:_baseView layoutItemHandler:nil];
    [_accountView layoutHeight:accountLabelHeight layoutItemHandler:nil];
    
    self.rewardMCoinView = [UIView newAutoLayoutView];
    [_baseView addSubview:_rewardMCoinView];
    
    self.rewardMCoinLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_AlbumReward_RewardMCoin]];
    [_rewardMCoinLabel setText:[NSString stringWithFormat:@"%@",_rewardMCoin]];
    [_rewardMCoinLabel setTextAlignment:NSTextAlignmentCenter];
    [_rewardMCoinView addSubview:_rewardMCoinLabel];
    
    CGFloat rewardMCoinLabelWidth = [_rewardMCoinLabel sizeThatFits:JOMAXSize].width;
    CGFloat rewardMCoinLabelHeight = [_rewardMCoinLabel sizeThatFits:JOMAXSize].height;
    
    [_rewardMCoinLabel layoutTop:0. layoutItemHandler:nil];
    [_rewardMCoinLabel layoutLeft:0. layoutItemHandler:nil];
    [_rewardMCoinLabel layoutBottom:0. layoutItemHandler:nil];
    [_rewardMCoinLabel layoutWidth:[_rewardMCoinLabel sizeThatFits:JOMAXSize].width layoutItemHandler:nil];
    
    UIImage *mCoinImage = [UIImage imageNamed:@"LC-CoinIcon-L"];
    UIImageView *mCoinImageView = [UIImageView newAutoLayoutView];
    [mCoinImageView setImage:mCoinImage];
    [_rewardMCoinView addSubview:mCoinImageView];

    [mCoinImageView layoutLeftView:_rewardMCoinLabel distance:5. layoutItemHandler:nil];
    [mCoinImageView layoutSize:mCoinImage.size layoutItemHandler:nil];
    [mCoinImageView layoutBottom:-10. layoutItemHandler:nil];
    
    self.rewardSlider = [HXSectorSlider newAutoLayoutView];
    [_rewardSlider setDelegate:self];
    [_baseView addSubview:_rewardSlider];
    
    self.rewardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rewardButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_rewardButton setTitle:@"打赏" forState:UIControlStateNormal];
    [_rewardButton setTitleColor:[MIAFontManage getFontWithType:MIAFontType_AlbumReward_RewardButtonTitle]->color forState:UIControlStateNormal];
    [[_rewardButton titleLabel] setFont:[MIAFontManage getFontWithType:MIAFontType_AlbumReward_RewardButtonTitle]->font];
    [[_rewardButton layer] setCornerRadius:kRewardButtonHeight/2.];
    [[_rewardButton layer] setMasksToBounds:YES];
    [[_rewardButton layer] setBorderWidth:1.];
    [[_rewardButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    [_rewardButton addTarget:self action:@selector(rewardAction) forControlEvents:UIControlEventTouchUpInside];
    [_baseView addSubview:_rewardButton];
    
    [_rewardButton layoutBottomView:_accountView distance:-kRewardButtonToAccountViewSpaceDistance layoutItemHandler:nil];
    [_rewardButton layoutSize:JOSize(kRewardButtonWidth, kRewardButtonHeight) layoutItemHandler:nil];
    [_rewardButton layoutCenterXView:_baseView layoutItemHandler:nil];
    
    //rewardMCoinView
    [_rewardMCoinView layoutBottomView:_rewardSlider distance:-3. layoutItemHandler:nil];
    [_rewardMCoinView layoutWidth:rewardMCoinLabelWidth+5+mCoinImage.size.width layoutItemHandler:nil];
    [_rewardMCoinView layoutCenterXView:_baseView layoutItemHandler:nil];
    [_rewardMCoinView layoutHeight:rewardMCoinLabelHeight layoutItemHandler:nil];
    
    //rewardSlider
    [_rewardSlider layoutLeft:0. layoutItemHandler:nil];
    [_rewardSlider layoutRight:0. layoutItemHandler:nil];
    [_rewardSlider layoutBottomView:_rewardButton distance:-10. layoutItemHandler:nil];
    [_rewardSlider layoutHeight:kRewardSliderViewHeight layoutItemHandler:nil];
    
}

- (void)updateMCoinAccountLabelLayout{

    CGFloat accountLabelWidth = [_accountLabel sizeThatFits:JOMAXSize].width+1;
    [_accountLabel layoutWidth:accountLabelWidth layoutItemHandler:nil];
    [_accountView layoutWidth:accountLabelWidth+kRechargeButtonWidth layoutItemHandler:nil];
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
    
    [_rewardMCoinLabel setText:[NSString stringWithFormat:@"%@",_rewardMCoin]];
    
    CGFloat rewardMCoinLabelWidth = [_rewardMCoinLabel sizeThatFits:JOMAXSize].width;
    UIImage *mCoinImage = [UIImage imageNamed:@"LC-CoinIcon-L"];

    [_rewardMCoinLabel layoutWidth:rewardMCoinLabelWidth layoutItemHandler:nil];
    [_rewardMCoinView layoutWidth:rewardMCoinLabelWidth+5+mCoinImage.size.width layoutItemHandler:nil];
}

@end
