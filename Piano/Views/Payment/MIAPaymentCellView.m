//
//  MIAPaymentView.m
//  Piano
//
//  Created by 刘维 on 16/5/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAPaymentCellView.h"
#import "MIARechargeModel.h"
#import "MIAFontManage.h"
#import "JOBaseSDK.h"

static CGFloat const kImageWidth = 30.;//图片的宽度
static CGFloat const kImageToMSpaceDistance = 15.;//M币的图片与M币的间距
static CGFloat const kMoneyInsideLeftSpaceDistance = 5.;//金额label左边的间距大小
static CGFloat const kMoneyInsideTopSpaceDistance = 4.;//金额label头部的间距大小
static CGFloat const kPaymentMoneyLabelWidth = 60.;

@interface MIAPaymentCellView()

@property (nonatomic, strong) UIImageView *paymentImageView;
@property (nonatomic, strong) UILabel *mAmountLabel;
@property (nonatomic, strong) UILabel *moneyAmountLabel;

@property (nonatomic, strong) MIARechargeModel *rechargeModel;

@end

@implementation MIAPaymentCellView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        [self createPaymentView];
    }
    return self;
}

- (void)createPaymentView{

    self.paymentImageView = [UIImageView newAutoLayoutView];
    [_paymentImageView setBackgroundColor:[UIColor grayColor]];
    [self addSubview:_paymentImageView];
    
    [JOAutoLayout autoLayoutWithCenterYWithView:self selfView:_paymentImageView superView:self];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_paymentImageView superView:self];
    [JOAutoLayout autoLayoutWithSize:JOSize(kImageWidth, kImageWidth) selfView:_paymentImageView superView:self];
    
    self.moneyAmountLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Payment_Pay_Money]];
    [_moneyAmountLabel setTextAlignment:NSTextAlignmentCenter];
    [[_moneyAmountLabel layer] setBorderWidth:1.];
    [[_moneyAmountLabel layer] setCornerRadius:4.];
    [[_moneyAmountLabel layer] setMasksToBounds:YES];
    [[_moneyAmountLabel layer] setBorderColor:[MIAFontManage getFontWithType:MIAFontType_Payment_Pay_Money]->color.CGColor];
    [self addSubview:_moneyAmountLabel];
    
    
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_moneyAmountLabel superView:self];
    [JOAutoLayout autoLayoutWithCenterYWithView:self selfView:_moneyAmountLabel superView:self];
    [JOAutoLayout autoLayoutWithSize:JOSize(CGFLOAT_MIN, CGFLOAT_MIN) selfView:_moneyAmountLabel superView:self];
    
    
    self.mAmountLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Payment_Pay_M]];
    
    [self addSubview:_mAmountLabel];
    
    [JOAutoLayout autoLayoutWithLeftView:_paymentImageView distance:kImageToMSpaceDistance selfView:_mAmountLabel superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_mAmountLabel superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_mAmountLabel superView:self];
    [JOAutoLayout autoLayoutWithRightView:_moneyAmountLabel distance:0. selfView:_mAmountLabel superView:self];
}

- (void)setPaymentData:(id)data{

    if ([data isKindOfClass:[MIARechargeModel class]]) {
        
        self.rechargeModel = nil;
        self.rechargeModel = data;
        
        [_moneyAmountLabel setText:[NSString stringWithFormat:@"%@ 元",_rechargeModel.price]];
        CGFloat labelWidth = MAX([_moneyAmountLabel sizeThatFits:JOMAXSize].width + 2*kMoneyInsideLeftSpaceDistance, kPaymentMoneyLabelWidth);
        CGFloat labelHeight = [_moneyAmountLabel sizeThatFits:JOMAXSize].height + 2*kMoneyInsideTopSpaceDistance;
        
        [JOAutoLayout removeAutoLayoutWithSizeSelfView:_moneyAmountLabel superView:self];
        [JOAutoLayout autoLayoutWithSize:JOSize(labelWidth, labelHeight) selfView:_moneyAmountLabel superView:self];
        
        [_mAmountLabel setText:_rechargeModel.name];
        
    }else{
        
        [JOFException exceptionWithName:@"MIAPaymentCellView exception!" reason:@"data 必须是MIARechargeModel类型"];
    }
}

@end
