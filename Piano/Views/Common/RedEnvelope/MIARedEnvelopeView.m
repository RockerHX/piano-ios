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
        
        [_redImageView layoutSize:JOSize(kRedImageViewWidth, kRedImageViewHeight) layoutItemHandler:nil];
        [_redImageView layoutCenterView:self layoutItemHandler:nil];
        
        self.titleLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_RedEnvelope_Title]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [_titleLabel setText:@" "];
        [_redImageView addSubview:_titleLabel];
        
        [_titleLabel layoutLeft:10. layoutItemHandler:nil];
        [_titleLabel layoutRight:-10. layoutItemHandler:nil];
        [_titleLabel layoutTop:kTitleTopSpaceDistance layoutItemHandler:nil];
        [_titleLabel layoutHeight:[_titleLabel sizeThatFits:JOMAXSize].height layoutItemHandler:nil];
        
        self.tipLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_RedEnvelope_Tip]];
        [_tipLabel setTextAlignment:NSTextAlignmentCenter];
        [_tipLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [_tipLabel setText:@" "];
        [_redImageView addSubview:_tipLabel];
        
        [_tipLabel layoutLeftXView:_titleLabel distance:0. layoutItemHandler:nil];
        [_tipLabel layoutRightXView:_titleLabel distance:0. layoutItemHandler:nil];
        [_tipLabel layoutTopView:_titleLabel distance:kTitleToTipSpaceDistance layoutItemHandler:nil];
        [_tipLabel layoutHeight:[_tipLabel sizeThatFits:JOMAXSize].height layoutItemHandler:nil];
        
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
        
        [_receiveButton layoutSize:JOSize(kReceiveButtonWidth, kReceiveButtonHeight) layoutItemHandler:nil];
        [_receiveButton layoutTopView:_tipLabel distance:kTipToButtonSpaceDistance layoutItemHandler:nil];
        [_receiveButton layoutCenterXView:_redImageView layoutItemHandler:nil];
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
        [self layoutEdge:UIEdgeInsetsMake(0., 0., 0., 0.) layoutItemHandler:nil];
    }else{
    
        UIView *rootView = [[UIApplication sharedApplication].delegate.window rootViewController].view;
        [rootView addSubview:self];
        [self layoutEdge:UIEdgeInsetsMake(0., 0., 0., 0.) layoutItemHandler:nil];
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
