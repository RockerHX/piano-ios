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
static CGFloat const kPaymentBarTopSpaceDistance = 20.; //Bar的上部的间距大小
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
    
    [JOAutoLayout autoLayoutWithTopSpaceDistance:kPaymentBarTopSpaceDistance selfView:_barView superView:self];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_barView superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_barView superView:self];
    [JOAutoLayout autoLayoutWithHeight:kPaymentBarHeight selfView:_barView superView:self];
    
    UILabel *barTitleLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType: MIAFontType_Payment_Bar_Title]];
    [barTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [barTitleLabel setText:@"充值"];
    [_barView addSubview:barTitleLabel];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:barTitleLabel superView:_barView];
    
    
    UIButton *popButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [popButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [popButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [popButton setTitle:@"《" forState:UIControlStateNormal];
    [popButton addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    [_barView addSubview:popButton];
    
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:popButton superView:_barView];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:10. selfView:popButton superView:_barView];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:popButton superView:_barView];
    [JOAutoLayout autoLayoutWithWidthEqualHeightWithselfView:popButton superView:_barView];
    
    UIButton *payHistoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [payHistoryButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [payHistoryButton setTitleColor:[MIAFontManage getFontWithType:MIAFontType_Payment_Bar_RightButton]->color forState:UIControlStateNormal];
    [[payHistoryButton titleLabel] setFont:[MIAFontManage getFontWithType:MIAFontType_Payment_Bar_RightButton]->font];
    [payHistoryButton setTitle:@"消费记录" forState:UIControlStateNormal];
    [payHistoryButton addTarget:self action:@selector(payHistoryAction) forControlEvents:UIControlEventTouchUpInside];
    [_barView addSubview:payHistoryButton];
    
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-10. selfView:payHistoryButton superView:_barView];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:payHistoryButton superView:_barView];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:payHistoryButton superView:_barView];
    [JOAutoLayout autoLayoutWithWidth:[[payHistoryButton titleLabel] sizeThatFits:JOMAXSize].width+2 selfView:payHistoryButton superView:_barView];
    
    
    self.mTipLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Payment_Bar_M_Tip]];
    [_mTipLabel setText:@"剩余的M币"];
    [_mTipLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_mTipLabel];
    
    [JOAutoLayout autoLayoutWithTopView:_barView distance:kPaymentBarToTipSpaceDistance selfView:_mTipLabel superView:self];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_mTipLabel superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_mTipLabel superView:self];
    [JOAutoLayout autoLayoutWithHeight:[_mTipLabel sizeThatFits:JOMAXSize].height+1 selfView:_mTipLabel superView:self];
    
    self.mLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Payment_Bar_M]];
    [_mLabel setText:@" "];
    [_mLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_mLabel];
    
    [JOAutoLayout autoLayoutWithTopView:_mTipLabel distance:kPaymentTipToMSpacedistance selfView:_mLabel superView:self];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_mLabel superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_mLabel superView:self];
    [JOAutoLayout autoLayoutWithHeight:[_mLabel sizeThatFits:JOMAXSize].height+1 selfView:_mLabel superView:self];
    
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
