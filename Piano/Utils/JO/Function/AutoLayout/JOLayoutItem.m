//
//  JOLayoutItem.m
//  Piano
//
//  Created by 刘维 on 16/6/21.
//  Copyright © 2016年 Mia Music. All rights reserved.
//


#import "JOLayoutItem.h"

@implementation JOLayoutItem

+ (instancetype)layoutItemWithView:(UIView *)view
                     viewAttribute:(NSLayoutAttribute)viewAttribute
                        realteView:(UIView *)realteView
               realteViewAttribute:(NSLayoutAttribute)realteViewAttribute
                          distance:(CGFloat)distance ratio:(CGFloat)ratio
                          relation:(NSLayoutRelation)relation
                          priority:(UILayoutPriority)priority
                          property:(JOLayoutItemProperty)property{
    
    JOLayoutItem *item = [JOLayoutItem new];
    item.view = view;
    item.viewAttribute = viewAttribute;
    item.realteView = realteView;
    item.realteViewAttribute = realteViewAttribute;
    item.distance = distance;
    item.ratio = ratio;
    item.relation = relation;
    item.priority = priority;
    item.property = property;
    return item;
}

#pragma mark - Left

+ (instancetype)layoutLeftDistance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutLeftDistance:distance relation:NSLayoutRelationEqual priority:priority view:view];
}

+ (instancetype)layoutLeftDistance:(CGFloat)distance view:(UIView *)view{
    
    return [JOLayoutItem layoutLeftDistance:distance relation:NSLayoutRelationEqual priority:UILayoutPriorityRequired view:view];
}

+ (instancetype)layoutLeftDistance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutItemWithView:view
                              viewAttribute:NSLayoutAttributeLeft
                                 realteView:view.superview
                        realteViewAttribute:NSLayoutAttributeLeft
                                   distance:distance
                                      ratio:1.
                                   relation:relation
                                   priority:priority
                                   property:JOLayoutItemPropertyLeft];
}

#pragma mark -

+ (instancetype)layoutLeftView:(UIView *)realteView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutLeftView:realteView distance:distance relation:NSLayoutRelationEqual priority:priority view:view];
}

+ (instancetype)layoutLeftView:(UIView *)realteView distance:(CGFloat)distance view:(UIView *)view{
    
    return [JOLayoutItem layoutLeftView:realteView distance:distance relation:NSLayoutRelationEqual priority:UILayoutPriorityRequired view:view];;
}

+ (instancetype)layoutLeftView:(UIView *)realteView distance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutItemWithView:view
                              viewAttribute:NSLayoutAttributeLeft
                                 realteView:realteView
                        realteViewAttribute:NSLayoutAttributeRight
                                   distance:distance
                                      ratio:1.
                                   relation:relation
                                   priority:priority
                                   property:JOLayoutItemPropertyLeft];
}

#pragma mark -

+ (instancetype)layoutLeftXView:(UIView *)realteView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutLeftXView:realteView distance:distance relation:NSLayoutRelationEqual priority:priority view:view];
}

+ (instancetype)layoutLeftXView:(UIView *)realteView distance:(CGFloat)distance view:(UIView *)view{
    
    return [JOLayoutItem layoutLeftXView:realteView distance:distance relation:NSLayoutRelationEqual priority:UILayoutPriorityRequired view:view];
}

+ (instancetype)layoutLeftXView:(UIView *)realteView distance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutItemWithView:view
                              viewAttribute:NSLayoutAttributeLeft
                                 realteView:realteView
                        realteViewAttribute:NSLayoutAttributeLeft
                                   distance:distance
                                      ratio:1.
                                   relation:relation
                                   priority:priority
                                   property:JOLayoutItemPropertyLeft];
    
}

#pragma mark - Right
+ (instancetype)layoutRightDistance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutRightDistance:distance relation:NSLayoutRelationEqual priority:priority view:view];
}

+ (instancetype)layoutRightDistance:(CGFloat)distance view:(UIView *)view{
    
    return [JOLayoutItem layoutRightDistance:distance relation:NSLayoutRelationEqual priority:UILayoutPriorityRequired view:view];
}

