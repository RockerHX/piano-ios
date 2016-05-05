//
//  JOFAutoLayout.h
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/10/27.
//  Copyright © 2015年 刘维. All rights reserved.
//

#import "JOFunctionObject.h"

@interface JOAutoLayout : JOFunctionObject

/**
 移除所有的Autolayout.
 
 @param view - 需要移除AutoLayout的视图.
 
 @return - void.
 */
+ (void)removeAllAutoLayoutWithSelfView:(UIView *)selfView superView:(UIView *)superView;

+ (void)removeAutoLayoutWithHeightSelfView:(UIView *)selfView superView:(UIView *)superView;

+ (void)removeAutoLayoutWithWidthSelfView:(UIView *)selfView superView:(UIView *)superView;

+ (void)removeAutoLayoutWithLeftSelfView:(UIView *)selfView superView:(UIView *)superView;

+ (void)removeAutoLayoutWithRightSelfView:(UIView *)selfView superView:(UIView *)superView;

+ (void)removeAutoLayoutWithTopSelfView:(UIView *)selfView superView:(UIView *)superView;

+ (void)removeAutoLayoutWithBottomSelfView:(UIView *)selfView superView:(UIView *)superView;

+ (void)removeAutoLayoutWithEdgeSelfView:(UIView *)selfView superView:(UIView *)superView;

+ (void)removeAutoLayoutWithSizeSelfView:(UIView *)selfView superView:(UIView *)superView;

