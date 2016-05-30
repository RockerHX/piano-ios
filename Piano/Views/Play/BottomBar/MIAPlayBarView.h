//
//  MIAPlayBarView.h
//  Piano
//
//  Created by 刘维 on 16/5/30.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PlayBarActionType) {

    PlayBarActionPlay,//播放
    PlayBarActionPause,//暂停
    PlayBarActionSlider,//滑动
    PlayBarActionShare,//分享
};

/**
 *  视图上面的各种事件的回调.
 *
 *  @param type PlayBarActionType.
 */
typedef void (^PlayBarActionBlock)(PlayBarActionType type);

@interface MIAPlayBarView : UIView

/**
 *  设置视频的持续时长.
 *
 *  @param duration 时长.
 */
- (void)setCurrentVideoDuration:(CGFloat)duration;

/**
 *  设置当前播放的时间.
 *
 *  @param time 播放的时间.
 */
- (void)setCurrentPlayTime:(CGFloat)time;

/**
 *  滑动到那个时间点播放.
 *
 *  @return 滑动到的时间点.
 */
- (CGFloat)currentPlayTime;

/**
 *  设置当前的播放状态.
 *
 *  @param state 播放的状态.
 */
- (void)setCurrentPlayState:(BOOL)state;

/**
 *  获取当前的播放状态.
 *
 *  @return 播放的状态
 */
- (BOOL)currentPlayState;

/**
 *  事件的回调.
 *
 *  @param block PlayBarActionBlock.
 */
- (void)palyBarActionHanlder:(PlayBarActionBlock)block;

@end
