//
//  MIAProfileHeadView.m
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAProfileHeadView.h"
#import "UIImageView+WebCache.h"
#import "JOBaseSDK.h"
#import "MIAFontManage.h"

CGFloat const kAttentionButtonTag = 3333;

static NSString *const kAttentionTipTitle = @"取消关注";
static NSString *const kUNnAttentiontipTitle = @"关注";

static CGFloat const kLeftSpaceDistance = 10.; // 需要显示的内容与左边的间距
static CGFloat const kRightSpaceDistance = 10.; // 与右边的间距
static CGFloat const kTopSpaceDistance = 230.;  //与上面的间距
static CGFloat const kFansTopSpaceDistance = 380.;//粉丝与上面的距离
static CGFloat const kNameLabelHeight = 35.; //名字的label的高度
static CGFloat const kSummayLabelHeight = 35.;//描述的Label的高度
static CGFloat const kNameToSummaySpaceDistance = 5.; //名字与描述间的距离
static CGFloat const kFansToSeparateLineSpaceDistance = 6.;//粉丝数与分隔线之间的距离
static CGFloat const kFansViewHeight = 40.;//粉丝的部分占的高度

@interface MIAProfileHeadView()

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UIImageView *maskImageView;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *summayLabel;

@property (nonatomic, strong) UIView *fansView;
@property (nonatomic, strong) UILabel *fansLabel;
@property (nonatomic, strong) UILabel *fansTipLabel;
@property (nonatomic, strong) UILabel *attentionLabel;
@property (nonatomic, strong) UILabel *attentionTipLabel;

@property (nonatomic, strong) UIButton *attentionButton;

@property (nonatomic, copy) AttentionActionBlock attentionActionBlock;

@end

@implementation MIAProfileHeadView

- (instancetype)init{

    self = [super init];
    if (self) {
        
        [self createHeadImageView];
        [self createHeadLabel];
        [self createFansView];
    }
    return self;
}

- (void)createHeadImageView{

    self.headImageView = [UIImageView newAutoLayoutView];
    [_headImageView setBackgroundColor:[UIColor orangeColor]];
    [self addSubview:_headImageView];
    
    self.maskImageView = [UIImageView newAutoLayoutView];
    [_maskImageView setImage:[UIImage imageNamed:@"PR-MaskBG"]];
    [_maskImageView setAlpha:0.];
    [self addSubview:_maskImageView];
    
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_headImageView superView:self];
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_maskImageView superView:self];
}

- (void)createHeadLabel{

    self.nameLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Head_NickName]];
    [_nameLabel setTextAlignment:NSTextAlignmentCenter];
    [[_nameLabel layer] setCornerRadius:4.];
    [[_nameLabel layer] setMasksToBounds:YES];
    [_nameLabel setBackgroundColor:JOConvertRGBToColor(53., 11., 114., 1.)];
    [self addSubview:_nameLabel];
    
    
    self.summayLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Head_Summary]];
    [_summayLabel setTextAlignment:NSTextAlignmentCenter];
    [[_summayLabel layer] setCornerRadius:4.];
    [[_summayLabel layer] setMasksToBounds:YES];
    [_summayLabel setBackgroundColor:JOConvertRGBToColor(53., 11., 114., 1.)];
    [self addSubview:_summayLabel];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:kLeftSpaceDistance selfView:_nameLabel superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:kTopSpaceDistance selfView:_nameLabel superView:self];
    [JOAutoLayout autoLayoutWithHeight:kNameLabelHeight selfView:_nameLabel superView:self];
    [JOAutoLayout autoLayoutWithWidth:50. selfView:_nameLabel superView:self];
    
    [JOAutoLayout autoLayoutWithLeftXView:_nameLabel selfView:_summayLabel superView:self];
    [JOAutoLayout autoLayoutWithTopView:_nameLabel distance:kNameToSummaySpaceDistance selfView:_summayLabel superView:self];
    [JOAutoLayout autoLayoutWithHeight:kSummayLabelHeight selfView:_summayLabel superView:self];
    [JOAutoLayout autoLayoutWithWidth:50. selfView:_summayLabel superView:self];
    
}

