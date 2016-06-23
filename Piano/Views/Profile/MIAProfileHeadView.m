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

static NSString *const kAttentionTipTitle = @"已关注";
static NSString *const kUNnAttentiontipTitle = @"关注";

static CGFloat const kLeftSpaceDistance = 8.; // 需要显示的内容与左边的间距
static CGFloat const kRightSpaceDistance = 8.; // 与右边的间距
static CGFloat const kNameToBottomSpaceDistance = 180.;//名字距离底部的间距
static CGFloat const kFansToBottomSpaceDistance = 5.;//粉丝部分与底部的间距
static CGFloat const kNameToSummaySpaceDistance = 4.; //名字与描述间的距离
static CGFloat const kFansToSeparateLineSpaceDistance = 10.;//粉丝数与分隔线之间的距离
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
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self createHeadImageView];
        [self createHeadLabel];
        [self createFansView];
    }
    return self;
}

- (void)createHeadImageView{

    self.headImageView = [UIImageView newAutoLayoutView];
    [_headImageView setBackgroundColor:[UIColor clearColor]];
    [_headImageView setHidden:YES];
    [self addSubview:_headImageView];
    
    UIImage *maskImage = [UIImage imageNamed:@"PR-Mask"];
    self.maskImageView = [UIImageView newAutoLayoutView];
    [_maskImageView setImage:maskImage];
    [self addSubview:_maskImageView];
    
    [_headImageView layoutEdge:UIEdgeInsetsMake(0., 0., 0., 0.) layoutItemHandler:nil];
    
    [_maskImageView layoutLeft:0. layoutItemHandler:nil];
    [_maskImageView layoutRight:0. layoutItemHandler:nil];
    [_maskImageView layoutBottom:0. layoutItemHandler:nil];
    [_maskImageView layoutHeight:maskImage.size.height layoutItemHandler:nil];
    
}

- (void)createHeadLabel{

    self.nameLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Head_NickName]];
    [_nameLabel setTextAlignment:NSTextAlignmentCenter];
    [_nameLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [self addSubview:_nameLabel];
    
    [_nameLabel layoutLeft:kLeftSpaceDistance layoutItemHandler:nil];
    [_nameLabel layoutBottom:-kNameToBottomSpaceDistance layoutItemHandler:nil];
    [_nameLabel layoutHeight:37. layoutItemHandler:nil];
    [_nameLabel layoutWidth:CGFLOAT_MIN layoutItemHandler:nil];
    
    self.summayLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Head_Summary]];
    [_summayLabel setTextAlignment:NSTextAlignmentCenter];
    [_summayLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [self addSubview:_summayLabel];
    
    [_summayLabel layoutLeftXView:_nameLabel distance:0. layoutItemHandler:nil];
    [_summayLabel layoutTopView:_nameLabel distance:kNameToSummaySpaceDistance layoutItemHandler:nil];
    [_summayLabel layoutHeight:36. layoutItemHandler:nil];
    [_summayLabel layoutWidth:CGFLOAT_MIN layoutItemHandler:nil];
    
}

