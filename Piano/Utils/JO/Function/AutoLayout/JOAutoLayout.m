//
//  JOAutoLayout.m
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/10/27.
//  Copyright © 2015年 刘维. All rights reserved.
//

#import "JOAutoLayout.h"

@implementation JOAutoLayout

+ (void)removeAllAutoLayoutWithSelfView:(UIView *)selfView superView:(UIView *)superView{
    
    //    [NSLayoutConstraint deactivateConstraints:selfView.constraints];
    
    //    [selfView removeConstraints:selfView.constraints];
    //
    //    [selfView setNeedsUpdateConstraints];
    
    for(NSLayoutConstraint *layoutConstraint in superView.constraints){
        
        //        [view removeConstraint:layoutConstraint];
        
        if(layoutConstraint.firstItem == selfView){
            [superView removeConstraint:layoutConstraint];
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

+ (void)removeAutoLayoutWithHeightSelfView:(UIView *)selfView superView:(UIView *)superView{
    
    [JOAutoLayout removeAutoLayoutWithLayoutAttribute:NSLayoutAttributeHeight selfView:selfView superView:superView];
    
    ////    [selfView removeConstraints:selfView.constraints];
    ////    [selfView setNeedsUpdateConstraints];
    //    for(NSLayoutConstraint *layoutConstraint in superView.constraints){
    //
    //        if(layoutConstraint.firstItem == selfView){
    //
    //            switch (layoutConstraint.firstAttribute) {
    //                case NSLayoutAttributeHeight:
    //                    [superView removeConstraint:layoutConstraint];
    //                    break;
    //                default:
    //                    break;
    //            }
    //        }
    //    }
    //
    //
    
}

+ (void)removeAutoLayoutWithWidthSelfView:(UIView *)selfView superView:(UIView *)superView{
    
    [JOAutoLayout removeAutoLayoutWithLayoutAttribute:NSLayoutAttributeWidth selfView:selfView superView:superView];
}

+ (void)removeAutoLayoutWithLeftSelfView:(UIView *)selfView superView:(UIView *)superView{
    
    [JOAutoLayout removeAutoLayoutWithLayoutAttribute:NSLayoutAttributeLeft selfView:selfView superView:superView];
}

+ (void)removeAutoLayoutWithRightSelfView:(UIView *)selfView superView:(UIView *)superView{
    
    [JOAutoLayout removeAutoLayoutWithLayoutAttribute:NSLayoutAttributeRight selfView:selfView superView:superView];
}

+ (void)removeAutoLayoutWithTopSelfView:(UIView *)selfView superView:(UIView *)superView{
    
    [JOAutoLayout removeAutoLayoutWithLayoutAttribute:NSLayoutAttributeTop selfView:selfView superView:superView];
}

+ (void)removeAutoLayoutWithBottomSelfView:(UIView *)selfView superView:(UIView *)superView{
    
    [JOAutoLayout removeAutoLayoutWithLayoutAttribute:NSLayoutAttributeBottom selfView:selfView superView:superView];
}

+ (void)removeAutoLayoutWithEdgeSelfView:(UIView *)selfView superView:(UIView *)superView{
    
    [JOAutoLayout removeAutoLayoutWithLayoutAttribute:NSLayoutAttributeLeft selfView:selfView superView:superView];
    [JOAutoLayout removeAutoLayoutWithLayoutAttribute:NSLayoutAttributeRight selfView:selfView superView:superView];
    [JOAutoLayout removeAutoLayoutWithLayoutAttribute:NSLayoutAttributeTop selfView:selfView superView:superView];
    [JOAutoLayout removeAutoLayoutWithLayoutAttribute:NSLayoutAttributeBottom selfView:selfView superView:superView];
}

+ (void)removeAutoLayoutWithSizeSelfView:(UIView *)selfView superView:(UIView *)superView{
    
    [JOAutoLayout removeAutoLayoutWithLayoutAttribute:NSLayoutAttributeWidth selfView:selfView superView:superView];
    [JOAutoLayout removeAutoLayoutWithLayoutAttribute:NSLayoutAttributeHeight selfView:selfView superView:superView];
}

+ (void)removeAutoLayoutWithLayoutAttribute:(NSLayoutAttribute )layoutAttribute selfView:(UIView *)selfView superView:(UIView *)superView{
    
    for(NSLayoutConstraint *layoutConstraint in superView.constraints){
        
        if((layoutConstraint.firstItem == selfView) && (layoutConstraint.firstAttribute == layoutAttribute)){
            
            [superView removeConstraint:layoutConstraint];
        }
    }
}

//+ (void)removeAutoLayoutWithHeightSelfView:(UIView *)selfView superView:(UIView *)superView{
//
//    [selfView removeConstraints:selfView.constraints];
//
//    [selfView setNeedsUpdateConstraints];
//
//    for(NSLayoutConstraint *layoutConstraint in superView.constraints){
//
//        if(layoutConstraint.firstItem == selfView){
//
//            switch (layoutConstraint.firstAttribute) {
//                case NSLayoutAttributeHeight:
//                    [superView removeConstraint:layoutConstraint];
//                    break;
//                default:
//                    break;
//            }
//        }
//    }
//}

+ (void)autoLayoutWithSameView:(UIView *)sameView
                      selfView:(UIView *)selfView
                     superView:(UIView *)superView{
    
    [JOAutoLayout autoLayoutWithTopYView:sameView selfView:selfView superView:superView];
    [JOAutoLayout autoLayoutWithBottomYView:sameView selfView:selfView superView:superView];
    [JOAutoLayout autoLayoutWithLeftXView:sameView selfView:selfView superView:superView];
    [JOAutoLayout autoLayoutWithRightXView:sameView selfView:selfView superView:superView];
}

+ (void)autoLayoutWithEdgeInsets:(UIEdgeInsets )edgeInsets
                        selfView:(UIView *)selfView
                       superView:(UIView *)superView{
    
    [JOAutoLayout autoLayoutWithTopSpaceDistance:edgeInsets.top selfView:selfView superView:superView];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:edgeInsets.left selfView:selfView superView:superView];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:edgeInsets.bottom selfView:selfView superView:superView];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:edgeInsets.right selfView:selfView superView:superView];
}

