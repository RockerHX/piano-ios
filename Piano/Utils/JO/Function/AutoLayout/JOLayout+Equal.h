//
//  JOLayout+Equal.h
//  Piano
//
//  Created by 刘维 on 16/6/17.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "JOLayout.h"

@interface JOLayout(Equal)

#pragma mark - Top
+ (void)layoutEqualTop:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualTopView:(UIView *)topView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualTopView:(UIView *)topView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualTopYView:(UIView *)topView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualTopYView:(UIView *)topView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutEqualTop:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualTopView:(UIView *)topView view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualTopView:(UIView *)topView distance:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualTopYView:(UIView *)topView view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualTopYView:(UIView *)topView distance:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Bottom
+ (void)layoutEqualBottom:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualBottomView:(UIView *)bottomView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualBottomView:(UIView *)bottomView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualBottomYView:(UIView *)bottomView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualBottomYView:(UIView *)bottomView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutEqualBottom:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualBottomView:(UIView *)bottomView distance:(CGFloat)distance  view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualBottomView:(UIView *)bottomView view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualBottomYView:(UIView *)bottomView distance:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualBottomYView:(UIView *)bottomView view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Left
+ (void)layoutEqualLeft:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualLeftView:(UIView *)leftView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualLeftView:(UIView *)leftView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualLeftXView:(UIView *)leftView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualLeftXView:(UIView *)leftView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutEqualLeft:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualLeftView:(UIView *)leftView distance:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualLeftView:(UIView *)leftView view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualLeftXView:(UIView *)leftView distance:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualLeftXView:(UIView *)leftView view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Right
+ (void)layoutEqualRight:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualRightView:(UIView *)rightView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualRightView:(UIView *)rightView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualRightXView:(UIView *)rightView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualRightXView:(UIView *)rightView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutEqualRight:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualRightView:(UIView *)rightView distance:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualRightView:(UIView *)rightView view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualRightXView:(UIView *)rightView distance:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualRightXView:(UIView *)rightView view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Width
+ (void)layoutEqualWidth:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualWidthView:(UIView *)widthView ration:(CGFloat)ration priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualWidthView:(UIView *)widthView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutEqualWidth:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualWidthView:(UIView *)widthView ration:(CGFloat)ration view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualWidthView:(UIView *)widthView view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Height
+ (void)layoutEqualHeight:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualHeightView:(UIView *)heightView ration:(CGFloat)ration priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualHeightView:(UIView *)heightView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutEqualHeight:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualHeightView:(UIView *)heightView ration:(CGFloat)ration view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualHeightView:(UIView *)heightView view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Width Height
+ (void)layoutEqualWidthHeightRation:(CGFloat)ration priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualHeightWidthRation:(CGFloat)ration priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualWidthHeightEqualWithPriority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualWidthToHeightView:(UIView *)heightView ration:(CGFloat)ration priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualHeightToWidthView:(UIView *)widthView ration:(CGFloat)ration priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutEqualWidthHeightRation:(CGFloat)ration view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualHeightWidthRation:(CGFloat)ration view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualWidthHeightEqualWithView:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualWidthToHeightView:(UIView *)heightView ration:(CGFloat)ration view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualHeightToWidthView:(UIView *)widthView ration:(CGFloat)ration view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Edge
+ (void)layoutEqualEdge:(UIEdgeInsets)Edge priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualEdge:(UIEdgeInsets)Edge view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Center
+ (void)layoutEqualCenterX:(UIView *)centerView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualCenterY:(UIView *)centerView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualCenter:(UIView *)centerView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutEqualCenterX:(UIView *)centerView view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualCenterY:(UIView *)centerView view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutEqualCenter:(UIView *)centerView view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Size
+ (void)layoutEqualSize:(CGSize)size priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutEqualSize:(CGSize)size view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Same
+ (void)layoutEqualSame:(UIView *)sameView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutEqualSame:(UIView *)sameView view:(UIView *)view relateView:(UIView*)relateView;

@end
