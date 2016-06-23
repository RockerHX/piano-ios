//
//  MIAPaymentBarView.m
//  Piano
//
//  Created by 刘维 on 16/5/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAPaymentBarView.h"
#import "JOBaseSDK.h"
#import "MIAFontManage.h"

static CGFloat const kPaymentBarHeight = 44.;//Bar的高度
static CGFloat const kPaymentBarTopSpaceDistance = 10.; //Bar的上部的间距大小
static CGFloat const kPaymentBarToTipSpaceDistance = 15.; //Bar到tip的间距大小
static CGFloat const kPaymentTipToMSpacedistance = 10.; //tip到M的间距大小

@interface MIAPaymentBarView()

@property (nonatomic, strong) UIView *barView;
@property (nonatomic, strong) UILabel *mTipLabel;
@property (nonatomic, strong) UILabel *mLabel;

@property (nonatomic, copy) PaymentBarButtonClickBlock paymentBarButtonClickBlock;

@end

@implementation MIAPaymentBarView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setBackgroundColor:[UIColor blackColor]];
        [self createPaymentBarView];
        
    }
    return self;
}

- (void)createPaymentBarView{

    self.barView = [UIView newAutoLayoutView];
    [_barView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_barView];
    
    [_barView layoutTop:kPaymentBarTopSpaceDistance layoutItemHandler:nil];
    [_barView layoutLeft:0. layoutItemHandler:nil];
    [_barView layoutRight:0. layoutItemHandler:nil];
    [_barView layoutHeight:kPaymentBarHeight layoutItemHandler:nil];
    
    UILabel *barTitleLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType: MIAFontType_Payment_Bar_Title]];
    [barTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [barTitleLabel setText:@"充值"];
    [_barView addSubview:barTitleLabel];
    
    [barTitleLabel layoutEdge:UIEdgeInsetsMake(0., 0., 0., 0.) layoutItemHandler:nil];
    
    UIButton *popButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [popButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [popButton setImage:[UIImage imageNamed:@"C-BackIcon-White"] forState:UIControlStateNormal];
    [popButton addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    [_barView addSubview:popButton];
    
    [popButton layoutTop:0. layoutItemHandler:nil];
    [popButton layoutLeft:0. layoutItemHandler:nil];
    [popButton layoutBottom:0. layoutItemHandler:nil];
    [popButton layoutWidthHeightRatio:1. layoutItemHandler:nil];
    
    UIButton *payHistoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [payHistoryButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [payHistoryButton setTitleColor:[MIAFontManage getFontWithType:MIAFontType_Payment_Bar_RightButton]->color forState:UIControlStateNormal];
    [[payHistoryButton titleLabel] setFont:[MIAFontManage getFontWithType:MIAFontType_Payment_Bar_RightButton]->font];
    [payHistoryButton setTitle:@"消费记录" forState:UIControlStateNormal];
    [payHistoryButton addTarget:self action:@selector(payHistoryAction) forControlEvents:UIControlEventTouchUpInside];
    [_barView addSubview:payHistoryButton];
    
    [payHistoryButton layoutRight:-10. layoutItemHandler:nil];
    [payHistoryButton layoutTop:0. layoutItemHandler:nil];
    [payHistoryButton layoutBottom:0. layoutItemHandler:nil];
    [payHistoryButton layoutWidth:[[payHistoryButton titleLabel] sizeThatFits:JOMAXSize].width+2 layoutItemHandler:nil];
    
    
    self.mTipLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Payment_Bar_M_Tip]];
    [_mTipLabel setText:@"剩余的M币"];
    [_mTipLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_mTipLabel];
    
    [_mTipLabel layoutTopView:_barView distance:kPaymentBarToTipSpaceDistance layoutItemHandler:nil];
    [_mTipLabel layoutLeft:0. layoutItemHandler:nil];
    [_mTipLabel layoutRight:0. layoutItemHandler:nil];
    [_mTipLabel layoutHeight:[_mTipLabel sizeThatFits:JOMAXSize].height+1 layoutItemHandler:nil];
    
    self.mLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Payment_Bar_M]];
    [_mLabel setText:@" "];
    [_mLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_mLabel];
    
    [_mLabel layoutTopView:_mTipLabel distance:kPaymentTipToMSpacedistance layoutItemHandler:nil];
    [_mLabel layoutLeft:0. layoutItemHandler:nil];
    [_mLabel layoutRight:0. layoutItemHandler:nil];
    [_mLabel layoutHeight:[_mLabel sizeThatFits:JOMAXSize].height+1 layoutItemHandler:nil];
    
}

#pragma mark - Bar item action

- (void)popAction{

    if (_paymentBarButtonClickBlock) {
        _paymentBarButtonClickBlock(PaymentBarButtonItemType_Pop);
    }
}

- (void)payHistoryAction{

    if (_paymentBarButtonClickBlock) {
        _paymentBarButtonClickBlock(PaymentBarButtonItemType_PayHistory);
    }
}

#pragma mark - Data

- (void)paymentBarButtonClickHandler:(PaymentBarButtonClickBlock)block{

    self.paymentBarButtonClickBlock = nil;
    self.paymentBarButtonClickBlock = block;
}

- (void)setMAmount:(NSString *)mAmount{

    [_mLabel setText:mAmount];
}

@end
