//
//  JOLayoutItem.h
//  Piano
//
//  Created by 刘维 on 16/6/21.
//  Copyright © 2016年 Mia Music. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JOLayoutItemProperty) {
    
    JOLayoutItemPropertyLeft,
    JOLayoutItemPropertyRight,
    JOLayoutItemPropertyTop,
    JOLayoutItemPropertyBottom,
    JOLayoutItemPropertyWidth,
    JOLayoutItemPropertyHeight,
    JOLayoutItemPropertyCenterX,
    JOLayoutItemPropertyCenterY,
    
    JOLayoutItemPropertyUnKnow,
};

@interface JOLayoutItem : NSObject

@property (nonatomic, strong) UIView *view; //需要添加的约束的视图.
@property (nonatomic, assign) NSLayoutAttribute viewAttribute;//约束的属性
@property (nonatomic, strong) UIView *realteView;//与约束相关连的视图.
@property (nonatomic, assign) NSLayoutAttribute realteViewAttribute;//与约束相关联的视图的属性.
@property (nonatomic, assign) NSLayoutRelation relation;//关系
@property (nonatomic, assign) CGFloat ratio;//比率
@property (nonatomic, assign) CGFloat distance;//距离
@property (nonatomic, assign) UILayoutPriority priority;//优先级.
@property (nonatomic, assign) JOLayoutItemProperty property;

#pragma mark - Left
/**
 *  左边的间距大小的约束
 *
 *  @param distance 距离.
 *  @param relation 关系.
 *  @param priority 优先级.
 *  @param view     约束的视图.
 *
 *  @return JOLayoutItem.
 */
+ (instancetype)layoutLeftDistance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutLeftDistance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutLeftDistance:(CGFloat)distance view:(UIView *)view;

/**
 *  与左边视图的间距大小的约束.
 *
 *  @param realteView 左边关联的视图.
 *  @param distance   距离.
 *  @param relation   关系.
 *  @param priority   优先级.
 *  @param view       约束的视图.
 *
 *  @return JOLayoutItem.
 */
+ (instancetype)layoutLeftView:(UIView *)realteView distance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutLeftView:(UIView *)realteView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutLeftView:(UIView *)realteView distance:(CGFloat)distance view:(UIView *)view;

/**
 *  有左视图左对齐的约束.
 *
 *  @param realteView 左边关联的视图.
 *  @param distance   左对齐的距离,为0则代表对齐.
 *  @param relation   关系.
 *  @param priority   优先级.
 *  @param view       约束的视图.
 *
 *  @return JOLayoutItem.
 */
+ (instancetype)layoutLeftXView:(UIView *)realteView distance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutLeftXView:(UIView *)realteView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutLeftXView:(UIView *)realteView distance:(CGFloat)distance view:(UIView *)view;

#pragma mark - Right
/**
 *  右边的间距大小的约束
 *
 *  @param distance 距离.
 *  @param relation 关系.
 *  @param priority 优先级.
 *  @param view     约束的视图.
 *
 *  @return JOLayoutItem.
 */
+ (instancetype)layoutRightDistance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutRightDistance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutRightDistance:(CGFloat)distance view:(UIView *)view;

/**
 *  与右边视图的间距大小的约束.
 *
 *  @param realteView 右边关联的视图.
 *  @param distance   距离.
 *  @param relation   关系.
 *  @param priority   优先级.
 *  @param view       约束的视图.
 *
 *  @return JOLayoutItem.
 */
+ (instancetype)layoutRightView:(UIView *)realteView distance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutRightView:(UIView *)realteView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutRightView:(UIView *)realteView distance:(CGFloat)distance view:(UIView *)view;

/**
 *  有右视图右对齐的约束.
 *
 *  @param realteView 右边关联的视图.
 *  @param distance   右对齐的距离,为0则代表对齐.
 *  @param relation   关系.
 *  @param priority   优先级.
 *  @param view       约束的视图.
 *
 *  @return JOLayoutItem.
 */
