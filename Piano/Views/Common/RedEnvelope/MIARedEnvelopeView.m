//
//  MIARedEnvelopeView.m
//  Piano
//
//  Created by 刘维 on 16/6/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIARedEnvelopeView.h"
#import "JOBaseSdk.h"
#import "MIAFontManage.h"

static CGFloat const kRedImageViewWidth = 232.;//红包的宽度
static CGFloat const kRedImageViewHeight = 280.;//红包的高度
static CGFloat const kTitleTopSpaceDistance = 128.;//标题与头部的间距大小.
static CGFloat const kTitleToTipSpaceDistance = 9.;//标题与提示的间距大小.
static CGFloat const kTipToButtonSpaceDistance = 28.;//提示与按钮的间距大小.
static CGFloat const kReceiveButtonWidth = 165.;//按钮的宽度
static CGFloat const kReceiveButtonHeight = 41.;//按钮的高度


@interface MIARedEnvelopeView()

@property (nonatomic, strong) UIImageView *redImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *receiveButton;

@property (nonatomic, copy) ReceiveBlock receiveBlock;

@end

@implementation MIARedEnvelopeView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:JORGBCreate(0., 0., 0., 0.3)];
        [self createRedEnvelopeView];
    }
    return self;
}

- (void)createRedEnvelopeView{
    
    if (!self.redImageView) {

        self.redImageView = [UIImageView newAutoLayoutView];
        [_redImageView setImage:[UIImage imageNamed:@"C-RedEnvelope"]];
        [_redImageView setUserInteractionEnabled:YES];
        [self addSubview:_redImageView];
        
        [JOAutoLayout autoLayoutWithSize:JOSize(kRedImageViewWidth, kRedImageViewHeight) selfView:_redImageView superView:self];
        [JOAutoLayout autoLayoutWithCenterWithView:self selfView:_redImageView superView:self];
        
        self.titleLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_RedEnvelope_Title]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [_titleLabel setText:@" "];
        [_redImageView addSubview:_titleLabel];
        
        [JOAutoLayout autoLayoutWithLeftSpaceDistance:10. selfView:_titleLabel superView:_redImageView];
        [JOAutoLayout autoLayoutWithRightSpaceDistance:-10. selfView:_titleLabel superView:_redImageView];
        [JOAutoLayout autoLayoutWithTopSpaceDistance:kTitleTopSpaceDistance selfView:_titleLabel superView:_redImageView];
        [JOAutoLayout autoLayoutWithHeight:[_titleLabel sizeThatFits:JOMAXSize].height selfView:_titleLabel superView:_redImageView];
        
        self.tipLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_RedEnvelope_Tip]];
        [_tipLabel setTextAlignment:NSTextAlignmentCenter];
        [_tipLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [_tipLabel setText:@" "];
        [_redImageView addSubview:_tipLabel];
        
        [JOAutoLayout autoLayoutWithLeftXView:_titleLabel selfView:_tipLabel superView:_redImageView];
        [JOAutoLayout autoLayoutWithRightXView:_titleLabel selfView:_tipLabel superView:_redImageView];
        [JOAutoLayout autoLayoutWithTopView:_titleLabel distance:kTitleToTipSpaceDistance selfView:_tipLabel superView:_redImageView];
        [JOAutoLayout autoLayoutWithHeight:[_tipLabel sizeThatFits:JOMAXSize].height selfView:_tipLabel superView:_redImageView];
        
        self.receiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_receiveButton setUserInteractionEnabled:YES];
        [_receiveButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_receiveButton setTitle:@"领取" forState:UIControlStateNormal];
        [_receiveButton setBackgroundColor:[UIColor whiteColor]];
        [[_receiveButton layer] setCornerRadius:kReceiveButtonHeight/2.];
        [[_receiveButton layer] setMasksToBounds:YES];
        [_receiveButton setTitleColor:[MIAFontManage getFontWithType:MIAFontType_RedEnveLope_ButtonTitle]->color forState:UIControlStateNormal];
        [[_receiveButton titleLabel] setFont:[MIAFontManage getFontWithType:MIAFontType_RedEnveLope_ButtonTitle]->font];
        [_receiveButton addTarget:self action:@selector(receiveAction) forControlEvents:UIControlEventTouchUpInside];
        [_redImageView addSubview:_receiveButton];
        
        [JOAutoLayout autoLayoutWithSize:JOSize(kReceiveButtonWidth, kReceiveButtonHeight) selfView:_receiveButton superView:_redImageView];
        [JOAutoLayout autoLayoutWithTopView:_tipLabel distance:kTipToButtonSpaceDistance selfView:_receiveButton superView:_redImageView];
        [JOAutoLayout autoLayoutWithCenterXWithView:_redImageView selfView:_receiveButton superView:_redImageView];
    }
}

- (void)setTitle:(NSString *)title tip:(NSString *)tip{

    [_titleLabel setText:title];
    [_tipLabel setText:tip];
}

- (void)showInView:(UIView *)view receiveHandler:(ReceiveBlock)handler{

    [self setHidden:NO];
    self.receiveBlock = nil;
    self.receiveBlock = handler;
    if (view) {
        [view addSubview:self];
        [JOAutoLayout removeAllAutoLayoutWithSelfView:self superView:view];
        [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:self superView:view];
    }else{
    
        UIView *rootView = [[UIApplication sharedApplication].delegate.window rootViewController].view;
        [rootView addSubview:self];
        [JOAutoLayout removeAllAutoLayoutWithSelfView:self superView:rootView];
        [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:self superView:rootView];
    }
}

- (void)hidden{

    [self setHidden:YES];
}

#pragma mark - Button action

- (void)receiveAction{
    
    if (_receiveBlock) {
        _receiveBlock();
    }
}

@end
