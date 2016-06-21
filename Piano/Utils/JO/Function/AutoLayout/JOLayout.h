//
//  JOLayout.h
//  Piano
//
//  Created by 刘维 on 16/6/17.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "JOFunctionObject.h"

@interface JOLayout : JOFunctionObject

/**
 *  移除所有的约束
 *
 *  @param view       需要移除的约束的视图.
 *  @param relateView 相关联的视图.
 */
+ (void)removeAllLayoutWithView:(UIView *)view relateView:(UIView*)relateView;
//移除与宽度关联的约束
+ (void)removeWidthLayoutWithView:(UIView *)view relateView:(UIView*)relateView;
//移除与高度关联的约束
+ (void)removeHeightLayoutWithView:(UIView *)view relateView:(UIView*)relateView;
//移除与左部关联的约束
+ (void)removeLeftLayoutWithView:(UIView *)view relateView:(UIView*)relateView;
//移除与右部关联的约束
+ (void)removeRightLayoutWithView:(UIView *)view relateView:(UIView*)relateView;
//移除与头部关联的约束
+ (void)removeTopLayoutWithWithView:(UIView *)view relateView:(UIView*)relateView;
//移除与底部关联的约束
+ (void)removeBottomLayoutWithView:(UIView *)view relateView:(UIView*)relateView;
//移除上下左右关联的约束
+ (void)removeEdgeLayoutWithView:(UIView *)view relateView:(UIView*)relateView;
//移除与大小关联的约束
+ (void)removeSizeLayoutWithView:(UIView *)view relateView:(UIView*)relateView;
//移除中心x关联的约束
+ (void)removeCenterXLayoutWithView:(UIView *)view relateView:(UIView*)relateView;
//移除中心y关联的约束
+ (void)removeCenterYLayoutWithView:(UIView *)view relateView:(UIView*)relateView;
//移除中心关联的约束
+ (void)removeCenterLayoutWithView:(UIView *)view relateView:(UIView*)relateView;


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

/**
 *  relateView与addView是同一个视图.
 */
+ (void)layoutConstraintWithView:(UIView *)view
                       attribute:(NSLayoutAttribute)attribute
                        relateBy:(NSLayoutRelation)relation
                      realteView:(UIView *)relateView
                 relateAttribute:(NSLayoutAttribute)relateAttribute
                           ratio:(CGFloat)ratio
                        distance:(CGFloat)distance
                        priority:(UILayoutPriority)priority;

/**
 *  priority优先级默认为最高的
 */
+ (void)layoutConstraintWithView:(UIView *)view
                       attribute:(NSLayoutAttribute)attribute
                        relateBy:(NSLayoutRelation)relation
                      realteView:(UIView *)relateView
                 relateAttribute:(NSLayoutAttribute)relateAttribute
                         addView:(UIView *)addView
                           ratio:(CGFloat)ratio
                        distance:(CGFloat)distance;

/**
 *  priority优先级默认为最高的,relateView与addView是同一个视图.
 */
+ (void)layoutConstraintWithView:(UIView *)view
                       attribute:(NSLayoutAttribute)attribute
                        relateBy:(NSLayoutRelation)relation
                      realteView:(UIView *)relateView
                 relateAttribute:(NSLayoutAttribute)relateAttribute
                           ratio:(CGFloat)ratio
                        distance:(CGFloat)distance;

/*
#pragma mark - Top
+ (void)layoutTop:(CGFloat)distance relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutTopView:(UIView *)topView relatedBy:(NSLayoutRelation)relation distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutTopView:(UIView *)topView relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutTopYView:(UIView *)topView relatedBy:(NSLayoutRelation)relation distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutTopYView:(UIView *)topView relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;


#pragma mark - Bottom
+ (void)layoutBottom:(CGFloat)distance relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutBottomView:(UIView *)bottomView relatedBy:(NSLayoutRelation)relation distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutBottomView:(UIView *)bottomView relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutBottomYView:(UIView *)bottomView relatedBy:(NSLayoutRelation)relation distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutBottomYView:(UIView *)bottomView relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Left
+ (void)layoutLeft:(CGFloat)distance relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLeftView:(UIView *)leftView relatedBy:(NSLayoutRelation)relation distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLeftView:(UIView *)leftView relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLeftXView:(UIView *)leftView relatedBy:(NSLayoutRelation)relation distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLeftXView:(UIView *)leftView relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Right
+ (void)layoutRight:(CGFloat)distance relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutRightView:(UIView *)rightView distance:(CGFloat)distance relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutRightView:(UIView *)rightView relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutRightXView:(UIView *)rightView distance:(CGFloat)distance relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutRightXView:(UIView *)rightView relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Width
+ (void)layoutWidth:(CGFloat)distance relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutWidthView:(UIView *)widthView ration:(CGFloat)ration relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutWidthView:(UIView *)widthView relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Height
+ (void)layoutHeight:(CGFloat)distance relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutHeightView:(UIView *)heightView ration:(CGFloat)ration relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutHeightView:(UIView *)heightView relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Width Height
+ (void)layoutWidthHeightRation:(CGFloat)ration relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutHeightWidthRation:(CGFloat)ration relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutWidthHeightEqualWithRelatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutWidthToHeightView:(UIView *)heightView ration:(CGFloat)ration relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutHeightToWidthView:(UIView *)widthView ration:(CGFloat)ration relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Edge

+ (void)layoutEdge:(UIEdgeInsets)Edge relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Center
+ (void)layoutCenterX:(UIView *)centerView relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutCenterY:(UIView *)centerView relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutCenter:(UIView *)centerView relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Size
+ (void)layoutSize:(CGSize)size relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark -Same
+ (void)layoutSame:(UIView *)sameView relatedBy:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
*/

@end