+ (instancetype)layoutRightDistance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutItemWithView:view
                              viewAttribute:NSLayoutAttributeRight
                                 realteView:view.superview
                        realteViewAttribute:NSLayoutAttributeRight
                                   distance:distance
                                      ratio:1.
                                   relation:relation
                                   priority:priority
                                   property:JOLayoutItemPropertyRight];
    
}

#pragma mark -

+ (instancetype)layoutRightView:(UIView *)realteView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutRightView:realteView distance:distance relation:NSLayoutRelationEqual priority:priority view:view];
}

+ (instancetype)layoutRightView:(UIView *)realteView distance:(CGFloat)distance view:(UIView *)view{
    
    return [JOLayoutItem layoutRightView:realteView distance:distance relation:NSLayoutRelationEqual priority:UILayoutPriorityRequired view:view];;
}

+ (instancetype)layoutRightView:(UIView *)realteView distance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutItemWithView:view
                              viewAttribute:NSLayoutAttributeRight
                                 realteView:realteView
                        realteViewAttribute:NSLayoutAttributeLeft
                                   distance:distance
                                      ratio:1.
                                   relation:relation
                                   priority:priority
                                   property:JOLayoutItemPropertyRight];
}

#pragma mark -

+ (instancetype)layoutRightXView:(UIView *)realteView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutRightXView:realteView distance:distance relation:NSLayoutRelationEqual priority:priority view:view];
}

+ (instancetype)layoutRightXView:(UIView *)realteView distance:(CGFloat)distance view:(UIView *)view{
    
    return [JOLayoutItem layoutRightXView:realteView distance:distance relation:NSLayoutRelationEqual priority:UILayoutPriorityRequired view:view];;
}

+ (instancetype)layoutRightXView:(UIView *)realteView distance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutItemWithView:view
                              viewAttribute:NSLayoutAttributeRight
                                 realteView:realteView
                        realteViewAttribute:NSLayoutAttributeRight
                                   distance:distance
                                      ratio:1.
                                   relation:relation
                                   priority:priority
                                   property:JOLayoutItemPropertyRight];
}

#pragma mark - Top


+ (instancetype)layoutTopDistance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutTopDistance:distance relation:NSLayoutRelationEqual priority:priority view:view];
}

+ (instancetype)layoutTopDistance:(CGFloat)distance view:(UIView *)view{
    
    return [JOLayoutItem layoutTopDistance:distance relation:NSLayoutRelationEqual priority:UILayoutPriorityRequired view:view];
}

+ (instancetype)layoutTopDistance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutItemWithView:view
                              viewAttribute:NSLayoutAttributeTop
                                 realteView:view.superview
                        realteViewAttribute:NSLayoutAttributeTop
                                   distance:distance
                                      ratio:1.
                                   relation:relation
                                   priority:priority
                                   property:JOLayoutItemPropertyTop];
}

#pragma mark -

+ (instancetype)layoutTopView:(UIView *)realteView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutTopView:realteView distance:distance relation:NSLayoutRelationEqual priority:priority view:view];
}

+ (instancetype)layoutTopView:(UIView *)realteView distance:(CGFloat)distance view:(UIView *)view{
    
    return [JOLayoutItem layoutTopView:realteView distance:distance relation:NSLayoutRelationEqual priority:UILayoutPriorityRequired view:view];
}

+ (instancetype)layoutTopView:(UIView *)realteView distance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutItemWithView:view
                              viewAttribute:NSLayoutAttributeTop
                                 realteView:realteView
                        realteViewAttribute:NSLayoutAttributeBottom
                                   distance:distance
                                      ratio:1.
                                   relation:relation
                                   priority:priority
                                   property:JOLayoutItemPropertyTop];
    
}

#pragma mark -

+ (instancetype)layoutTopYView:(UIView *)realteView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutTopYView:realteView distance:distance relation:NSLayoutRelationEqual priority:priority view:view];
}

