//
//  MIAPayHistoryView.m
//  Piano
//
//  Created by 刘维 on 16/5/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAPayHistoryCellView.h"
#import "UIImageView+WebCache.h"
#import "MIASendGiftModel.h"
#import "MIAOrderModel.h"
#import "JOBaseSDK.h"
#import "MIAFontManage.h"

static CGFloat const kGiftImageViewWidth = 51.;//礼物图片的宽度
static CGFloat const kPayHistoryImageToLabelSpaceDistance = 11.;//礼物与名字的间距大小

@interface MIAPayHistoryCellView()

@property (nonatomic, strong) UIImageView *giftImageView;
@property (nonatomic, strong) UIView *nameView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *mCountLabel;
@property (nonatomic, strong) UIImageView *mCoinImageView;

@property (nonatomic, strong) MIASendGiftModel *sendGiftModel;
@property (nonatomic, strong) MIAOrderModel *orderModel;

@end

@implementation MIAPayHistoryCellView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        [self createPayHistoryView];
    }
    return self;
}

- (void)createPayHistoryView{

    self.giftImageView = [UIImageView newAutoLayoutView];
    [_giftImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self addSubview:_giftImageView];
    
    [_giftImageView layoutLeft:0. layoutItemHandler:nil];
    [_giftImageView layoutCenterYView:self layoutItemHandler:nil];
    [_giftImageView layoutSize:JOSize(kGiftImageViewWidth, kGiftImageViewWidth) layoutItemHandler:nil];
    
    UIImage *mCoinImage = [UIImage imageNamed:@"LC-CoinIcon-L"];
    self.mCoinImageView = [UIImageView newAutoLayoutView];
    [_mCoinImageView setImage:[UIImage imageNamed:@"LC-CoinIcon-L"]];
    [self addSubview:_mCoinImageView];
    
    [_mCoinImageView layoutRight:-6. layoutItemHandler:nil];
    [_mCoinImageView layoutSize:mCoinImage.size layoutItemHandler:nil];
    [_mCoinImageView layoutCenterYView:self layoutItemHandler:nil];
    
    self.mCountLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_PayHistory_Amount]];
    [self addSubview:_mCountLabel];
    
    [_mCountLabel layoutRightView:_mCoinImageView distance:-2. layoutItemHandler:nil];
    [_mCountLabel layoutTopYView:_giftImageView distance:0. layoutItemHandler:nil];
    [_mCountLabel layoutBottomYView:_giftImageView distance:0. layoutItemHandler:nil];
    [_mCountLabel layoutWidth:30. layoutItemHandler:nil];
    
    self.nameView = [UIView newAutoLayoutView];
    [self addSubview:_nameView];
    
    self.nameLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_PayHistory_Title]];
    [_nameLabel setText:@" "];
    [_nameView addSubview:_nameLabel];
    
    CGFloat nameLabeHeight = [_nameLabel sizeThatFits:JOMAXSize].height;
    [_nameLabel layoutTop:0. layoutItemHandler:nil];
    [_nameLabel layoutLeft:0. layoutItemHandler:nil];
    [_nameLabel layoutRight:0. layoutItemHandler:nil];
    [_nameLabel layoutHeight:nameLabeHeight layoutItemHandler:nil];
    
    self.dateLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_PayHistory_Time]];
    [_dateLabel setText:@" "];
    [_nameView addSubview:_dateLabel];
    
    CGFloat dateLabelHeight = [_dateLabel sizeThatFits:JOMAXSize].height;
    [_dateLabel layoutLeft:0. layoutItemHandler:nil];
    [_dateLabel layoutRight:0. layoutItemHandler:nil];
    [_dateLabel layoutTopView:_nameLabel distance:4. layoutItemHandler:nil];
    [_dateLabel layoutHeight:dateLabelHeight layoutItemHandler:nil];
    
    [_nameView layoutLeftView:_giftImageView distance:kPayHistoryImageToLabelSpaceDistance layoutItemHandler:nil];
    [_nameView layoutHeight:nameLabeHeight+dateLabelHeight+4. layoutItemHandler:nil];
    [_nameView layoutRightView:_mCountLabel distance:0. layoutItemHandler:nil];
    [_nameView layoutCenterYView:self layoutItemHandler:nil];
}

- (void)setPayHistoryData:(id)data{

    if ([data isKindOfClass:[MIASendGiftModel class]]) {
        //礼物
        self.sendGiftModel = nil;
        self.sendGiftModel = data;
        
        [_giftImageView sd_setImageWithURL:[NSURL URLWithString:_sendGiftModel.iconUrl] placeholderImage:nil];

        [_nameLabel setText:_sendGiftModel.giftName];
        [_mCountLabel setText:[NSString stringWithFormat:@"%@",_sendGiftModel.mcoin]];//[NSString stringWithFormat:@"-%@M",_sendGiftModel.mcoin]
        NSString *month = [_sendGiftModel.addtime JOConvertTimelineToDateStringWithFormatterType:JODateFormatterMonth];
        NSString *day = [_sendGiftModel.addtime JOConvertTimelineToDateStringWithFormatterType:JODateFormatterDay];
        [_dateLabel setText:[NSString stringWithFormat:@"%@月%@日",month,day]];
        
        [_mCountLabel layoutWidth:[_mCountLabel sizeThatFits:JOMAXSize].width+1 layoutItemHandler:nil];
        
    }else if([data isKindOfClass:[MIAOrderModel class]]){
        //充值记录
        
        self.orderModel = nil;
        self.orderModel = data;
        
        [_nameLabel setText:[NSString stringWithFormat:@"充值 %@元",_orderModel.amount]];
        [_mCountLabel setText:[NSString stringWithFormat:@"+%@",_orderModel.body]];
        NSString *month = [_orderModel.createdTime JOConvertTimelineToDateStringWithFormatterType:JODateFormatterMonth];
        NSString *day = [_orderModel.createdTime JOConvertTimelineToDateStringWithFormatterType:JODateFormatterDay];
        [_dateLabel setText:[NSString stringWithFormat:@"%@月%@日",month,day]];
        [_giftImageView layoutWidth:CGFLOAT_MIN layoutItemHandler:nil];
        [_mCoinImageView setHidden:YES];
        
        [_mCountLabel layoutRight:-6. layoutItemHandler:nil];
        [_mCountLabel layoutWidth:[_mCountLabel sizeThatFits:JOMAXSize].width+1 layoutItemHandler:nil];
        
        [_nameView layoutLeft:0. layoutItemHandler:nil];
        
    }else{
    
        [JOFException exceptionWithName:@"MIAPayHistoryCellView exception!" reason:@"data必须为MIASendGiftModel 或者 MIAOrderModel 类型"];
    }
}

@end
