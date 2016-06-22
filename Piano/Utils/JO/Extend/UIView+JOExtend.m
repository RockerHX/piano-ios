//
//  UIView+JOExtend.m
//  Piano
//
//  Created by 刘维 on 16/5/5.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIView+JOExtend.h"

@implementation UIView(Extend)

+ (instancetype)newAutoLayoutView{
    
    UIView *view = [self new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}

- (instancetype)initForAutoLayout{
    
    self = [self init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (void)layoutWithItem:(JOLayoutItem *)item itemBlock:(JOViewLayoutBlock)block{

    if (block) {
        block(item);
    }
    [JOLayout layoutWithItem:item];
}

- (void)layoutLeft:(CGFloat)distance layoutItemHandler:(JOViewLayoutBlock)block{

    JOLayoutItem *item = [JOLayoutItem layoutLeftDistance:distance view:self];
    [self layoutWithItem:item itemBlock:block];
}

- (void)layoutLeftView:(UIView *)leftView distance:(CGFloat)distance layoutItemHandler:(JOViewLayoutBlock)block{

    JOLayoutItem *item = [JOLayoutItem layoutLeftView:leftView distance:distance view:self];
    [self layoutWithItem:item itemBlock:block];
};

- (void)layoutLeftXView:(UIView *)leftView distance:(CGFloat)distance layoutItemHandler:(JOViewLayoutBlock)block{

    JOLayoutItem *item = [JOLayoutItem layoutLeftXView:leftView distance:distance view:self];
    [self layoutWithItem:item itemBlock:block];
};

- (void)layoutRight:(CGFloat)distance layoutItemHandler:(JOViewLayoutBlock)block{

    JOLayoutItem *item = [JOLayoutItem layoutRightDistance:distance view:self];
    [self layoutWithItem:item itemBlock:block];
};

- (void)layoutRightView:(UIView *)leftView distance:(CGFloat)distance layoutItemHandler:(JOViewLayoutBlock)block{

    JOLayoutItem *item = [JOLayoutItem layoutRightView:leftView distance:distance view:self];
    [self layoutWithItem:item itemBlock:block];
};

- (void)layoutRightXView:(UIView *)leftView distance:(CGFloat)distance layoutItemHandler:(JOViewLayoutBlock)block{

    JOLayoutItem *item = [JOLayoutItem layoutRightXView:leftView distance:distance view:self];
    [self layoutWithItem:item itemBlock:block];
};

- (void)layoutTop:(CGFloat)distance layoutItemHandler:(JOViewLayoutBlock)block{

    JOLayoutItem *item = [JOLayoutItem layoutTopDistance:distance view:self];
    [self layoutWithItem:item itemBlock:block];
};

- (void)layoutTopView:(UIView *)leftView distance:(CGFloat)distance layoutItemHandler:(JOViewLayoutBlock)block{

    JOLayoutItem *item = [JOLayoutItem layoutTopView:leftView distance:distance view:self];
    [self layoutWithItem:item itemBlock:block];
};

- (void)layoutTopYView:(UIView *)leftView distance:(CGFloat)distance layoutItemHandler:(JOViewLayoutBlock)block{

    JOLayoutItem *item = [JOLayoutItem layoutTopYView:leftView distance:distance view:self];
    [self layoutWithItem:item itemBlock:block];
};

- (void)layoutBottom:(CGFloat)distance layoutItemHandler:(JOViewLayoutBlock)block{
    
    JOLayoutItem *item = [JOLayoutItem layoutBottomDistance:distance view:self];
    [self layoutWithItem:item itemBlock:block];
};

- (void)layoutBottomView:(UIView *)leftView distance:(CGFloat)distance layoutItemHandler:(JOViewLayoutBlock)block{
    
    JOLayoutItem *item = [JOLayoutItem layoutBottomView:leftView distance:distance view:self];
    [self layoutWithItem:item itemBlock:block];
};

- (void)layoutBottomYView:(UIView *)leftView distance:(CGFloat)distance layoutItemHandler:(JOViewLayoutBlock)block{
    
    JOLayoutItem *item = [JOLayoutItem layoutBottomYView:leftView distance:distance view:self];
    [self layoutWithItem:item itemBlock:block];
};

- (void)layoutWidth:(CGFloat)width layoutItemHandler:(JOViewLayoutBlock)block{

    JOLayoutItem *item = [JOLayoutItem layoutWidthDistance:width view:self];
    [self layoutWithItem:item itemBlock:block];
};

- (void)layoutWidthView:(UIView *)widthView ratio:(CGFloat)ratio layoutItemHandler:(JOViewLayoutBlock)block{

    JOLayoutItem *item = [JOLayoutItem layoutWidthView:widthView ratio:ratio view:self];
    [self layoutWithItem:item itemBlock:block];
};

- (void)layoutHeight:(CGFloat)height layoutItemHandler:(JOViewLayoutBlock)block{

    JOLayoutItem *item = [JOLayoutItem layoutHeightDistance:height view:self];
    [self layoutWithItem:item itemBlock:block];
};

- (void)layoutHeightView:(UIView *)heightView ratio:(CGFloat)ratio layoutItemHandler:(JOViewLayoutBlock)block{

    JOLayoutItem *item = [JOLayoutItem layoutHeightView:heightView ratio:ratio view:self];
    [self layoutWithItem:item itemBlock:block];
};

- (void)layoutCenterXView:(UIView *)centerView layoutItemHandler:(JOViewLayoutBlock)block{

    JOLayoutItem *item = [JOLayoutItem layoutCenterXView:centerView view:self];
    [self layoutWithItem:item itemBlock:block];
};

- (void)layoutCenterYView:(UIView *)centerView layoutItemHandler:(JOViewLayoutBlock)block{

    JOLayoutItem *item = [JOLayoutItem layoutCenterYView:centerView view:self];
    [self layoutWithItem:item itemBlock:block];
};

- (void)layoutCenterView:(UIView *)centerView layoutItemHandler:(JOViewLayoutBlock)block{

    JOLayoutItem *item = [JOLayoutItem layoutCenterXView:centerView view:self];
    JOLayoutItem *item2 = [JOLayoutItem layoutCenterYView:centerView view:self];
    [self layoutWithItem:item itemBlock:block];
    [self layoutWithItem:item2 itemBlock:block];
};

- (void)layoutWidthHeightRatio:(CGFloat)ratio layoutItemHandler:(JOViewLayoutBlock)block{

    JOLayoutItem *item = [JOLayoutItem layoutWidthHeightRatio:ratio view:self];
    [self layoutWithItem:item itemBlock:block];
};

- (void)layoutWidthHeightView:(UIView *)heightView ratio:(CGFloat)ratio layoutItemHandler:(JOViewLayoutBlock)block{

    JOLayoutItem *item = [JOLayoutItem layoutWidthHeightView:heightView ratio:ratio view:self];
    [self layoutWithItem:item itemBlock:block];
};

- (void)layoutHeightWidthView:(UIView *)widthView ratio:(CGFloat)ratio layoutItemHandler:(JOViewLayoutBlock)block{

    JOLayoutItem *item = [JOLayoutItem layoutWidthHeightView:widthView ratio:ratio view:self];
    [self layoutWithItem:item itemBlock:block];
};

- (void)layoutEdge:(UIEdgeInsets)edge layoutItemHandler:(JOViewLayoutBlock)block{

    [self layoutTop:edge.top layoutItemHandler:block];
    [self layoutLeft:edge.left layoutItemHandler:block];
    [self layoutBottom:edge.bottom layoutItemHandler:block];
    [self layoutRight:edge.right layoutItemHandler:block];
}

- (void)layoutSize:(CGSize)size layoutItemHandler:(JOViewLayoutBlock)block{

    [self layoutWidth:size.width layoutItemHandler:block];
    [self layoutHeight:size.height layoutItemHandler:block];
}

- (void)layouSameView:(UIView *)sameView layoutItemHandler:(JOViewLayoutBlock)block{

    [self layoutTopYView:sameView distance:0. layoutItemHandler:block];
    [self layoutBottomYView:sameView distance:0. layoutItemHandler:block];
    [self layoutLeftXView:sameView distance:0. layoutItemHandler:block];
    [self layoutRightXView:sameView distance:0. layoutItemHandler:block];
}

@end
