//
//  HXProfileNavigationBar.h
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, HXProfileNavigationBarAction) {
    HXProfileNavigationBarActionBack,
};


@class HXProfileNavigationBar;


@protocol HXProfileNavigationBarDelegate <NSObject>

@required
- (void)navigationBar:(HXProfileNavigationBar *)bar action:(HXProfileNavigationBarAction)action;

@end


@interface HXProfileNavigationBar : UIView

@property (weak, nonatomic) IBOutlet     id  <HXProfileNavigationBarDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIView *bottomLine;

- (IBAction)backButtonPressed;

- (void)showBottomLine:(BOOL)show;

@end
