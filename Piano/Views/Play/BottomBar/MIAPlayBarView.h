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

@interface MIAPlayBarView : UIView

/**
 *  设置当前播放的时间.
 *
 *  @param time 播放的时间.
 */
- (void)setCurrentPlayTime:(NSString *)time;

@end
