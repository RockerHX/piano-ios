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
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_giftImageView superView:self];
//    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_giftImageView superView:self];
    [JOAutoLayout autoLayoutWithCenterYWithView:self selfView:_giftImageView superView:self];
    [JOAutoLayout autoLayoutWithSize:JOSize(kGiftImageViewWidth, kGiftImageViewWidth) selfView:_giftImageView superView:self];
    
    UIImage *mCoinImage = [UIImage imageNamed:@"LC-CoinIcon-L"];
    self.mCoinImageView = [UIImageView newAutoLayoutView];
    [_mCoinImageView setImage:[UIImage imageNamed:@"LC-CoinIcon-L"]];
    [self addSubview:_mCoinImageView];
    
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-6. selfView:_mCoinImageView superView:self];
    [JOAutoLayout autoLayoutWithSize:mCoinImage.size selfView:_mCoinImageView superView:self];
    [JOAutoLayout autoLayoutWithCenterYWithView:self selfView:_mCoinImageView superView:self];
    
    self.mCountLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_PayHistory_Amount]];
    [self addSubview:_mCountLabel];
    
//    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_mCountLabel superView:self];
    [JOAutoLayout autoLayoutWithRightView:_mCoinImageView distance:-2. selfView:_mCountLabel superView:self];
    [JOAutoLayout autoLayoutWithTopYView:_giftImageView selfView:_mCountLabel superView:self];
    [JOAutoLayout autoLayoutWithBottomYView:_giftImageView selfView:_mCountLabel superView:self];
    [JOAutoLayout autoLayoutWithWidth:30. selfView:_mCountLabel superView:self];
    
    self.nameView = [UIView newAutoLayoutView];
    [self addSubview:_nameView];
    
    self.nameLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_PayHistory_Title]];
    [_nameLabel setText:@" "];
    [_nameView addSubview:_nameLabel];
    
//    [JOAutoLayout autoLayoutWithLeftView:_giftImageView distance:kPayHistoryImageToLabelSpaceDistance selfView:_nameLabel superView:self];
//    [JOAutoLayout autoLayoutWithTopYView:_giftImageView selfView:_nameLabel superView:self];
//    [JOAutoLayout autoLayoutWithRightView:_mCountLabel distance:0. selfView:_nameLabel superView:self];
//    [JOAutoLayout autoLayoutWithHeight:[_nameLabel sizeThatFits:JOMAXSize].height selfView:_nameLabel superView:self];
    CGFloat nameLabeHeight = [_nameLabel sizeThatFits:JOMAXSize].height;
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_nameLabel superView:_nameView];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_nameLabel superView:_nameView];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_nameLabel superView:_nameView];
    [JOAutoLayout autoLayoutWithHeight:nameLabeHeight selfView:_nameLabel superView:_nameView];
    
    self.dateLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_PayHistory_Time]];
    [_dateLabel setText:@" "];
    [_nameView addSubview:_dateLabel];
    
//    [JOAutoLayout autoLayoutWithLeftXView:_nameLabel selfView:_dateLabel superView:self];
//    [JOAutoLayout autoLayoutWithTopView:_nameLabel distance:4. selfView:_dateLabel superView:self];
//    [JOAutoLayout autoLayoutWithRightXView:_nameLabel selfView:_dateLabel superView:self];
//    [JOAutoLayout autoLayoutWithHeight:[_dateLabel sizeThatFits:JOMAXSize].height selfView:_dateLabel superView:self];
    CGFloat dateLabelHeight = [_dateLabel sizeThatFits:JOMAXSize].height;
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_dateLabel superView:_nameView];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_dateLabel superView:_nameView];
    [JOAutoLayout autoLayoutWithTopView:_nameLabel distance:4. selfView:_dateLabel superView:_nameView];
    [JOAutoLayout autoLayoutWithHeight:dateLabelHeight selfView:_dateLabel superView:_nameView];
    
    [JOAutoLayout autoLayoutWithLeftView:_giftImageView distance:kPayHistoryImageToLabelSpaceDistance selfView:_nameView superView:self];
    [JOAutoLayout autoLayoutWithHeight:nameLabeHeight+dateLabelHeight+4. selfView:_nameView superView:self];
    [JOAutoLayout autoLayoutWithRightView:_mCountLabel distance:0. selfView:_nameView superView:self];
    [JOAutoLayout autoLayoutWithCenterYWithView:self selfView:_nameView superView:self];
    
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
        
        [JOAutoLayout removeAutoLayoutWithWidthSelfView:_mCountLabel superView:self];
        [JOAutoLayout autoLayoutWithWidth:[_mCountLabel sizeThatFits:JOMAXSize].width+1 selfView:_mCountLabel superView:self];
        
    }else if([data isKindOfClass:[MIAOrderModel class]]){
        //充值记录
        
        self.orderModel = nil;
        self.orderModel = data;
        
        [_nameLabel setText:[NSString stringWithFormat:@"充值 %@元",_orderModel.amount]];
        [_mCountLabel setText:[NSString stringWithFormat:@"+%@",_orderModel.body]];
        NSString *month = [_orderModel.createdTime JOConvertTimelineToDateStringWithFormatterType:JODateFormatterMonth];
        NSString *day = [_orderModel.createdTime JOConvertTimelineToDateStringWithFormatterType:JODateFormatterDay];
        [_dateLabel setText:[NSString stringWithFormat:@"%@月%@日",month,day]];
    
        [JOAutoLayout removeAutoLayoutWithWidthSelfView:_giftImageView superView:self];
        [JOAutoLayout autoLayoutWithWidth:CGFLOAT_MIN selfView:_giftImageView superView:self];
        
        [_mCoinImageView setHidden:YES];
        
        [JOAutoLayout removeAutoLayoutWithWidthSelfView:_mCountLabel superView:self];
        [JOAutoLayout removeAutoLayoutWithRightSelfView:_mCountLabel superView:self];
        [JOAutoLayout autoLayoutWithRightSpaceDistance:-6. selfView:_mCountLabel superView:self];
        [JOAutoLayout autoLayoutWithWidth:[_mCountLabel sizeThatFits:JOMAXSize].width+1 selfView:_mCountLabel superView:self];
        
        [JOAutoLayout removeAutoLayoutWithLeftSelfView:_nameView superView:self];
        [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_nameView superView:self];
        
    }else{
    
        [JOFException exceptionWithName:@"MIAPayHistoryCellView exception!" reason:@"data必须为MIASendGiftModel 或者 MIAOrderModel 类型"];
    }
}

@end
