//
//  MIAPaymentAlertView.m
//  Piano
//
//  Created by 刘维 on 16/5/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAPaymentAlertView.h"
#import "JOBaseSDK.h"
#import "MIAFontManage.h"

//static CGFloat const kPaymentAlertHeight = 100.;
//static CGFloat const kPaymentAlertInsideTopSpaceDistance = 15.;
//static CGFloat const kPaymentAlertInsideBottomSpacedistance = 10.;
//static CGFloat const kPaymentAlertInsiderLeftRightSpaceDistance = 20.;
//static CGFloat const kPaymentAlertHeadHeight = 30.;
//static CGFloat const kPaymentAlertHeadImageToTitleSpaceDistance = 10.;
//static CGFloat const kPaymentAlertTitleToContentSpaceDistance = 10.;
//static CGFloat const kPaymentAlertContentToButtonSpaceDistance = 15.;

@interface MIAPaymentAlertView()

@property (nonatomic, strong) UIView *backMaskView;
@property (nonatomic, strong) UIView *paymentAlertView;
@property (nonatomic, strong) UIView *alertHeadView;
@property (nonatomic, strong) UIImageView *alertImageView;
@property (nonatomic, strong) UILabel *alertTitleLabel;
@property (nonatomic, strong) UILabel *alertContentLabel;
@property (nonatomic, strong) UIButton  *alertButton;

@end

@implementation MIAPaymentAlertView

- (instancetype)init{

    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)createAlertView{

    self.backMaskView = [UIView newAutoLayoutView];
    [_backMaskView setBackgroundColor:JORGBCreate(38., 38., 38., 0.6)];
//    [self addSubview:_backMaskView];
    
    self.paymentAlertView = [UIView newAutoLayoutView];
    [_paymentAlertView setBackgroundColor:[UIColor whiteColor]];
    [[_paymentAlertView layer] setCornerRadius:5.];
    [[_paymentAlertView layer] setMasksToBounds:YES];
    [_backMaskView addSubview:_paymentAlertView];
    
    self.alertHeadView = [UIView newAutoLayoutView];
    [_paymentAlertView addSubview:_alertHeadView];
    
    self.alertImageView = [UIImageView newAutoLayoutView];
    [_alertImageView setBackgroundColor:[UIColor grayColor]];
    [_alertHeadView addSubview:_alertImageView];
    
    self.alertTitleLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Payment_Alert_Title]];
    [_alertTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [_alertHeadView addSubview:_alertTitleLabel];
    
    self.alertContentLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Payment_Alert_Content]];
    [_alertContentLabel setTextAlignment:NSTextAlignmentCenter];
    [_paymentAlertView addSubview:_alertContentLabel];
    
    self.alertButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [_paymentAlertView addSubview:_alertButton];
}

- (void)setAlertTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle{

    [_alertTitleLabel setText:title];
    [_alertContentLabel setText:message];
    [_alertButton setTitle:buttonTitle forState:UIControlStateNormal];
    
}

- (void)updateAlertViewLayout{

    [JOAutoLayout removeAllAutoLayoutWithSelfView:_alertImageView superView:_alertHeadView];
    [JOAutoLayout removeAllAutoLayoutWithSelfView:_alertTitleLabel superView:_alertHeadView];
    [JOAutoLayout removeAllAutoLayoutWithSelfView:_alertHeadView superView:_paymentAlertView];
    [JOAutoLayout removeAllAutoLayoutWithSelfView:_alertContentLabel superView:_paymentAlertView];
    [JOAutoLayout removeAllAutoLayoutWithSelfView:_alertButton superView:_paymentAlertView];
    [JOAutoLayout removeAllAutoLayoutWithSelfView:_paymentAlertView superView:_backMaskView];

    //AlertHead
//    CGFloat titleLabelWidth = [_alertTitleLabel sizeThatFits:JOMAXSize].width+1;
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_alertTitleLabel superView:_alertHeadView];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_alertTitleLabel superView:_alertHeadView];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_alertTitleLabel superView:_alertHeadView];
//    []
    
//    [JOAutoLayout autoLayoutWithHeight:kPaymentAlertHeadHeight selfView:_alertHeadView superView:_paymentAlertView];
//    [JOAutoLayout autolayout]
}

@end