+ (void)autoLayoutCenterWithSize:(CGSize )size
                        selfView:(UIView *)selfView
                       superView:(UIView *)superView{
    
    [JOAutoLayout autoLayoutWithSize:size selfView:selfView superView:superView];
    [JOAutoLayout autoLayoutCenterWithSelfView:selfView superView:superView];
}

+ (void)autoLayoutWithTopSpaceDistance:(CGFloat )topSpaceDistance
                              selfView:(UIView *)selfView
                             superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeTop
                              relatedBy:NSLayoutRelationEqual
                              toItem:superView
                              attribute:NSLayoutAttributeTop
                              multiplier:1
                              constant:topSpaceDistance]];
    
    
}

+ (void)autoLayoutWithBottomSpaceDistance:(CGFloat )bottomSpaceDistance
                                 selfView:(UIView *)selfView
                                superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeBottom
                              relatedBy:NSLayoutRelationEqual
                              toItem:superView
                              attribute:NSLayoutAttributeBottom
                              multiplier:1
                              constant:bottomSpaceDistance]];
}

+ (void)autoLayoutWithLeftSpaceDistance:(CGFloat )leftSpaceDistance
                               selfView:(UIView *)selfView
                              superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeLeft
                              relatedBy:NSLayoutRelationEqual
                              toItem:superView
                              attribute:NSLayoutAttributeLeft
                              multiplier:1
                              constant:leftSpaceDistance]];
}

+ (void)autoLayoutWithRightSpaceDistance:(CGFloat )rightSpaceDistance
                                selfView:(UIView *)selfView
                               superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeRight
                              relatedBy:NSLayoutRelationEqual
                              toItem:superView
                              attribute:NSLayoutAttributeRight
                              multiplier:1
                              constant:rightSpaceDistance]];
}

+ (void)autoLayoutCenterXWithSelfView:(UIView *)selfView superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeCenterX
                              relatedBy:NSLayoutRelationEqual
                              toItem:superView
                              attribute:NSLayoutAttributeCenterX
                              multiplier:1
                              constant:0.]];
}

+ (void)autoLayoutCenterYWithSelfView:(UIView *)selfView superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeCenterY
                              relatedBy:NSLayoutRelationEqual
                              toItem:superView
                              attribute:NSLayoutAttributeCenterY
                              multiplier:1
                              constant:0.]];
}

+ (void)autoLayoutCenterWithSelfView:(UIView *)selfView superView:(UIView *)superView{
    
    [JOAutoLayout autoLayoutCenterXWithSelfView:selfView superView:superView];
    [JOAutoLayout autoLayoutCenterYWithSelfView:selfView superView:superView];
}

+ (void)autoLayoutWithWidth:(CGFloat )width
                   selfView:(UIView *)selfView
                  superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeWidth
                              relatedBy:NSLayoutRelationEqual
                              toItem:nil
                              attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1
                              constant:width]];
}

+ (void)autoLayoutWithHeight:(CGFloat )height
                    selfView:(UIView *)selfView
                   superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeHeight
                              relatedBy:NSLayoutRelationEqual
                              toItem:nil
                              attribute:NSLayoutAttributeNotAnAttribute
                              multiplier:1
                              constant:height]];
}

