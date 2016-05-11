//
//  MIAProfileHeadView.h
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat const kAttentionButtonTag; //关注按钮的tag值

/**
 *  关注按钮的事件回调block
 */
typedef void(^AttentionActionBlock)(BOOL state);

@interface MIAProfileHeadView : UIView

/**
 *  设置部分数据.
 *
 *  @param imageURL 头像的URL地址
 *  @param name     名字
 *  @param summary  介绍
 */
- (void)setProfileHeadImageURL:(NSString *)imageURL name:(NSString *)name summary:(NSString *)summary;

/**
 *  设置数据
 *
 *  @param fans      粉丝
 *  @param attention 关注
 *  @param state     关注的状态
 */
- (void)setProfileFans:(NSString *)fans attention:(NSString *)attention;

/**
 *  设置关注按钮的状态
 *
 *  @param state 关注的状态
 */
- (void)setAttentionButtonState:(BOOL)state;

/**
 *  设置蒙版的透明度
 *
 *  @param alpha 透明度的值
 */
- (void)setProfileMaskAlpha:(CGFloat)alpha;

/**
 *  关注按钮的点击回调.
 *
 *  @param handler AttentionActionBlock.
 */
- (void)attentionActionHandler:(AttentionActionBlock)handler;

@end
