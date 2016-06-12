//
//  MIAAlbumBarView.h
//  Piano
//
//  Created by 刘维 on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  按钮的pop事件
 */
typedef void(^PopActionBlock)();

typedef void(^ReportActionBlock)();

@interface MIAAlbumBarView : UIView

/**
 *  设置相关的数据.
 *
 *  @param albumName  专辑名称
 *  @param singerName 作者
 */
- (void)setAlbumName:(NSString *)albumName singerName:(NSString *)singerName;

/**
 *  pop按钮的事件回调.
 *
 *  @param block PopActionBlock
 */
- (void)popActionHandler:(PopActionBlock)block;

/**
 *  举报按钮的事件回调.
 *
 *  @param block ReportActionBlock.
 */
- (void)reportActionHandler:(ReportActionBlock)block;

@end
