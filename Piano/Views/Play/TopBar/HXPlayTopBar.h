//
//  HXPlayTopBar.h
//  mia
//
//  Created by miaios on 16/2/25.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXPlayTopBar;

typedef NS_ENUM(NSUInteger, HXPlayTopBarAction) {
    HXPlayTopBarActionBack,
};

@protocol HXPlayTopBarDelegate <NSObject>

@required
- (void)topBar:(HXPlayTopBar *)bar takeAction:(HXPlayTopBarAction)action;

@end

@interface HXPlayTopBar : UIView

@property (weak, nonatomic) IBOutlet      id  <HXPlayTopBarDelegate>delegate;
@property (weak, nonatomic) IBOutlet  UIView *containerView;

- (IBAction)backButtonPressed;

@end
