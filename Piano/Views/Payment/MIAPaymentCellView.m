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
static CGFloat const kImageToMSpaceDistance = 5.;//M币的图片与M币的间距
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
    [_paymentImageView setImage:[UIImage imageNamed:@"LC-CoinIcon-L"]];
    [self addSubview:_paymentImageView];
    
    [_paymentImageView layoutCenterYView:self layoutItemHandler:nil];
    [_paymentImageView layoutLeft:0. layoutItemHandler:nil];
    [_paymentImageView layoutSize:JOSize(kImageWidth, kImageWidth) layoutItemHandler:nil];
    
    self.moneyAmountLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Payment_Pay_Money]];
    [_moneyAmountLabel setTextAlignment:NSTextAlignmentCenter];
    [[_moneyAmountLabel layer] setBorderWidth:1.];
    [[_moneyAmountLabel layer] setCornerRadius:4.];
    [[_moneyAmountLabel layer] setMasksToBounds:YES];
    [[_moneyAmountLabel layer] setBorderColor:[MIAFontManage getFontWithType:MIAFontType_Payment_Pay_Money]->color.CGColor];
    [self addSubview:_moneyAmountLabel];
    
    [_moneyAmountLabel layoutRight:0. layoutItemHandler:nil];
    [_moneyAmountLabel layoutCenterYView:self layoutItemHandler:nil];
    [_moneyAmountLabel layoutSize:JOSize(CGFLOAT_MIN, CGFLOAT_MIN) layoutItemHandler:nil];
    
    
    self.mAmountLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Payment_Pay_M]];
    
    [self addSubview:_mAmountLabel];
    
    [_mAmountLabel layoutLeftView:_paymentImageView distance:kImageToMSpaceDistance layoutItemHandler:nil];
    [_mAmountLabel layoutTop:0. layoutItemHandler:nil];
    [_mAmountLabel layoutBottom:0. layoutItemHandler:nil];
    [_mAmountLabel layoutRightView:_moneyAmountLabel distance:0. layoutItemHandler:nil];
}

- (void)setPaymentData:(id)data{

    if ([data isKindOfClass:[MIARechargeModel class]]) {
        
        self.rechargeModel = nil;
        self.rechargeModel = data;
        
        [_moneyAmountLabel setText:[NSString stringWithFormat:@"%@ 元",_rechargeModel.price]];
        CGFloat labelWidth = MAX([_moneyAmountLabel sizeThatFits:JOMAXSize].width + 2*kMoneyInsideLeftSpaceDistance, kPaymentMoneyLabelWidth);
        CGFloat labelHeight = [_moneyAmountLabel sizeThatFits:JOMAXSize].height + 2*kMoneyInsideTopSpaceDistance;
        
        [_moneyAmountLabel layoutSize:JOSize(labelWidth, labelHeight) layoutItemHandler:nil];
        
        [_mAmountLabel setText:_rechargeModel.name];
        
    }else{
        
        [JOFException exceptionWithName:@"MIAPaymentCellView exception!" reason:@"data 必须是MIARechargeModel类型"];
    }
}

@end
