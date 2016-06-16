//
//  MIARedEnvelopeView.h
//  Piano
//
//  Created by 刘维 on 16/6/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReceiveBlock)();

@interface MIARedEnvelopeView : UIView

/**
 *  设置标题跟提示语.
 *
 *  @param title 标题.
 *  @param tip   提示语.
 */
- (void)setTitle:(NSString *)title tip:(NSString *)tip;

/**
 *  在哪个页面显示.
 *
 *  @param view 若为nil,则会在window上面的添加该view.
 *  @param handler 领取按钮的点击的回调.
 */
- (void)showInView:(UIView *)view receiveHandler:(ReceiveBlock)handler;

/**
 *  隐藏该视图.
 */
- (void)hidden;

@end
