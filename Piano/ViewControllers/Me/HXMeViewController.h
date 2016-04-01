//
//  HXMeViewController.h
//  Piano
//
//  Created by miaios on 16/3/22.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"


@class HXMeNavigationBar;


@interface HXMeViewController : UIViewController

@property (weak, nonatomic) IBOutlet HXMeNavigationBar *navigationBar;

- (void)refresh;

@end
