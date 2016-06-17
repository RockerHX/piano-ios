//
//  MIAProfileNavigationController.h
//  Piano
//
//  Created by 刘维 on 16/6/17.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIAProfileViewController.h"

@interface MIAProfileNavigationController : UINavigationController

+ (MIAProfileNavigationController *)profileNavigationInstanceWithUID:(NSString *)uid;

+ (MIAProfileViewController *)profileViewControllerInstanceWithUID:(NSString *)uid;

@end
