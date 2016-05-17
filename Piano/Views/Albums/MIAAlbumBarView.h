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

@interface MIAAlbumBarView : UIView

- (void)popActionHandler:(PopActionBlock)block;

@end