+ (void)autoLayoutWithSize:(CGSize )size
                  selfView:(UIView *)selfView
                 superView:(UIView *)superView{
    
    [JOAutoLayout autoLayoutWithWidth:size.width selfView:selfView superView:superView];
    [JOAutoLayout autoLayoutWithHeight:size.height selfView:selfView superView:superView];
}

+ (void)autoLayoutWithLeftXView:(UIView *)leftXView
                       selfView:(UIView *)selfView
                      superView:(UIView *)superView{
    
    [JOAutoLayout autoLayoutWithLeftXView:leftXView distance:0. selfView:selfView superView:superView];
}

+ (void)autoLayoutWithRightXView:(UIView *)rightXView
                        selfView:(UIView *)selfView
                       superView:(UIView *)superView{
    
    [JOAutoLayout autoLayoutWithRightXView:rightXView distance:0. selfView:selfView superView:superView];
}

+ (void)autoLayoutWithTopYView:(UIView *)topYView
                      selfView:(UIView *)selfView
                     superView:(UIView *)superView{
    
    [JOAutoLayout autoLayoutWithTopYView:topYView distance:0. selfView:selfView superView:superView];
}

+ (void)autoLayoutWithBottomYView:(UIView *)bottomYView
                         selfView:(UIView *)selfView
                        superView:(UIView *)superView{
    
    [JOAutoLayout autoLayoutWithBottomYView:bottomYView distance:0. selfView:selfView superView:superView];
}

+ (void)autoLayoutWithLeftXView:(UIView *)leftXView
                       distance:(CGFloat)distance
                       selfView:(UIView *)selfView
                      superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeLeft
                              relatedBy:NSLayoutRelationEqual
                              toItem:leftXView
                              attribute:NSLayoutAttributeLeft
                              multiplier:1
                              constant:distance]];
}

+ (void)autoLayoutWithRightXView:(UIView *)rightXView
                        distance:(CGFloat)distance
                        selfView:(UIView *)selfView
                       superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeRight
                              relatedBy:NSLayoutRelationEqual
                              toItem:rightXView
                              attribute:NSLayoutAttributeRight
                              multiplier:1
                              constant:distance]];
}

+ (void)autoLayoutWithTopYView:(UIView *)topYView
                      distance:(CGFloat)distance
                      selfView:(UIView *)selfView
                     superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeTop
                              relatedBy:NSLayoutRelationEqual
                              toItem:topYView
                              attribute:NSLayoutAttributeTop
                              multiplier:1
                              constant:distance]];
}

+ (void)autoLayoutWithBottomYView:(UIView *)bottomYView
                         distance:(CGFloat)distance
                         selfView:(UIView *)selfView
                        superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeBottom
                              relatedBy:NSLayoutRelationEqual
                              toItem:bottomYView
                              attribute:NSLayoutAttributeBottom
                              multiplier:1
                              constant:distance]];
}

+ (void)autoLayoutWithLeftView:(UIView *)leftView
                      distance:(CGFloat )distance
                      selfView:(UIView *)selfView
                     superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeLeft
                              relatedBy:NSLayoutRelationEqual
                              toItem:leftView
                              attribute:NSLayoutAttributeRight
                              multiplier:1
                              constant:distance]];
}

+ (void)autoLayoutWithRightView:(UIView *)rightView
                       distance:(CGFloat )distance
                       selfView:(UIView *)selfView
                      superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeRight
                              relatedBy:NSLayoutRelationEqual
                              toItem:rightView
                              attribute:NSLayoutAttributeLeft
                              multiplier:1
                              constant:distance]];
}

+ (void)autoLayoutWithTopView:(UIView *)topView
                     distance:(CGFloat )distance
                     selfView:(UIView *)selfView
                    superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeTop
                              relatedBy:NSLayoutRelationEqual
                              toItem:topView
                              attribute:NSLayoutAttributeBottom
                              multiplier:1
                              constant:distance]];
}

+ (void)autoLayoutWithBottomView:(UIView *)bottomView
                        distance:(CGFloat )distance
                        selfView:(UIView *)selfView
                       superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeBottom
                              relatedBy:NSLayoutRelationEqual
                              toItem:bottomView
                              attribute:NSLayoutAttributeTop
                              multiplier:1
                              constant:distance]];
}

+ (void)autoLayoutWithCenterXWithView:(UIView *)centerXView
                             selfView:(UIView *)selfView
                            superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeCenterX
                              relatedBy:NSLayoutRelationEqual
                              toItem:centerXView
                              attribute:NSLayoutAttributeCenterX
                              multiplier:1
                              constant:0]];
}

