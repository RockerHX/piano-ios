//
//  HXMainViewController.h
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(BOOL, HXMenuState) {
    HXMenuStateClose,
    HXMenuStateOpen,
};


@interface HXMainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *profileContainerView;
@property (weak, nonatomic) IBOutlet UIView *discoveryContainerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *discoveryLeftConstraint;

@property (nonatomic, assign, readonly) HXMenuState menuState;

@end
