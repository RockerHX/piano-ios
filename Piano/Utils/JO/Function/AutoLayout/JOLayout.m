//
//  JOLayout.m
//  Piano
//
//  Created by 刘维 on 16/6/17.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "JOLayout.h"

@implementation JOLayout

+ (void)removeAllLayoutWithView:(UIView *)view relateView:(UIView*)relateView{

    //    [NSLayoutConstraint deactivateConstraints:selfView.constraints];
    
    //    [selfView removeConstraints:selfView.constraints];
    //
    //    [selfView setNeedsUpdateConstraints];
    
    for(NSLayoutConstraint *layoutConstraint in relateView.constraints){
        
        //        [view removeConstraint:layoutConstraint];
        
        if(layoutConstraint.firstItem == view){
            [relateView removeConstraint:layoutConstraint];
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

+ (void)removeWidthLayoutWithView:(UIView *)view relateView:(UIView*)relateView{

    [JOLayout removeLayoutWithLayoutAttribute:NSLayoutAttributeWidth view:view relateView:relateView];
}

+ (void)removeHeightLayoutWithView:(UIView *)view relateView:(UIView*)relateView{

    [JOLayout removeLayoutWithLayoutAttribute:NSLayoutAttributeHeight view:view relateView:relateView];
}

+ (void)removeLeftLayoutWithView:(UIView *)view relateView:(UIView*)relateView{

    [JOLayout removeLayoutWithLayoutAttribute:NSLayoutAttributeLeft view:view relateView:relateView];
}

+ (void)removeRightLayoutWithView:(UIView *)view relateView:(UIView*)relateView{

    [JOLayout removeLayoutWithLayoutAttribute:NSLayoutAttributeRight view:view relateView:relateView];
}

+ (void)removeTopLayoutWithWithView:(UIView *)view relateView:(UIView*)relateView{

    [JOLayout removeLayoutWithLayoutAttribute:NSLayoutAttributeTop view:view relateView:relateView];
}

+ (void)removeBottomLayoutWithView:(UIView *)view relateView:(UIView*)relateView{

    [JOLayout removeLayoutWithLayoutAttribute:NSLayoutAttributeBottom view:view relateView:relateView];
}

+ (void)removeEdgeLayoutWithView:(UIView *)view relateView:(UIView*)relateView{

    [JOLayout removeLeftLayoutWithView:view relateView:relateView];
    [JOLayout removeRightLayoutWithView:view relateView:relateView];
    [JOLayout removeTopLayoutWithWithView:view relateView:relateView];
    [JOLayout removeBottomLayoutWithView:view relateView:relateView];
}

+ (void)removeSizeLayoutWithView:(UIView *)view relateView:(UIView*)relateView{

    [JOLayout removeWidthLayoutWithView:view relateView:relateView];
    [JOLayout removeHeightLayoutWithView:view relateView:relateView];
}

+ (void)removeCenterXLayoutWithView:(UIView *)view relateView:(UIView*)relateView{

    [JOLayout removeLayoutWithLayoutAttribute:NSLayoutAttributeCenterX view:view relateView:relateView];
}

+ (void)removeCenterYLayoutWithView:(UIView *)view relateView:(UIView*)relateView{

    [JOLayout removeLayoutWithLayoutAttribute:NSLayoutAttributeCenterY view:view relateView:relateView];
}

+ (void)removeCenterLayoutWithView:(UIView *)view relateView:(UIView*)relateView{

    [JOLayout removeCenterXLayoutWithView:view relateView:relateView];
    [JOLayout removeCenterYLayoutWithView:view relateView:relateView];
}

+ (void)removeLayoutWithLayoutAttribute:(NSLayoutAttribute )layoutAttribute view:(UIView *)view relateView:(UIView*)relateView{
    
    for(NSLayoutConstraint *layoutConstraint in relateView.constraints){
        
        if((layoutConstraint.firstItem == view) && (layoutConstraint.firstAttribute == layoutAttribute)){
            
            [relateView removeConstraint:layoutConstraint];
        }
    }
}

#pragma mark - Private layout

+ (void)layoutConstraintWithView:(UIView *)view
                       attribute:(NSLayoutAttribute)attribute
                        relateBy:(NSLayoutRelation)relation
                      realteView:(UIView *)relateView
                 relateAttribute:(NSLayoutAttribute)relateAttribute
                         addView:(UIView *)addView
                           ratio:(CGFloat)ratio
                        distance:(CGFloat)distance{

    [JOLayout layoutConstraintWithView:view
                             attribute:attribute
                              relateBy:relation
                            realteView:relateView
                       relateAttribute:relateAttribute
                               addView:relateView
                                 ratio:ratio
                              distance:distance
                              priority:UILayoutPriorityRequired];
}

+ (void)layoutConstraintWithView:(UIView *)view
                       attribute:(NSLayoutAttribute)attribute
                        relateBy:(NSLayoutRelation)relation
                      realteView:(UIView *)relateView
                 relateAttribute:(NSLayoutAttribute)relateAttribute
                           ratio:(CGFloat)ratio
                        distance:(CGFloat)distance{

    [JOLayout layoutConstraintWithView:view
                             attribute:attribute
                              relateBy:relation
                            realteView:relateView
                       relateAttribute:relateAttribute
                               addView:relateView
                                 ratio:ratio
                              distance:distance];
    
}

+ (void)layoutConstraintWithView:(UIView *)view
                       attribute:(NSLayoutAttribute)attribute
                        relateBy:(NSLayoutRelation)relation
                      realteView:(UIView *)relateView
                 relateAttribute:(NSLayoutAttribute)relateAttribute
                           ratio:(CGFloat)ratio
                        distance:(CGFloat)distance
                        priority:(UILayoutPriority)priority{

    [JOLayout layoutConstraintWithView:view
                             attribute:attribute
                              relateBy:relation
                            realteView:relateView
                       relateAttribute:relateAttribute
                               addView:relateView
                                 ratio:ratio
                              distance:distance
                              priority:priority];
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
    
    [JOLayout removeLayoutWithLayoutAttribute:attribute view:view relateView:relateView];
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

+ (void)layoutWithContent:(NSString *)content view:(UIView *)view referView:(UIView *)referView relateView:(UIView *)relateView{

    
}

//+ (NSDictionary *)

@end
