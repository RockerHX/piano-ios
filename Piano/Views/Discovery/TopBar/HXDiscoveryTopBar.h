//
//  HXDiscoveryTopBar.h
//  Piano
//
//  Created by miaios on 16/4/27.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, HXDiscoveryTopBarAction) {
    HXDiscoveryTopBarActionProfile,
    HXDiscoveryTopBarActionMusic,
};


@class HXDiscoveryTopBar;


@protocol HXDiscoveryTopBarDelegate <NSObject>

@required
- (void)topBar:(HXDiscoveryTopBar *)bar takeAction:(HXDiscoveryTopBarAction)action;

@end


@interface HXDiscoveryTopBar : UIView

@property (weak, nonatomic) IBOutlet       id  <HXDiscoveryTopBarDelegate>delegate;

@property (weak, nonatomic) IBOutlet    UIButton *profileButton;
@property (weak, nonatomic) IBOutlet UIImageView *playerEntry;

- (IBAction)profileButtonPressed;

@end
