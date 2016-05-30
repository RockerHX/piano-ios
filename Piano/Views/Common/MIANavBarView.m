//
//  MIANavBarView.m
//  Piano
//
//  Created by 刘维 on 16/5/26.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIANavBarView.h"
#import "JOBaseSDK.h"
#import "MIAFontManage.h"

static CGFloat const kLeftButtonWidth = 60.;//left按钮的宽度.
static CGFloat const kRightButtonWidth = 60.;//right按钮的宽度.

@interface MIANavBarView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, copy) ButtonClickBlock leftButtonClickBlock;
@property (nonatomic, copy) ButtonClickBlock rightButtonClickBlock;

@end

@implementation MIANavBarView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        [self createBarView];
    }
    return self;
}

- (void)createBarView{

    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_leftButton setHidden:YES];
    [_leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftButton];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_leftButton superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_leftButton superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_leftButton superView:self];
    [JOAutoLayout autoLayoutWithWidth:kLeftButtonWidth selfView:_leftButton superView:self];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_rightButton setHidden:YES];
    [_rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightButton];
    
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_rightButton superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_rightButton superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_rightButton superView:self];
    [JOAutoLayout autoLayoutWithWidth:kRightButtonWidth selfView:_rightButton superView:self];
    
    self.titleLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_NavBar_Title]];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_titleLabel];
    
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_titleLabel superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_titleLabel superView:self];
    [JOAutoLayout autoLayoutWithLeftView:_leftButton distance:0. selfView:_titleLabel superView:self];
    [JOAutoLayout autoLayoutWithRightView:_rightButton distance:0. selfView:_titleLabel superView:self];
    
}

#pragma mark -  show data

- (void)showBottomLineView{

    UIView *bottomLineView = [UIView newAutoLayoutView];
    [bottomLineView setBackgroundColor:JORGBSameCreate(235.)];
    [self addSubview:bottomLineView];
    
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:-0.5 selfView:bottomLineView superView:self];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:bottomLineView superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:bottomLineView superView:self];
    [JOAutoLayout autoLayoutWithHeight:0.5 selfView:bottomLineView superView:self];
}

- (void)setTitle:(NSString *)title{

    [_titleLabel setText:title];
}

- (UILabel *)navBarTitleLabel{

    return _titleLabel;
}

- (void)setLeftButtonTitle:(NSString *)buttonTitle titleColor:(UIColor *)color{

    [_leftButton setTitle:buttonTitle forState:UIControlStateNormal];
    [_leftButton setTitleColor:color forState:UIControlStateNormal];
}

- (void)setLeftButtonImageName:(NSString *)imageName{

    [_leftButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (UIButton *)navBarLeftButton{

    return _leftButton;
}

- (void)setRightButtonTitle:(NSString *)buttonTitle titleColor:(UIColor *)color{

    [_rightButton setTitle:buttonTitle forState:UIControlStateNormal];
    [_rightButton setTitleColor:color forState:UIControlStateNormal];
}

- (void)setRightButtonImageName:(NSString *)imageName{

    [_rightButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (UIButton *)navBarRightButton{

    return _rightButton;
}

#pragma mark - Block

- (void)navBarLeftClickHanlder:(ButtonClickBlock)leftClickBlock rightClickHandler:(ButtonClickBlock)rightClickBlock{

    if (leftClickBlock) {
        self.leftButtonClickBlock = nil;
        self.leftButtonClickBlock = leftClickBlock;
        
        [_leftButton setHidden:NO];
    }else{
        //隐藏按钮
        [_leftButton setHidden:YES];
    }
    
    if (rightClickBlock) {
        self.rightButtonClickBlock = nil;
        self.rightButtonClickBlock = rightClickBlock;
        
        [_rightButton setHidden:NO];
    }else{
        //隐藏右边的按钮
        [_rightButton setHidden:YES];
    }
    
}

#pragma mark - button click

- (void)leftButtonClick{

    if (_leftButtonClickBlock) {
        _leftButtonClickBlock();
    }
}

- (void)rightButtonClick{

    if (_rightButtonClickBlock) {
        _rightButtonClickBlock();
    }
}

@end
