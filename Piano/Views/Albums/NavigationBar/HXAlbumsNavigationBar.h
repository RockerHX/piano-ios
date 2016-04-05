//
//  HXAlbumsNavigationBar.h
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, HXAlbumsNavigationBarAction) {
    HXAlbumsNavigationBarActionBack,
};


@class HXAlbumsNavigationBar;


@protocol HXAlbumsNavigationBarDelegate <NSObject>

@required
- (void)navigationBar:(HXAlbumsNavigationBar *)bar takeAction:(HXAlbumsNavigationBarAction)action;

@end


@interface HXAlbumsNavigationBar : UIView

@property (weak, nonatomic) IBOutlet id  <HXAlbumsNavigationBarDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *albumNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;

- (IBAction)backButtonPressed;

@end