- (void)createFansView{

    self.fansView = [UIView newAutoLayoutView];
    [_fansView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_fansView];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:kLeftSpaceDistance selfView:_fansView superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:kFansTopSpaceDistance selfView:_fansView superView:self];
//    [JOAutoLayout autoLayoutWithBottomSpaceDistance:-kBottomSpaceDistance selfView:_fansView superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-kRightSpaceDistance selfView:_fansView superView:self];
    [JOAutoLayout autoLayoutWithHeight:kFansViewHeight selfView:_fansView superView:self];
    
    self.fansLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Head_Fans]];
    [_fansView addSubview:_fansLabel];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_fansLabel superView:_fansView];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_fansLabel superView:_fansView];
    [JOAutoLayout autoLayoutWithHeightWithView:_fansView ratioValue:2./3. selfView:_fansLabel superView:_fansView];
    [JOAutoLayout autoLayoutWithWidth:50. selfView:_fansLabel superView:_fansView];
    
    self.fansTipLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Head_FansTip]];
    [_fansTipLabel setText:@"粉丝"];
    [_fansView addSubview:_fansTipLabel];
    
    [JOAutoLayout autoLayoutWithLeftXView:_fansLabel selfView:_fansTipLabel superView:_fansView];
    [JOAutoLayout autoLayoutWithTopView:_fansLabel distance:0. selfView:_fansTipLabel superView:_fansView];
    [JOAutoLayout autoLayoutWithWidthWithView:_fansLabel selfView:_fansTipLabel superView:_fansView];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_fansTipLabel superView:_fansView];
    
    UIView *separateLineView = [UIView newAutoLayoutView];
    [separateLineView setBackgroundColor:[UIColor grayColor]];
    [_fansView addSubview:separateLineView];
    
    [JOAutoLayout autoLayoutWithLeftView:_fansLabel distance:kFansToSeparateLineSpaceDistance selfView:separateLineView superView:_fansView];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:5. selfView:separateLineView superView:_fansView];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:-5. selfView:separateLineView superView:_fansView];
    [JOAutoLayout autoLayoutWithWidth:1. selfView:separateLineView superView:_fansView];
    
    self.attentionLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Head_Fans]];
    [_fansView addSubview:_attentionLabel];
    
    [JOAutoLayout autoLayoutWithLeftView:separateLineView distance:kFansToSeparateLineSpaceDistance selfView:_attentionLabel superView:_fansView];
    [JOAutoLayout autoLayoutWithTopYView:_fansLabel selfView:_attentionLabel superView:_fansView];
    [JOAutoLayout autoLayoutWithBottomYView:_fansLabel selfView:_attentionLabel superView:_fansView];
    [JOAutoLayout autoLayoutWithWidth:50. selfView:_attentionLabel superView:_fansView];
    
    self.attentionTipLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Head_FansTip]];
    [_attentionTipLabel setText:@"关注"];
    [_fansView addSubview:_attentionTipLabel];
    
    [JOAutoLayout autoLayoutWithTopYView:_fansTipLabel selfView:_attentionTipLabel superView:_fansView];
    [JOAutoLayout autoLayoutWithLeftXView:_attentionLabel selfView:_attentionTipLabel superView:_fansView];
    [JOAutoLayout autoLayoutWithBottomYView:_fansTipLabel selfView:_attentionTipLabel superView:_fansView];
    [JOAutoLayout autoLayoutWithWidthWithView:_attentionLabel selfView:_attentionTipLabel superView:_fansView];
    
    self.attentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_attentionButton setTitleColor:[MIAFontManage getFontWithType:MIAFontType_Profile_Head_AttentionButtonTitle].color forState:UIControlStateNormal];
    [[_attentionButton titleLabel] setFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Head_AttentionButtonTitle].font];
    [_attentionButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_attentionButton addTarget:self action:@selector(attentionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_attentionButton setTag:kAttentionButtonTag];
    [self addSubview:_attentionButton];
    
    [JOAutoLayout autoLayoutWithRightXView:_fansView selfView:_attentionButton superView:self];
    [JOAutoLayout autoLayoutWithBottomYView:_fansView selfView:_attentionButton superView:self];
//    [JOAutoLayout autoLayoutWithWidth:50. selfView:_attentionButton superView:_fansView];
    [JOAutoLayout autoLayoutWithSize:JOSize(50, 30.) selfView:_attentionButton superView:self];
    
}