+ (instancetype)layoutTopYView:(UIView *)realteView distance:(CGFloat)distance view:(UIView *)view{
    
    return [JOLayoutItem layoutTopYView:realteView distance:distance relation:NSLayoutRelationEqual priority:UILayoutPriorityRequired view:view];
}

+ (instancetype)layoutTopYView:(UIView *)realteView distance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutItemWithView:view
                              viewAttribute:NSLayoutAttributeTop
                                 realteView:realteView
                        realteViewAttribute:NSLayoutAttributeTop
                                   distance:distance
                                      ratio:1.
                                   relation:relation
                                   priority:priority
                                   property:JOLayoutItemPropertyTop];
}

#pragma mark - Bottom

+ (instancetype)layoutBottomDistance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutBottomDistance:distance relation:NSLayoutRelationEqual priority:priority view:view];
}

+ (instancetype)layoutBottomDistance:(CGFloat)distance view:(UIView *)view{
    
    return [JOLayoutItem layoutBottomDistance:distance relation:NSLayoutRelationEqual priority:UILayoutPriorityRequired view:view];
}

+ (instancetype)layoutBottomDistance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutItemWithView:view
                              viewAttribute:NSLayoutAttributeBottom
                                 realteView:view.superview
                        realteViewAttribute:NSLayoutAttributeBottom
                                   distance:distance
                                      ratio:1.
                                   relation:relation
                                   priority:priority
                                   property:JOLayoutItemPropertyBottom];
}

#pragma mark -

+ (instancetype)layoutBottomView:(UIView *)realteView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutBottomView:realteView distance:distance relation:NSLayoutRelationEqual priority:priority view:view];
}

+ (instancetype)layoutBottomView:(UIView *)realteView distance:(CGFloat)distance view:(UIView *)view{
    
    return [JOLayoutItem layoutBottomView:realteView distance:distance relation:NSLayoutRelationEqual priority:UILayoutPriorityRequired view:view];
}

+ (instancetype)layoutBottomView:(UIView *)realteView distance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutItemWithView:view
                              viewAttribute:NSLayoutAttributeBottom
                                 realteView:realteView
                        realteViewAttribute:NSLayoutAttributeTop
                                   distance:distance
                                      ratio:1.
                                   relation:relation
                                   priority:priority
                                   property:JOLayoutItemPropertyBottom];
}

#pragma mark -

+ (instancetype)layoutBottomYView:(UIView *)realteView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutBottomYView:realteView distance:distance relation:NSLayoutRelationEqual priority:priority view:view];
}

+ (instancetype)layoutBottomYView:(UIView *)realteView distance:(CGFloat)distance view:(UIView *)view{
    
    return [JOLayoutItem layoutBottomYView:realteView distance:distance relation:NSLayoutRelationEqual priority:UILayoutPriorityRequired view:view];
}

+ (instancetype)layoutBottomYView:(UIView *)realteView distance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutItemWithView:view
                              viewAttribute:NSLayoutAttributeBottom
                                 realteView:realteView
                        realteViewAttribute:NSLayoutAttributeBottom
                                   distance:distance
                                      ratio:1.
                                   relation:relation
                                   priority:priority
                                   property:JOLayoutItemPropertyBottom];
}

#pragma mark - Center

+ (instancetype)layoutCenterXView:(UIView *)realteView priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutCenterXView:realteView relation:NSLayoutRelationEqual priority:priority view:view];
}

+ (instancetype)layoutCenterXView:(UIView *)realteView view:(UIView *)view{
    
    return [JOLayoutItem layoutCenterXView:realteView relation:NSLayoutRelationEqual priority:UILayoutPriorityRequired view:view];
}

+ (instancetype)layoutCenterXView:(UIView *)realteView relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutItemWithView:view
                              viewAttribute:NSLayoutAttributeCenterX
                                 realteView:realteView
                        realteViewAttribute:NSLayoutAttributeCenterX
                                   distance:0.
                                      ratio:1.
                                   relation:relation
                                   priority:priority
                                   property:JOLayoutItemPropertyCenterX];
}

#pragma mark -

+ (instancetype)layoutCenterYView:(UIView *)realteView priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutCenterYView:realteView relation:NSLayoutRelationEqual priority:priority view:view];
}

