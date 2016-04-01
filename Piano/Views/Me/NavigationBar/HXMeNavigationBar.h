//
//  HXMeNavigationBar.h
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, HXMeNavigationBarAction) {
    HXMeNavigationBarActionSetting,
};


@class HXMeNavigationBar;


@protocol HXMeNavigationBarDelegate <NSObject>

@required
- (void)navigationBar:(HXMeNavigationBar *)bar action:(HXMeNavigationBarAction)action;

@end


@interface HXMeNavigationBar : UIView

@property (weak, nonatomic) IBOutlet     id  <HXMeNavigationBarDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIView *bottomLine;

- (IBAction)settingButtonPressed;

- (void)showBottomLine:(BOOL)show;

@end