+ (instancetype)layoutRightXView:(UIView *)realteView distance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutRightXView:(UIView *)realteView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutRightXView:(UIView *)realteView distance:(CGFloat)distance view:(UIView *)view;

#pragma mark - Top
/**
 *  头部的间距大小的约束
 *
 *  @param distance 距离.
 *  @param relation 关系.
 *  @param priority 优先级.
 *  @param view     约束的视图.
 *
 *  @return JOLayoutItem.
 */
+ (instancetype)layoutTopDistance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutTopDistance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutTopDistance:(CGFloat)distance view:(UIView *)view;

/**
 *  与上边视图的间距大小的约束.
 *
 *  @param realteView 上边关联的视图.
 *  @param distance   距离.
 *  @param relation   关系.
 *  @param priority   优先级.
 *  @param view       约束的视图.
 *
 *  @return JOLayoutItem.
 */
+ (instancetype)layoutTopView:(UIView *)realteView distance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutTopView:(UIView *)realteView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutTopView:(UIView *)realteView distance:(CGFloat)distance view:(UIView *)view;

/**
 *  有上视图上对齐的约束.
 *
 *  @param realteView 上边关联的视图.
 *  @param distance   上左对齐的距离,为0则代表对齐.
 *  @param relation   关系.
 *  @param priority   优先级.
 *  @param view       约束的视图.
 *
 *  @return JOLayoutItem.
 */
+ (instancetype)layoutTopYView:(UIView *)realteView distance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutTopYView:(UIView *)realteView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutTopYView:(UIView *)realteView distance:(CGFloat)distance view:(UIView *)view;

#pragma mark - Bottom
/**
 *  底部的间距大小的约束
 *
 *  @param distance 距离.
 *  @param relation 关系.
 *  @param priority 优先级.
 *  @param view     约束的视图.
 *
 *  @return JOLayoutItem.
 */
+ (instancetype)layoutBottomDistance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutBottomDistance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutBottomDistance:(CGFloat)distance view:(UIView *)view;

/**
 *  与底边视图的间距大小的约束.
 *
 *  @param realteView 底边关联的视图.
 *  @param distance   距离.
 *  @param relation   关系.
 *  @param priority   优先级.
 *  @param view       约束的视图.
 *
 *  @return JOLayoutItem.
 */
+ (instancetype)layoutBottomView:(UIView *)realteView distance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutBottomView:(UIView *)realteView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutBottomView:(UIView *)realteView distance:(CGFloat)distance view:(UIView *)view;

/**
 *  有底视图上对齐的约束.
 *
 *  @param realteView 上边关联的视图.
 *  @param distance   上左对齐的距离,为0则代表对齐.
 *  @param relation   关系.
 *  @param priority   优先级.
 *  @param view       约束的视图.
 *
 *  @return JOLayoutItem.
 */
+ (instancetype)layoutBottomYView:(UIView *)realteView distance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutBottomYView:(UIView *)realteView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutBottomYView:(UIView *)realteView distance:(CGFloat)distance view:(UIView *)view;

#pragma mark - Center
/**
 *  与中心X视图相同的约束.
 *
 *  @param realteView 中心X关联的视图.
 *  @param relation   关系.
 *  @param priority   优先级.
 *  @param view       约束的视图.
 *
 *  @return JOLayoutItem.
 */
+ (instancetype)layoutCenterXView:(UIView *)realteView relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutCenterXView:(UIView *)realteView priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutCenterXView:(UIView *)realteView view:(UIView *)view;

/**
 *  与中心Y视图相同的约束.
 *
 *  @param realteView 中心Y关联的视图.
 *  @param relation   关系.
 *  @param priority   优先级.
 *  @param view       约束的视图.
 *
 *  @return JOLayoutItem.
 */
+ (instancetype)layoutCenterYView:(UIView *)realteView relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutCenterYView:(UIView *)realteView priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutCenterYView:(UIView *)realteView view:(UIView *)view;

