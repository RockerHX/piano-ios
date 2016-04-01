//
//  HXProfileViewController.h
//  Piano
//
//  Created by miaios on 16/3/22.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"


@class HXProfileNavigationBar;


@interface HXProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet HXProfileNavigationBar *navigationBar;

@property (nonatomic, strong) NSString *uid;

@end
