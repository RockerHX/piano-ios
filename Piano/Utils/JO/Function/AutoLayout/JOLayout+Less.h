//
//  JOLayout+Less.h
//  Piano
//
//  Created by 刘维 on 16/6/17.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "JOLayout.h"

@interface JOLayout(Less)

#pragma mark - Top
+ (void)layoutLessTop:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessTopView:(UIView *)topView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessTopView:(UIView *)topView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessTopYView:(UIView *)topView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessTopYView:(UIView *)topView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutLessTop:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessTopView:(UIView *)topView view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessTopView:(UIView *)topView distance:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessTopYView:(UIView *)topView view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessTopYView:(UIView *)topView distance:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Bottom
+ (void)layoutLessBottom:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessBottomView:(UIView *)bottomView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessBottomView:(UIView *)bottomView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessBottomYView:(UIView *)bottomView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessBottomYView:(UIView *)bottomView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutLessBottom:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessBottomView:(UIView *)bottomView distance:(CGFloat)distance  view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessBottomView:(UIView *)bottomView view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessBottomYView:(UIView *)bottomView distance:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessBottomYView:(UIView *)bottomView view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Left
+ (void)layoutLessLeft:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessLeftView:(UIView *)leftView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessLeftView:(UIView *)leftView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessLeftXView:(UIView *)leftView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessLeftXView:(UIView *)leftView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutLessLeft:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessLeftView:(UIView *)leftView distance:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessLeftView:(UIView *)leftView view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessLeftXView:(UIView *)leftView distance:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessLeftXView:(UIView *)leftView view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Right
+ (void)layoutLessRight:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessRightView:(UIView *)rightView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessRightView:(UIView *)rightView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessRightXView:(UIView *)rightView distance:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessRightXView:(UIView *)rightView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutLessRight:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessRightView:(UIView *)rightView distance:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessRightView:(UIView *)rightView view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessRightXView:(UIView *)rightView distance:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessRightXView:(UIView *)rightView view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Width
+ (void)layoutLessWidth:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessWidthView:(UIView *)widthView ration:(CGFloat)ration priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessWidthView:(UIView *)widthView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutLessWidth:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessWidthView:(UIView *)widthView ration:(CGFloat)ration view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessWidthView:(UIView *)widthView view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Height
+ (void)layoutLessHeight:(CGFloat)distance priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessHeightView:(UIView *)heightView ration:(CGFloat)ration priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessHeightView:(UIView *)heightView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutLessHeight:(CGFloat)distance view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessHeightView:(UIView *)heightView ration:(CGFloat)ration view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessHeightView:(UIView *)heightView view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Width Height
+ (void)layoutLessWidthHeightRation:(CGFloat)ration priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessHeightWidthRation:(CGFloat)ration priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessWidthHeightEqualWithPriority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessWidthToHeightView:(UIView *)heightView ration:(CGFloat)ration priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessHeightToWidthView:(UIView *)widthView ration:(CGFloat)ration priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutLessWidthHeightRation:(CGFloat)ration view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessHeightWidthRation:(CGFloat)ration view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessWidthHeightEqualWithView:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessWidthToHeightView:(UIView *)heightView ration:(CGFloat)ration view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessHeightToWidthView:(UIView *)widthView ration:(CGFloat)ration view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Edge
+ (void)layoutLessEdge:(UIEdgeInsets)Edge priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessEdge:(UIEdgeInsets)Edge view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Center
+ (void)layoutLessCenterX:(UIView *)centerView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessCenterY:(UIView *)centerView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessCenter:(UIView *)centerView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutLessCenterX:(UIView *)centerView view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessCenterY:(UIView *)centerView view:(UIView *)view relateView:(UIView*)relateView;
+ (void)layoutLessCenter:(UIView *)centerView view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Size
+ (void)layoutLessSize:(CGSize)size priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutLessSize:(CGSize)size view:(UIView *)view relateView:(UIView*)relateView;

#pragma mark - Same
+ (void)layoutLessSame:(UIView *)sameView priority:(UILayoutPriority)priority view:(UIView *)view relateView:(UIView*)relateView;

+ (void)layoutLessSame:(UIView *)sameView view:(UIView *)view relateView:(UIView*)relateView;

@end
