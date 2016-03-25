//
//  HXRecordBottomBar.h
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, HXRecordBottomBarAction) {
    HXRecordBottomBarActionComment,
    HXRecordBottomBarActionForwarding,
};


@class HXRecordBottomBar;


@protocol HXRecordBottomBarDelegate <NSObject>

@required
- (void)bottomBar:(HXRecordBottomBar *)bar takeAction:(HXRecordBottomBarAction)action;

@end


@interface HXRecordBottomBar : UIView

@property (weak, nonatomic) IBOutlet id  <HXRecordBottomBarDelegate>delegate;

- (IBAction)commentButtonPressed;
- (IBAction)forwardingButtonPressed;

@end