/**
 自动布局:跟参照的视图布局完全一样.
 
 @param sameView - 参照的View.
 @param selfView - 需要布局的子视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithSameView:(UIView *)sameView
                      selfView:(UIView *)selfView
                     superView:(UIView *)superView;

/**
 自动布局:距离顶部,左边,下边,右边的距离.
 
 @param edgeInsets - 各个距离的UIEdgeInsets.
 @param selfView - 需要布局的子视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithEdgeInsets:(UIEdgeInsets )edgeInsets
                        selfView:(UIView *)selfView
                       superView:(UIView *)superView;

/**
 自动布局:位于中心,大小不变.
 
 @param selfView - 需要布局的子视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutCenterWithSize:(CGSize )size
                        selfView:(UIView *)selfView
                       superView:(UIView *)superView;


/**
 自动布局:距离顶部的距离.
 
 @param topSpaceDistance - 距离顶部的距离.
 @param selfView - 需要布局的子视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithTopSpaceDistance:(CGFloat )topSpaceDistance
                              selfView:(UIView *)selfView
                             superView:(UIView *)superView;

/**
 自动布局:距离底部的距离.
 
 @param topSpaceDistance - 距离底部的距离.
 @param selfView - 需要布局的子视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithBottomSpaceDistance:(CGFloat )bottomSpaceDistance
                                 selfView:(UIView *)selfView
                                superView:(UIView *)superView;

/**
 自动布局:距离左边的距离.
 
 @param topSpaceDistance - 距离左边的距离.
 @param selfView - 需要布局的子视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithLeftSpaceDistance:(CGFloat )leftSpaceDistance
                               selfView:(UIView *)selfView
                              superView:(UIView *)superView;

/**
 自动布局:距离右边的距离.
 
 @param topSpaceDistance - 距离右边的距离.
 @param selfView - 需要布局的子视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithRightSpaceDistance:(CGFloat )rightSpaceDistance
                                selfView:(UIView *)selfView
                               superView:(UIView *)superView;

/**
 自动布局:在父视图中心X处.
 
 @param selfView - 需要布局的子视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutCenterXWithSelfView:(UIView *)selfView superView:(UIView *)superView;

/**
 自动布局:在父视图中心Y处.
 
 @param selfView - 需要布局的子视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutCenterYWithSelfView:(UIView *)selfView superView:(UIView *)superView;

/**
 自动布局:在父视图中心处.
 
 @param selfView - 需要布局的子视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutCenterWithSelfView:(UIView *)selfView superView:(UIView *)superView;

/**
 自动布局:宽度不变.
 
 @param selfView - 需要布局的子视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithWidth:(CGFloat )width
                   selfView:(UIView *)selfView
                  superView:(UIView *)superView;

/**
 自动布局:高度不变.
 
 @param selfView - 需要布局的子视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithHeight:(CGFloat )height
                    selfView:(UIView *)selfView
                   superView:(UIView *)superView;

/**
 自动布局:宽高不变.
 
 @param selfView - 需要布局的子视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithSize:(CGSize )size
                  selfView:(UIView *)selfView
                 superView:(UIView *)superView;

/**
 自动布局:跟leftXView保持左对齐.
 
 @param leftXView - 需要左对齐的基准视图.
 @param selfView - 需要布局的子视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithLeftXView:(UIView *)leftXView
                       selfView:(UIView *)selfView
                      superView:(UIView *)superView;

/**
 自动布局:跟rightXView保持右对齐.
 
 @param leftXView - 需要右对齐的基准视图.
 @param selfView - 需要布局的子视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithRightXView:(UIView *)rightXView
                        selfView:(UIView *)selfView
                       superView:(UIView *)superView;

/**
 自动布局:跟topYView保持上对其.
 
 @param topYView - 需要上对其的基准视图.
 @param selfView - 需要布局的子视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithTopYView:(UIView *)topYView
                      selfView:(UIView *)selfView
                     superView:(UIView *)superView;

/**
 自动布局:跟bottomYView保持下对其.
 
 @param bottomYView - 需要下对其的基准视图.
 @param selfView - 需要布局的子视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithBottomYView:(UIView *)bottomYView
                         selfView:(UIView *)selfView
                        superView:(UIView *)superView;

/**
 自动布局:跟leftXView保持左对齐.
 
 @param leftXView - 需要左对齐的基准视图.
 @param distance - 两者的位移.
 @param selfView - 需要布局的子视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithLeftXView:(UIView *)leftXView
                       distance:(CGFloat)distance
                       selfView:(UIView *)selfView
                      superView:(UIView *)superView;

/**
 自动布局:跟rightXView保持右对齐.
 
 @param leftXView - 需要右对齐的基准视图.
 @param distance - 两者的位移.
 @param selfView - 需要布局的子视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithRightXView:(UIView *)rightXView
                        distance:(CGFloat)distance
                        selfView:(UIView *)selfView
                       superView:(UIView *)superView;

/**
 自动布局:跟topYView保持上对其.
 
 @param topYView - 需要上对其的基准视图.
 @param distance - 两者的位移.
 @param selfView - 需要布局的子视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithTopYView:(UIView *)topYView
                      distance:(CGFloat)distance
                      selfView:(UIView *)selfView
                     superView:(UIView *)superView;

/**
 自动布局:跟bottomYView保持下对其.
 
 @param bottomYView - 需要下对其的基准视图.
 @param distance - 两者的位移.
 @param selfView - 需要布局的子视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithBottomYView:(UIView *)bottomYView
                         distance:(CGFloat)distance
                         selfView:(UIView *)selfView
                        superView:(UIView *)superView;

/**
 自动布局:跟左边的视图保持距离不变
 
 @param leftView - 左边的视图.
 @param distance - 距离.
 @param selfView - 本身的视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithLeftView:(UIView *)leftView
                      distance:(CGFloat )distance
                      selfView:(UIView *)selfView
                     superView:(UIView *)superView;

/**
 自动布局:跟右边的视图保持距离不变
 
 @param rightView - 右边的视图.
 @param distance - 距离.
 @param selfView - 本身的视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithRightView:(UIView *)rightView
                       distance:(CGFloat )distance
                       selfView:(UIView *)selfView
                      superView:(UIView *)superView;

/**
 自动布局:跟上边的视图保持距离不变
 
 @param topView - 上边的视图.
 @param distance - 距离.
 @param selfView - 本身的视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithTopView:(UIView *)topView
                     distance:(CGFloat )distance
                     selfView:(UIView *)selfView
                    superView:(UIView *)superView;

/**
 自动布局:跟下边的视图保持距离不变
 
 @param bottomView - 下边的视图.
 @param distance - 距离.
 @param selfView - 本身的视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithBottomView:(UIView *)bottomView
                        distance:(CGFloat )distance
                        selfView:(UIView *)selfView
                       superView:(UIView *)superView;

/**
 自动布局:与前一视图保持中心x不变
 
 @param centerXView - 根据x不变的视图.
 @param selfView - 本身的视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithCenterXWithView:(UIView *)centerXView
                             selfView:(UIView *)selfView
                            superView:(UIView *)superView;

/**
 自动布局:与前一视图保持中心Y不变
 
 @param centerYView - 根据y不变的视图.
 @param selfView - 本身的视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithCenterYWithView:(UIView *)centerYView
                             selfView:(UIView *)selfView
                            superView:(UIView *)superView;

/**
 自动布局:与前一视图保持中心不变
 
 @param centerView - 根据中心不变的视图.
 @param selfView - 本身的视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithCenterWithView:(UIView *)centerView
                            selfView:(UIView *)selfView
                           superView:(UIView *)superView;

/**
 自动布局:与前一视图保持宽度不变
 
 @param widthView - 宽度不变的视图.
 @param selfView - 本身的视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithWidthWithView:(UIView *)widthView
                           selfView:(UIView *)selfView
                          superView:(UIView *)superView;

/**
 自动布局:与前一视图保持高度不变
 
 @param heightView - 高度不变的视图.
 @param selfView - 本身的视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithHeightWithView:(UIView *)heightView
                            selfView:(UIView *)selfView
                           superView:(UIView *)superView;

/**
 自动布局:与前一视图保持宽度的比例不变
 
 @param widthView - 宽度不变的视图.
 @param ratioValue - 比例的大小.
 @param selfView - 本身的视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithWidthWithView:(UIView *)widthView
                         ratioValue:(CGFloat )ratio
                           selfView:(UIView *)selfView
                          superView:(UIView *)superView;

/**
 自动布局:与前一视图保持高度比例不变
 
 @param heightView - 高度不变的视图.
 @param ratioValue - 比例的大小.
 @param selfView - 本身的视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithHeightWithView:(UIView *)heightView
                          ratioValue:(CGFloat )ratio
                            selfView:(UIView *)selfView
                           superView:(UIView *)superView;

/**
 自动布局:与前一视图保持size大小不变
 
 @param sizeView - 大小不变的视图.
 @param selfView - 本身的视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithSizeWithView:(UIView *)sizeView
                          selfView:(UIView *)selfView
                         superView:(UIView *)superView;

/**
 自动布局:视图的宽高相等.
 
 @param selfView - 本身的视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithWidthEqualHeightWithselfView:(UIView *)selfView
                                         superView:(UIView *)superView;

/**
 自动布局:视图的宽高比保持不变.
 
 @param ratio - 视图的宽/高比.
 @param selfView - 本身的视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithWidthHeightRatioValue:(CGFloat )ratio
                                   selfView:(UIView *)selfView
                                  superView:(UIView *)superView;

/**
 自动布局:视图的高宽比保持不变.
 
 @param ratio - 视图的高/宽比.
 @param selfView - 本身的视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithHeightWidthRatioValue:(CGFloat )ratio
                                   selfView:(UIView *)selfView
                                  superView:(UIView *)superView;

/**
 自动布局:高度与宽度视图的宽度保持比例不变
 
 @param widthView - 宽度的视图.
 @param ratioValue - 高度与宽度视图的宽度的比例大小.
 @param selfView - 本身的视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithHeightWithWidthView:(UIView *)widthView
                               ratioValue:(CGFloat )ratio
                                 selfView:(UIView *)selfView
                                superView:(UIView *)superView;

/**
 自动布局:宽度与高度视图的宽度保持比例不变
 
 @param heightView - 高度的视图.
 @param ratioValue - 高度与宽度视图的宽度的比例大小.
 @param selfView - 本身的视图.
 @param superView - 父视图.
 
 @return - void.
 */
+ (void)autoLayoutWithWidthWithHeightView:(UIView *)heightView
                               ratioValue:(CGFloat )ratio
                                 selfView:(UIView *)selfView
                                superView:(UIView *)superView;


@end
