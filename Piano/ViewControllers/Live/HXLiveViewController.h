//
//  HXLiveViewController.h
//  Piano
//
//  Created by miaios on 16/3/18.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"
#import "HXLiveModel.h"


@interface HXLiveViewController : UIViewController

@property(nonatomic, strong) HXLiveModel *model;

- (IBAction)exitButtonPressed;

@end