#pragma mark - button action

- (void)attentionButtonClick{
    
    if (_attentionActionBlock) {
        
        if([[_attentionButton titleForState:UIControlStateNormal] isEqualToString:kAttentionTipTitle]){
            _attentionActionBlock(YES);
        }else{
            _attentionActionBlock(NO);
        }
    }
}

#pragma mark - Data

- (void)setProfileHeadImageURL:(NSString *)imageURL name:(NSString *)name summary:(NSString *)summary{

    [_headImageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:nil];
    [_nameLabel setText:JOConvertStringToNormalString(name)];
    [_summayLabel setText:JOConvertStringToNormalString(summary)];
    
    [JOAutoLayout removeAutoLayoutWithSizeSelfView:_nameLabel superView:self];
    [JOAutoLayout removeAutoLayoutWithSizeSelfView:_summayLabel superView:self];
    
    CGFloat nameWidth = [_nameLabel sizeThatFits:JOMAXSize].width + 30.;
    CGFloat nameHeight = [_nameLabel sizeThatFits:JOMAXSize].height + 10.;
    CGFloat summaryWidth = [_summayLabel sizeThatFits:JOMAXSize].width +30.;
    CGFloat summaryHeight = [_summayLabel sizeThatFits:JOMAXSize].height +10.;
    
    [JOAutoLayout autoLayoutWithSize:JOSize(nameWidth, nameHeight) selfView:_nameLabel superView:self];
    [JOAutoLayout autoLayoutWithSize:JOSize(summaryWidth, summaryHeight) selfView:_summayLabel superView:self];
}

- (void)setProfileFans:(NSString *)fans attention:(NSString *)attention{

    NSString *fanString = JOConvertStringToNormalString(fans);
    NSString *attentionString = JOConvertStringToNormalString(attention);
    
    [_fansLabel setText:[fanString length]?fanString:@"0"];
    [_attentionLabel setText:[attentionString length]?attentionString:@"0"];
    
    [JOAutoLayout removeAutoLayoutWithWidthSelfView:_fansLabel superView:_fansView];
    [JOAutoLayout removeAutoLayoutWithWidthSelfView:_attentionLabel superView:_fansView];
    
    CGFloat fansWidth = MAX([_fansLabel sizeThatFits:JOMAXSize].width, [_fansTipLabel sizeThatFits:JOMAXSize].width);
    CGFloat attentionWidth = MAX([_attentionLabel sizeThatFits:JOMAXSize].width, [_attentionTipLabel sizeThatFits:JOMAXSize].width);
    
    [JOAutoLayout autoLayoutWithWidth:fansWidth selfView:_fansLabel superView:_fansView];
    [JOAutoLayout autoLayoutWithWidth:attentionWidth selfView:_attentionLabel superView:_fansView];
}

- (void)setAttentionButtonState:(BOOL)state{

    if (state) {
        //已关注
        [_attentionButton setTitle:kAttentionTipTitle forState:UIControlStateNormal];
    }else{
        //未关注
        [_attentionButton setTitle:kUNnAttentiontipTitle forState:UIControlStateNormal];
    }
    
    [JOAutoLayout removeAutoLayoutWithSizeSelfView:_attentionButton superView:self];
    [JOAutoLayout autoLayoutWithSize:JOSize([[_attentionButton titleLabel] sizeThatFits:JOMAXSize].width+6, [[_attentionButton titleLabel] sizeThatFits:JOMAXSize].height+4) selfView:_attentionButton superView:self];
}

- (void)setProfileMaskAlpha:(CGFloat)alpha{

    [_maskImageView setAlpha:alpha];

}

- (void)attentionActionHandler:(AttentionActionBlock)handler{

    self.attentionActionBlock = nil;
    self.attentionActionBlock = handler;
}


@end