+ (instancetype)layoutCenterYView:(UIView *)realteView view:(UIView *)view{
    
    return [JOLayoutItem layoutCenterYView:realteView relation:NSLayoutRelationEqual priority:UILayoutPriorityRequired view:view];
}

+ (instancetype)layoutCenterYView:(UIView *)realteView relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutItemWithView:view
                              viewAttribute:NSLayoutAttributeCenterY
                                 realteView:realteView
                        realteViewAttribute:NSLayoutAttributeCenterY
                                   distance:0.
                                      ratio:1.
                                   relation:relation
                                   priority:priority
                                   property:JOLayoutItemPropertyCenterY];
}

#pragma mark - width

+ (instancetype)layoutWidthDistance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutWidthDistance:distance relation:NSLayoutRelationEqual priority:priority view:view];
}

+ (instancetype)layoutWidthDistance:(CGFloat)distance view:(UIView *)view{
    
    return [JOLayoutItem layoutWidthDistance:distance relation:NSLayoutRelationEqual priority:UILayoutPriorityRequired view:view];
}

+ (instancetype)layoutWidthDistance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutItemWithView:view
                              viewAttribute:NSLayoutAttributeWidth
                                 realteView:nil
                        realteViewAttribute:NSLayoutAttributeNotAnAttribute
                                   distance:distance
                                      ratio:1.
                                   relation:relation
                                   priority:priority
                                   property:JOLayoutItemPropertyWidth];
}

#pragma mark -

+ (instancetype)layoutWidthView:(UIView *)realteView ratio:(CGFloat)ratio priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutWidthView:realteView ratio:ratio relation:NSLayoutRelationEqual priority:priority view:view];
}

+ (instancetype)layoutWidthView:(UIView *)realteView ratio:(CGFloat)ratio view:(UIView *)view{
    
    return [JOLayoutItem layoutWidthView:realteView ratio:ratio relation:NSLayoutRelationEqual priority:UILayoutPriorityRequired view:view];
}

+ (instancetype)layoutWidthView:(UIView *)realteView ratio:(CGFloat)ratio relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutItemWithView:view
                              viewAttribute:NSLayoutAttributeWidth
                                 realteView:realteView
                        realteViewAttribute:NSLayoutAttributeWidth
                                   distance:0.
                                      ratio:ratio
                                   relation:relation
                                   priority:priority
                                   property:JOLayoutItemPropertyWidth];
}

#pragma mark - height

+ (instancetype)layoutHeightDistance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutHeightDistance:distance relation:NSLayoutRelationEqual priority:priority view:view];
}

+ (instancetype)layoutHeightDistance:(CGFloat)distance view:(UIView *)view{
    
    return [JOLayoutItem layoutHeightDistance:distance relation:NSLayoutRelationEqual priority:UILayoutPriorityRequired view:view];
}

+ (instancetype)layoutHeightDistance:(CGFloat)distance relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutItemWithView:view
                              viewAttribute:NSLayoutAttributeHeight
                                 realteView:nil
                        realteViewAttribute:NSLayoutAttributeNotAnAttribute
                                   distance:distance
                                      ratio:1.
                                   relation:relation
                                   priority:priority
                                   property:JOLayoutItemPropertyHeight];
}

#pragma mark -

+ (instancetype)layoutHeightView:(UIView *)realteView ratio:(CGFloat)ratio priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutHeightView:realteView ratio:ratio relation:NSLayoutRelationEqual priority:priority view:view];
}

+ (instancetype)layoutHeightView:(UIView *)realteView ratio:(CGFloat)ratio view:(UIView *)view{
    
    return [JOLayoutItem layoutHeightView:realteView ratio:ratio relation:NSLayoutRelationEqual priority:UILayoutPriorityRequired view:view];
}

+ (instancetype)layoutHeightView:(UIView *)realteView ratio:(CGFloat)ratio relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutItemWithView:view
                              viewAttribute:NSLayoutAttributeHeight
                                 realteView:realteView
                        realteViewAttribute:NSLayoutAttributeHeight
                                   distance:0.
                                      ratio:ratio
                                   relation:relation
                                   priority:priority
                                   property:JOLayoutItemPropertyHeight];
}

