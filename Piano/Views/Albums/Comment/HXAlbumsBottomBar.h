//
//  HXAlbumsBottomBar.h
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, HXAlbumsBottomBarAction) {
    HXAlbumsBottomBarActionComment,
};


@class HXAlbumsBottomBar;


@protocol HXAlbumsBottomBarDelegate <NSObject>

@required
- (void)bottomView:(HXAlbumsBottomBar *)view takeAction:(HXAlbumsBottomBarAction)action;

@end


@interface HXAlbumsBottomBar : UIView

@property (weak, nonatomic) IBOutlet id  <HXAlbumsBottomBarDelegate>delegate;

@end
