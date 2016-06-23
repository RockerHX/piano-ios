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
@property (nonatomic, strong) UIColor *itemSelectedTitleColor;
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
    
    [_contentView layoutEdge:UIEdgeInsetsMake(0., 0., -kAnimationViewHeight, 0.) layoutItemHandler:nil];
    
    UIView *separateLineView = [UIView newAutoLayoutView];
    [separateLineView setBackgroundColor:JORGBSameCreate(230.)];
    [self addSubview:separateLineView];
    
    [separateLineView layoutLeft:0. layoutItemHandler:nil];
    [separateLineView layoutRight:0. layoutItemHandler:nil];
    [separateLineView layoutBottom:0. layoutItemHandler:nil];
    [separateLineView layoutHeight:kAnimationViewHeight layoutItemHandler:nil];
    
    self.animationView = [UIView newAutoLayoutView];
    [self addSubview:_animationView];
    
    [_animationView layoutSameView:separateLineView layoutItemHandler:nil];
}

- (void)setItemArray:(NSArray *)itemArray{

    self.itemsarray = nil;
    self.itemsarray = itemArray;
    
    if ([itemArray count]) {
        
        [JOLayout removeRightLayoutWithView:_animationView];
        [_animationView layoutWidthView:self ratio:1./[itemArray count] layoutItemHandler:nil];
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
        
        [itemButton layoutTop:0. layoutItemHandler:nil];
        [itemButton layoutBottom:0. layoutItemHandler:nil];
        [itemButton layoutWidthView:_contentView ratio:1./[_itemsarray count] layoutItemHandler:nil];
        
        if (i) {
            //非第一个
            UIView *lastView = [_contentView viewWithTag:i];
            [itemButton layoutLeftView:lastView distance:0. layoutItemHandler:nil];
        }else{
            //第一个
            [itemButton layoutLeft:0. layoutItemHandler:nil];
        }
    }
}

- (void)setAnimationOffsetX:(CGFloat)offsetX{

    [_animationView layoutLeft:offsetX layoutItemHandler:nil];
}

- (void)setAnimationColor:(UIColor *)color{

    [_animationView setBackgroundColor:color];
}

- (void)setItemTitleSelectedColor:(UIColor *)color{

    self.itemSelectedTitleColor = nil;
    self.itemSelectedTitleColor = color;
}

- (void)setCurrentSelectedIndex:(NSInteger)index{
    
    for (int i = 0; i < [_itemsarray count]; i++) {
        [(UIButton *)[_contentView viewWithTag:i+1] setTitleColor:_itemTitleColor forState:UIControlStateNormal];
    }
    [(UIButton *)[_contentView viewWithTag:index+1] setTitleColor:_itemSelectedTitleColor forState:UIControlStateNormal];
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