#pragma mark - width/Height

+ (instancetype)layoutWidthHeightRatio:(CGFloat)ratio priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutWidthHeightRatio:ratio relation:NSLayoutRelationEqual priority:priority view:view];
}

+ (instancetype)layoutWidthHeightRatio:(CGFloat)ratio view:(UIView *)view{
    
    return [JOLayoutItem layoutWidthHeightRatio:ratio relation:NSLayoutRelationEqual priority:UILayoutPriorityRequired view:view];
}

+ (instancetype)layoutWidthHeightRatio:(CGFloat)ratio relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutItemWithView:view
                              viewAttribute:NSLayoutAttributeWidth
                                 realteView:view
                        realteViewAttribute:NSLayoutAttributeHeight
                                   distance:0.
                                      ratio:ratio
                                   relation:relation
                                   priority:priority
                                   property:JOLayoutItemPropertyWidth];
}

#pragma mark -

+ (instancetype)layoutHeightWidthRatio:(CGFloat)ratio priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutWidthHeightRatio:ratio relation:NSLayoutRelationEqual priority:priority view:view];
}

+ (instancetype)layoutHeightWidthRatio:(CGFloat)ratio view:(UIView *)view{
    
    return [JOLayoutItem layoutWidthHeightRatio:ratio relation:NSLayoutRelationEqual priority:UILayoutPriorityRequired view:view];
}

+ (instancetype)layoutHeightWidthRatio:(CGFloat)ratio relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutItemWithView:view
                              viewAttribute:NSLayoutAttributeHeight
                                 realteView:view
                        realteViewAttribute:NSLayoutAttributeWidth
                                   distance:0.
                                      ratio:ratio
                                   relation:relation
                                   priority:priority
                                   property:JOLayoutItemPropertyWidth];
}

#pragma mark -

+ (instancetype)layoutWidthHeightView:(UIView *)realteView ratio:(CGFloat)ratio priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutWidthHeightView:realteView ratio:ratio relation:NSLayoutRelationEqual priority:priority view:view];
}

+ (instancetype)layoutWidthHeightView:(UIView *)realteView ratio:(CGFloat)ratio view:(UIView *)view{
    
    return [JOLayoutItem layoutWidthHeightView:realteView ratio:ratio relation:NSLayoutRelationEqual priority:UILayoutPriorityRequired view:view];
}

+ (instancetype)layoutWidthHeightView:(UIView *)realteView ratio:(CGFloat)ratio relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutItemWithView:view
                              viewAttribute:NSLayoutAttributeWidth
                                 realteView:realteView
                        realteViewAttribute:NSLayoutAttributeHeight
                                   distance:0.
                                      ratio:ratio
                                   relation:relation
                                   priority:priority
                                   property:JOLayoutItemPropertyWidth];
}

#pragma mark -

+ (instancetype)layoutHeightWidthView:(UIView *)realteView ratio:(CGFloat)ratio relation:(NSLayoutRelation)relation priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutItemWithView:view
                              viewAttribute:NSLayoutAttributeHeight
                                 realteView:realteView
                        realteViewAttribute:NSLayoutAttributeWidth
                                   distance:0.
                                      ratio:ratio
                                   relation:relation
                                   priority:priority
                                   property:JOLayoutItemPropertyHeight];
}

+ (instancetype)layoutHeightWidthView:(UIView *)realteView ratio:(CGFloat)ratio priority:(UILayoutPriority)priority view:(UIView *)view{
    
    return [JOLayoutItem layoutHeightWidthView:realteView ratio:ratio relation:NSLayoutRelationEqual priority:priority view:view];
}

+ (instancetype)layoutHeightWidthView:(UIView *)realteView ratio:(CGFloat)ratio view:(UIView *)view{
    
    return [JOLayoutItem layoutHeightWidthView:realteView ratio:ratio relation:NSLayoutRelationEqual priority:UILayoutPriorityRequired view:view];
}

@end