+ (void)autoLayoutWithCenterYWithView:(UIView *)centerYView
                             selfView:(UIView *)selfView
                            superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeCenterY
                              relatedBy:NSLayoutRelationEqual
                              toItem:centerYView
                              attribute:NSLayoutAttributeCenterY
                              multiplier:1
                              constant:0]];
}

+ (void)autoLayoutWithCenterWithView:(UIView *)centerView
                            selfView:(UIView *)selfView
                           superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeCenterX
                              relatedBy:NSLayoutRelationEqual
                              toItem:centerView
                              attribute:NSLayoutAttributeCenterX
                              multiplier:1
                              constant:0]];
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeCenterY
                              relatedBy:NSLayoutRelationEqual
                              toItem:centerView
                              attribute:NSLayoutAttributeCenterY
                              multiplier:1
                              constant:0]];
}

+ (void)autoLayoutWithWidthWithView:(UIView *)widthView
                           selfView:(UIView *)selfView
                          superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeWidth
                              relatedBy:NSLayoutRelationEqual
                              toItem:widthView
                              attribute:NSLayoutAttributeWidth
                              multiplier:1
                              constant:0]];
}

+ (void)autoLayoutWithHeightWithView:(UIView *)heightView
                            selfView:(UIView *)selfView
                           superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeHeight
                              relatedBy:NSLayoutRelationEqual
                              toItem:heightView
                              attribute:NSLayoutAttributeHeight
                              multiplier:1
                              constant:0]];
}

+ (void)autoLayoutWithWidthWithView:(UIView *)widthView
                         ratioValue:(CGFloat )ratio
                           selfView:(UIView *)selfView
                          superView:(UIView *)superView{
    
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeWidth
                              relatedBy:NSLayoutRelationEqual
                              toItem:widthView
                              attribute:NSLayoutAttributeWidth
                              multiplier:ratio
                              constant:0]];
}

+ (void)autoLayoutWithHeightWithView:(UIView *)heightView
                          ratioValue:(CGFloat )ratio
                            selfView:(UIView *)selfView
                           superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeHeight
                              relatedBy:NSLayoutRelationEqual
                              toItem:heightView
                              attribute:NSLayoutAttributeHeight
                              multiplier:ratio
                              constant:0]];
}

+ (void)autoLayoutWithSizeWithView:(UIView *)sizeView
                          selfView:(UIView *)selfView
                         superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeWidth
                              relatedBy:NSLayoutRelationEqual
                              toItem:sizeView
                              attribute:NSLayoutAttributeWidth
                              multiplier:1
                              constant:0]];
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeHeight
                              relatedBy:NSLayoutRelationEqual
                              toItem:sizeView
                              attribute:NSLayoutAttributeHeight
                              multiplier:1
                              constant:0]];
}

+ (void)autoLayoutWithWidthEqualHeightWithselfView:(UIView *)selfView
                                         superView:(UIView *)superView{
    
    [JOAutoLayout autoLayoutWithWidthHeightRatioValue:1. selfView:selfView superView:superView];
}

+ (void)autoLayoutWithWidthHeightRatioValue:(CGFloat )ratio
                                   selfView:(UIView *)selfView
                                  superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeWidth
                              relatedBy:NSLayoutRelationEqual
                              toItem:selfView
                              attribute:NSLayoutAttributeHeight
                              multiplier:ratio
                              constant:0]];
}

+ (void)autoLayoutWithHeightWidthRatioValue:(CGFloat )ratio
                                   selfView:(UIView *)selfView
                                  superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeHeight
                              relatedBy:NSLayoutRelationEqual
                              toItem:selfView
                              attribute:NSLayoutAttributeWidth
                              multiplier:ratio
                              constant:0]];
}

+ (void)autoLayoutWithHeightWithWidthView:(UIView *)widthView
                               ratioValue:(CGFloat )ratio
                                 selfView:(UIView *)selfView
                                superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeHeight
                              relatedBy:NSLayoutRelationEqual
                              toItem:widthView
                              attribute:NSLayoutAttributeWidth
                              multiplier:ratio
                              constant:0]];
}

+ (void)autoLayoutWithWidthWithHeightView:(UIView *)heightView
                               ratioValue:(CGFloat )ratio
                                 selfView:(UIView *)selfView
                                superView:(UIView *)superView{
    
    [superView addConstraint:[NSLayoutConstraint
                              constraintWithItem:selfView
                              attribute:NSLayoutAttributeWidth
                              relatedBy:NSLayoutRelationEqual
                              toItem:heightView
                              attribute:NSLayoutAttributeHeight
                              multiplier:ratio
                              constant:0]];
}

@end
