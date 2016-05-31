//
//  MIAItemsView.m
//  Piano
//
//  Created by 刘维 on 16/5/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAItemsView.h"
#import "JOBaseSDK.h"
#import "MIAFontManage.h"

static CGFloat const kAnimationViewHeight = 2.;//动画的视图的高度

@interface MIAItemsView()

@property (nonatomic, copy) NSArray *itemsarray;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *animationView;

@property (nonatomic, strong) UIColor *itemTitleColor;
@property (nonatomic, strong) UIFont *itemTitleFont;

@property (nonatomic, copy) ItemClickBlock itemClickBlock;

@end

@implementation MIAItemsView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.itemTitleColor = [UIColor blackColor];
        self.itemTitleFont = [UIFont systemFontOfSize:17.];
        
        [self createItemsView];
    }
    return self;
}

- (void)createItemsView{

    self.contentView = [UIView newAutoLayoutView];
    [self addSubview:_contentView];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., -kAnimationViewHeight, 0.) selfView:_contentView superView:self];
    
    UIView *separateLineView = [UIView newAutoLayoutView];
    [separateLineView setBackgroundColor:JORGBSameCreate(230.)];
    [self addSubview:separateLineView];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:separateLineView superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:separateLineView superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:separateLineView superView:self];
    [JOAutoLayout autoLayoutWithHeight:kAnimationViewHeight selfView:separateLineView superView:self];
    
    self.animationView = [UIView newAutoLayoutView];
    [self addSubview:_animationView];
    
    [JOAutoLayout autoLayoutWithSameView:separateLineView selfView:_animationView superView:self];
}

- (void)setItemArray:(NSArray *)itemArray{

    self.itemsarray = nil;
    self.itemsarray = itemArray;
    
    if ([itemArray count]) {
        [JOAutoLayout removeAutoLayoutWithRightSelfView:_animationView superView:self];
        [JOAutoLayout autoLayoutWithWidthWithView:self ratioValue:1./[itemArray count] selfView:_animationView superView:self];
    }
    
    [self updateItemButtonView];
}

- (void)setItemTitleColor:(UIColor *)color titleFont:(UIFont *)font{

    self.itemTitleColor = nil;
    self.itemTitleColor = color;
    
    self.itemTitleFont = nil;
    self.itemTitleFont = font;
    
    [self updateItemButtonView];
}

- (void)removeAllItemButtonView{

    for (UIView *subView in [_contentView subviews]) {
        [subView setHidden:YES];
        [subView removeFromSuperview];
    }
}

- (void)updateItemButtonView{
    
    [self removeAllItemButtonView];

    for (int i = 0; i < [_itemsarray count]; i++) {
        
        UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [itemButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [itemButton setTitle:[_itemsarray objectAtIndex:i] forState:UIControlStateNormal];
        [itemButton setTitleColor:_itemTitleColor forState:UIControlStateNormal];
        [[itemButton titleLabel] setFont:_itemTitleFont];
        [itemButton setTag:i+1];
        [itemButton addTarget:self action:@selector(itemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:itemButton];
        
        [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:itemButton superView:_contentView];
        [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:itemButton superView:_contentView];
        [JOAutoLayout autoLayoutWithWidthWithView:_contentView ratioValue:1./[_itemsarray count] selfView:itemButton superView:_contentView];
        
        if (i) {
            //非第一个
            UIView *lastView = [_contentView viewWithTag:i];
            [JOAutoLayout autoLayoutWithLeftView:lastView distance:0. selfView:itemButton superView:_contentView];
        }else{
            //第一个
            [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:itemButton superView:_contentView];
        }
    }
}

- (void)setAnimationOffsetX:(CGFloat)offsetX{

    [JOAutoLayout removeAutoLayoutWithLeftSelfView:_animationView superView:self];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:offsetX selfView:_animationView superView:self];
}

- (void)setAnimationColor:(UIColor *)color{

    [_animationView setBackgroundColor:color];
}

#pragma mark - Block

- (void)itemClickHanlder:(ItemClickBlock)block{

    self.itemClickBlock = nil;
    self.itemClickBlock = block;
}

#pragma mark - Button action

- (void)itemButtonClick:(id)sender{

    UIButton *button = (UIButton *)sender;
    if (_itemClickBlock) {
        _itemClickBlock(button.tag-1, [button titleForState:UIControlStateNormal]);
    }
}

@end