- (void)createFansView{

    self.fansView = [UIView newAutoLayoutView];
    [_fansView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_fansView];
    
    [_fansView layoutLeft:kLeftSpaceDistance layoutItemHandler:nil];
    [_fansView layoutBottom:-kFansToBottomSpaceDistance layoutItemHandler:nil];
    [_fansView layoutRight:-kRightSpaceDistance layoutItemHandler:nil];
    [_fansView layoutHeight:kFansViewHeight layoutItemHandler:nil];
    
    self.fansLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Head_Fans]];
    [_fansLabel setText:@"0"];
    [_fansView addSubview:_fansLabel];
    
    [_fansLabel layoutLeft:0. layoutItemHandler:nil];
    [_fansLabel layoutTop:0. layoutItemHandler:nil];
    [_fansLabel layoutHeightView:_fansView ratio:2./3. layoutItemHandler:nil];
    [_fansLabel layoutWidth:50. layoutItemHandler:nil];
    
    self.fansTipLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Head_FansTip]];
    [_fansTipLabel setText:@"粉丝"];
    [_fansView addSubview:_fansTipLabel];
    
    [_fansTipLabel layoutLeftXView:_fansLabel distance:0. layoutItemHandler:nil];
    [_fansTipLabel layoutTopView:_fansLabel distance:0. layoutItemHandler:nil];
    [_fansTipLabel layoutWidthView:_fansLabel ratio:1. layoutItemHandler:nil];
    [_fansTipLabel layoutBottom:0. layoutItemHandler:nil];
    
    UIView *separateLineView = [UIView newAutoLayoutView];
    [separateLineView setBackgroundColor:[UIColor grayColor]];
    [_fansView addSubview:separateLineView];
    
    [separateLineView layoutLeftView:_fansLabel distance:kFansToSeparateLineSpaceDistance layoutItemHandler:nil];
    [separateLineView layoutTop:0. layoutItemHandler:nil];
    [separateLineView layoutBottom:0. layoutItemHandler:nil];
    [separateLineView layoutWidth:1. layoutItemHandler:nil];
    
    self.attentionLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Head_Fans]];
    [_attentionLabel setText:@"0"];
    [_fansView addSubview:_attentionLabel];
    
    [_attentionLabel layoutLeftView:separateLineView distance:kFansToSeparateLineSpaceDistance layoutItemHandler:nil];
    [_attentionLabel layoutTopYView:_fansLabel distance:0. layoutItemHandler:nil];
    [_attentionLabel layoutBottomYView:_fansLabel distance:0. layoutItemHandler:nil];
    [_attentionLabel layoutWidth:50. layoutItemHandler:nil];
    
    self.attentionTipLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Head_FansTip]];
    [_attentionTipLabel setText:@"关注"];
    [_fansView addSubview:_attentionTipLabel];
    
    [_attentionTipLabel layoutTopYView:_fansTipLabel distance:0. layoutItemHandler:nil];
    [_attentionTipLabel layoutLeftXView:_attentionLabel distance:0. layoutItemHandler:nil];
    [_attentionTipLabel layoutBottomYView:_fansTipLabel distance:0. layoutItemHandler:nil];
    [_attentionTipLabel layoutWidthView:_attentionLabel ratio:1. layoutItemHandler:nil];
    
    self.attentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_attentionButton setTitleColor:[MIAFontManage getFontWithType:MIAFontType_Profile_Head_AttentionButtonTitle]->color forState:UIControlStateNormal];
    [[_attentionButton titleLabel] setFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Head_AttentionButtonTitle]->font];
    [_attentionButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_attentionButton addTarget:self action:@selector(attentionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_attentionButton setTag:kAttentionButtonTag];
    [self addSubview:_attentionButton];
    
    [_attentionButton layoutRightXView:_fansView distance:0. layoutItemHandler:nil];
    [_attentionButton layoutBottomYView:_fansView distance:0. layoutItemHandler:nil];
    [_attentionButton layoutSize:JOSize(50, 30.) layoutItemHandler:nil];
    
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

    NSString *nameString =JOConvertStringToNormalString(name);
    NSString *summaryString = JOConvertStringToNormalString(summary);
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:nil];
    [_nameLabel setText:nameString];
    [_summayLabel setText:summaryString];
    
    CGFloat nameWidth = [nameString length]?([_nameLabel sizeThatFits:JOMAXSize].width + 12.):CGFLOAT_MIN;
    CGFloat summaryWidth = [summaryString length]?([_summayLabel sizeThatFits:JOMAXSize].width +10.):CGFLOAT_MIN;
    
    [_nameLabel layoutWidth:nameWidth
          layoutItemHandler:^(JOLayoutItem *layoutItem) {
              layoutItem.priority = UILayoutPriorityDefaultHigh;
          }];
    [_nameLabel layoutRightXView:self
                        distance:-kRightSpaceDistance
               layoutItemHandler:^(JOLayoutItem *layoutItem) {
                            layoutItem.relation = NSLayoutRelationLessThanOrEqual;
                        }];
    
    [_summayLabel layoutWidth:summaryWidth
            layoutItemHandler:^(JOLayoutItem *layoutItem) {
            
                layoutItem.priority = UILayoutPriorityDefaultHigh;
            }];
    [_summayLabel layoutRightXView:self
                        distance:-kRightSpaceDistance layoutItemHandler:^(JOLayoutItem *layoutItem) {
                            layoutItem.relation = NSLayoutRelationLessThanOrEqual;
                        }];
    
}

- (void)setProfileNickBackgroundColorString:(NSString *)colorString{

    if ([JOConvertStringToNormalString(colorString) length]) {
        [_nameLabel setBackgroundColor:JOConvertHexRGBStringToColor(colorString)];
        [_summayLabel setBackgroundColor:JOConvertHexRGBStringToColor(colorString)];
    }else{
        [_nameLabel setBackgroundColor:[UIColor clearColor]];
        [_summayLabel setBackgroundColor:[UIColor clearColor]];
    }
    
//    JOConvertHexRGBStringToColor(@"#9F9062")
}

- (void)setProfileFans:(NSString *)fans attention:(NSString *)attention{

    NSString *fanString = JOConvertStringToNormalString(fans);
    NSString *attentionString = JOConvertStringToNormalString(attention);
    
    [_fansLabel setText:[fanString length]?fanString:@"0"];
    [_attentionLabel setText:[attentionString length]?attentionString:@"0"];
    
    CGFloat fansWidth = MAX([_fansLabel sizeThatFits:JOMAXSize].width, [_fansTipLabel sizeThatFits:JOMAXSize].width);
    CGFloat attentionWidth = MAX([_attentionLabel sizeThatFits:JOMAXSize].width, [_attentionTipLabel sizeThatFits:JOMAXSize].width);
    
    [_fansLabel layoutWidth:fansWidth layoutItemHandler:nil];
    [_attentionLabel layoutWidth:attentionWidth layoutItemHandler:nil];
}

- (void)setAttentionButtonState:(BOOL)state{

    if (state) {
        //已关注
        [_attentionButton setTitle:kAttentionTipTitle forState:UIControlStateNormal];
    }else{
        //未关注
        [_attentionButton setTitle:kUNnAttentiontipTitle forState:UIControlStateNormal];
    }
    
    [_attentionButton layoutSize:JOSize([[_attentionButton titleLabel] sizeThatFits:JOMAXSize].width+6, [[_attentionButton titleLabel] sizeThatFits:JOMAXSize].height+4) layoutItemHandler:nil];
}

- (void)setProfileMaskAlpha:(CGFloat)alpha{

//    [_maskImageView setAlpha:alpha];

}

- (void)attentionActionHandler:(AttentionActionBlock)handler{

    self.attentionActionBlock = nil;
    self.attentionActionBlock = handler;
}


@end
