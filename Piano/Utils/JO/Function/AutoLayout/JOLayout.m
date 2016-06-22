//
//  JOLayout.m
//  Piano
//
//  Created by 刘维 on 16/6/17.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "JOLayout.h"

@implementation JOLayout

+ (void)removeAllLayoutWithView:(UIView *)view{

    //    [NSLayoutConstraint deactivateConstraints:selfView.constraints];
    
    //    [selfView removeConstraints:selfView.constraints];
    //
    //    [selfView setNeedsUpdateConstraints];
    
    for(NSLayoutConstraint *layoutConstraint in view.superview.constraints){
        
        //        [view removeConstraint:layoutConstraint];
        
        if(layoutConstraint.firstItem == view){
            [view.superview removeConstraint:layoutConstraint];
        }
        
        //        switch (layoutConstraint.firstAttribute) {
        //            case NSLayoutAttributeLeft:
        //                [view removeConstraint:layoutConstraint];
        //            case NSLayoutAttributeRight:
        //                [view removeConstraint:layoutConstraint];
        //                break;
        //            case NSLayoutAttributeTop:
        //                [view removeConstraint:layoutConstraint];
        //                break;
        //            case NSLayoutAttributeBottom:
        //                [view removeConstraint:layoutConstraint];
        //                break;
        //            default:
        //                break;
        //        }
    }
}

+ (void)removeWidthLayoutWithView:(UIView *)view{

    [JOLayout removeLayoutWithLayoutAttribute:NSLayoutAttributeWidth view:view];
}

+ (void)removeHeightLayoutWithView:(UIView *)view{

    [JOLayout removeLayoutWithLayoutAttribute:NSLayoutAttributeHeight view:view];
}

+ (void)removeLeftLayoutWithView:(UIView *)view{

    [JOLayout removeLayoutWithLayoutAttribute:NSLayoutAttributeLeft view:view];
}

+ (void)removeRightLayoutWithView:(UIView *)view{

    [JOLayout removeLayoutWithLayoutAttribute:NSLayoutAttributeRight view:view];
}

+ (void)removeTopLayoutWithWithView:(UIView *)view{

    [JOLayout removeLayoutWithLayoutAttribute:NSLayoutAttributeTop view:view];
}

+ (void)removeBottomLayoutWithView:(UIView *)view{

    [JOLayout removeLayoutWithLayoutAttribute:NSLayoutAttributeBottom view:view];
}

+ (void)removeEdgeLayoutWithView:(UIView *)view{

    [JOLayout removeLeftLayoutWithView:view];
    [JOLayout removeRightLayoutWithView:view];
    [JOLayout removeTopLayoutWithWithView:view];
    [JOLayout removeBottomLayoutWithView:view];
}

+ (void)removeSizeLayoutWithView:(UIView *)view{

    [JOLayout removeWidthLayoutWithView:view];
    [JOLayout removeHeightLayoutWithView:view];
}

+ (void)removeCenterXLayoutWithView:(UIView *)view{

    [JOLayout removeLayoutWithLayoutAttribute:NSLayoutAttributeCenterX view:view];
}

+ (void)removeCenterYLayoutWithView:(UIView *)view{

    [JOLayout removeLayoutWithLayoutAttribute:NSLayoutAttributeCenterY view:view];
}

+ (void)removeCenterLayoutWithView:(UIView *)view{

    [JOLayout removeCenterXLayoutWithView:view];
    [JOLayout removeCenterYLayoutWithView:view];
}

+ (void)removeLayoutWithLayoutAttribute:(NSLayoutAttribute )layoutAttribute view:(UIView *)view{
    
    for(NSLayoutConstraint *layoutConstraint in view.superview.constraints){
        
        if((layoutConstraint.firstItem == view) && (layoutConstraint.firstAttribute == layoutAttribute)){
            
            [view.superview removeConstraint:layoutConstraint];
        }
    }
}

#pragma mark - Private layout

+ (void)layoutWithItem:(JOLayoutItem *)item{

    [JOLayout layoutConstraintWithView:item.view
                             attribute:item.viewAttribute
                              relateBy:item.relation
                            realteView:item.realteView
                       relateAttribute:item.realteViewAttribute
                               addView:item.view.superview
                                 ratio:item.ratio
                              distance:item.distance
                              priority:item.priority];
}

+ (void)layoutConstraintWithView:(UIView *)view
                       attribute:(NSLayoutAttribute)attribute
                        relateBy:(NSLayoutRelation)relation
                      realteView:(UIView *)relateView
                 relateAttribute:(NSLayoutAttribute)relateAttribute
                         addView:(UIView *)addView
                           ratio:(CGFloat)ratio
                        distance:(CGFloat)distance
                        priority:(UILayoutPriority)priority{
    
    [JOLayout removeLayoutWithLayoutAttribute:attribute view:view];
    NSLayoutConstraint *layoutConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                       attribute:attribute
                                                                       relatedBy:relation
                                                                          toItem:relateView
                                                                       attribute:relateAttribute
                                                                      multiplier:ratio
                                                                        constant:distance];
    [layoutConstraint setPriority:priority];
    [addView addConstraint:layoutConstraint];
    
}

@end
