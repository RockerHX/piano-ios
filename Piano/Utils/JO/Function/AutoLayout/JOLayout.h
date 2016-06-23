//
//  JOLayout.h
//  Piano
//
//  Created by 刘维 on 16/6/17.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "JOFunctionObject.h"
#import "JOLayoutItem.h"

@interface JOLayout : JOFunctionObject

/**
 *  移除所有的约束
 *
 *  @param view       需要移除的约束的视图.
 *  @param relateView 相关联的视图.
 */
+ (void)removeAllLayoutWithView:(UIView *)view;
//移除与宽度关联的约束
+ (void)removeWidthLayoutWithView:(UIView *)view;
//移除与高度关联的约束
+ (void)removeHeightLayoutWithView:(UIView *)view;
//移除与左部关联的约束
+ (void)removeLeftLayoutWithView:(UIView *)view;
//移除与右部关联的约束
+ (void)removeRightLayoutWithView:(UIView *)view;
//移除与头部关联的约束
+ (void)removeTopLayoutWithWithView:(UIView *)view;
//移除与底部关联的约束
+ (void)removeBottomLayoutWithView:(UIView *)view;
//移除上下左右关联的约束
+ (void)removeEdgeLayoutWithView:(UIView *)view;
//移除与大小关联的约束
+ (void)removeSizeLayoutWithView:(UIView *)view;
//移除中心x关联的约束
+ (void)removeCenterXLayoutWithView:(UIView *)view;
//移除中心y关联的约束
+ (void)removeCenterYLayoutWithView:(UIView *)view;
//移除中心关联的约束
+ (void)removeCenterLayoutWithView:(UIView *)view;

+ (void)layoutWithItem:(JOLayoutItem *)item;

/**
 *  添加相关的约束.
 *
 *  @param view            需要约束的视图.
 *  @param attribute       约束的属性.
 *  @param relation        关系.
 *  @param relateView      约束相关联的视图.
 *  @param relateAttribute 约束的属性.
 *  @param addView         需要添加约束的视图.
 *  @param ratio           比率.
 *  @param distance        距离.
 *  @param priority        优先级.
 */
+ (void)layoutConstraintWithView:(UIView *)view
                       attribute:(NSLayoutAttribute)attribute
                        relateBy:(NSLayoutRelation)relation
                      realteView:(UIView *)relateView
                 relateAttribute:(NSLayoutAttribute)relateAttribute
                         addView:(UIView *)addView
                           ratio:(CGFloat)ratio
                        distance:(CGFloat)distance
                        priority:(UILayoutPriority)priority;

@end