#pragma mark - width
/**
 *  宽度的约束.
 *
 *  @param distance 宽度的大小.
 *  @param relation 关系.
 *  @param priority 优先级.
 *  @param view     约束的视图.
 *
 *  @return JOLayoutItem.
 */
+ (instancetype)layoutWidthDistance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutWidthDistance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutWidthDistance:(CGFloat)distance view:(UIView *)view;

/**
 *  宽度的视图相同的约束.
 *
 *  @param realteView 宽度关联的视图.
 *  @param ratio      比例.
 *  @param relation   关系.
 *  @param priority   优先级.
 *  @param view       约束的视图.
 *
 *  @return JOLayoutItem.
 */
+ (instancetype)layoutWidthView:(UIView *)realteView ratio:(CGFloat)ratio relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutWidthView:(UIView *)realteView ratio:(CGFloat)ratio priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutWidthView:(UIView *)realteView ratio:(CGFloat)ratio view:(UIView *)view;

#pragma mark - height
/**
 *  高度的约束.
 *
 *  @param distance 高度的大小.
 *  @param relation 关系.
 *  @param priority 优先级.
 *  @param view     约束的视图.
 *
 *  @return JOLayoutItem.
 */
+ (instancetype)layoutHeightDistance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutHeightDistance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutHeightDistance:(CGFloat)distance view:(UIView *)view;

/**
 *  高度的视图相同的约束.
 *
 *  @param realteView 高度关联的视图.
 *  @param ratio      比例.
 *  @param relation   关系.
 *  @param priority   优先级.
 *  @param view       约束的视图.
 *
 *  @return JOLayoutItem.
 */
+ (instancetype)layoutHeightView:(UIView *)realteView ratio:(CGFloat)ratio relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutHeightView:(UIView *)realteView ratio:(CGFloat)ratio priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutHeightView:(UIView *)realteView ratio:(CGFloat)ratio view:(UIView *)view;

#pragma mark - width/Height

/**
 *  宽高比的约束.
 *
 *  @param ratio    比例.
 *  @param relation 关系.
 *  @param priority 优先级.
 *  @param view     约束的视图.
 *
 *  @return JOLayoutItem.
 */
+ (instancetype)layoutWidthHeightRatio:(CGFloat)ratio relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutWidthHeightRatio:(CGFloat)ratio priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutWidthHeightRatio:(CGFloat)ratio view:(UIView *)view;

/**
 *  高宽比的约束.
 *
 *  @param ratio    比例.
 *  @param relation 关系.
 *  @param priority 优先级.
 *  @param view     约束的视图.
 *
 *  @return JOLayoutItem.
 */
+ (instancetype)layoutHeightWidthRatio:(CGFloat)ratio relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutHeightWidthRatio:(CGFloat)ratio priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutHeightWidthRatio:(CGFloat)ratio view:(UIView *)view;

/**
 *  与宽度相关的高的视图.
 *
 *  @param realteView 高的视图.
 *  @param ratio      比例.
 *  @param relation   关系.
 *  @param priority   优先级.
 *  @param view       约束的视图.
 *
 *  @return JOLayoutItem.
 */
+ (instancetype)layoutWidthHeightView:(UIView *)realteView ratio:(CGFloat)ratio relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutWidthHeightView:(UIView *)realteView ratio:(CGFloat)ratio priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutWidthHeightView:(UIView *)realteView ratio:(CGFloat)ratio view:(UIView *)view;

/**
 *  与高度相关的宽的视图.
 *
 *  @param realteView 宽的视图.
 *  @param ratio      比例.
 *  @param relation   关系.
 *  @param priority   优先级.
 *  @param view       约束的视图.
 *
 *  @return JOLayoutItem.
 */
+ (instancetype)layoutHeightWidthView:(UIView *)realteView ratio:(CGFloat)ratio relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutHeightWidthView:(UIView *)realteView ratio:(CGFloat)ratio priority:(UILayoutPriority)priority view:(UIView *)view;
+ (instancetype)layoutHeightWidthView:(UIView *)realteView ratio:(CGFloat)ratio view:(UIView *)view;

@end
