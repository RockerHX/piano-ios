//
//  JOLayout+Than.h
//  Piano
//
//  Created by 刘维 on 16/6/17.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "JOLayout.h"

@interface JOLayout(Than)

#pragma mark - Top
+ (void)layoutThanTop:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanTopView:(UIView *)topView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanTopView:(UIView *)topView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanTopYView:(UIView *)topView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanTopYView:(UIView *)topView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutThanTop:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanTopView:(UIView *)topView view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanTopView:(UIView *)topView distance:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanTopYView:(UIView *)topView view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanTopYView:(UIView *)topView distance:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Bottom
+ (void)layoutThanBottom:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanBottomView:(UIView *)bottomView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanBottomView:(UIView *)bottomView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanBottomYView:(UIView *)bottomView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanBottomYView:(UIView *)bottomView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutThanBottom:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanBottomView:(UIView *)bottomView distance:(CGFloat)distance  view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanBottomView:(UIView *)bottomView view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanBottomYView:(UIView *)bottomView distance:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanBottomYView:(UIView *)bottomView view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Left
+ (void)layoutThanLeft:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanLeftView:(UIView *)leftView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanLeftView:(UIView *)leftView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanLeftXView:(UIView *)leftView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanLeftXView:(UIView *)leftView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutThanLeft:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanLeftView:(UIView *)leftView distance:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanLeftView:(UIView *)leftView view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanLeftXView:(UIView *)leftView distance:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanLeftXView:(UIView *)leftView view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Right
+ (void)layoutThanRight:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanRightView:(UIView *)rightView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanRightView:(UIView *)rightView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanRightXView:(UIView *)rightView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanRightXView:(UIView *)rightView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutThanRight:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanRightView:(UIView *)rightView distance:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanRightView:(UIView *)rightView view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanRightXView:(UIView *)rightView distance:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanRightXView:(UIView *)rightView view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Width
+ (void)layoutThanWidth:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanWidthView:(UIView *)widthView ration:(CGFloat)ration priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanWidthView:(UIView *)widthView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutThanWidth:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanWidthView:(UIView *)widthView ration:(CGFloat)ration view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanWidthView:(UIView *)widthView view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Height
+ (void)layoutThanHeight:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanHeightView:(UIView *)heightView ration:(CGFloat)ration priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanHeightView:(UIView *)heightView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutThanHeight:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanHeightView:(UIView *)heightView ration:(CGFloat)ration view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanHeightView:(UIView *)heightView view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Width Height
+ (void)layoutThanWidthHeightRation:(CGFloat)ration priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanHeightWidthRation:(CGFloat)ration priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanWidthHeightEqualWithPriority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanWidthToHeightView:(UIView *)heightView ration:(CGFloat)ration priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanHeightToWidthView:(UIView *)widthView ration:(CGFloat)ration priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutThanWidthHeightRation:(CGFloat)ration view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanHeightWidthRation:(CGFloat)ration view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanWidthHeightEqualWithView:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanWidthToHeightView:(UIView *)heightView ration:(CGFloat)ration view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanHeightToWidthView:(UIView *)widthView ration:(CGFloat)ration view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Edge
+ (void)layoutThanEdge:(UIEdgeInsets)Edge priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanEdge:(UIEdgeInsets)Edge view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Center
+ (void)layoutThanCenterX:(UIView *)centerView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanCenterY:(UIView *)centerView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanCenter:(UIView *)centerView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutThanCenterX:(UIView *)centerView view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanCenterY:(UIView *)centerView view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutThanCenter:(UIView *)centerView view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Size
+ (void)layoutThanSize:(CGSize)size priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutThanSize:(CGSize)size view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Same
+ (void)layoutThanSame:(UIView *)sameView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutThanSame:(UIView *)sameView view:(UIView *)view relateView:(UIView*)relateView;

@end
