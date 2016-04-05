//
//  HXAlbumsViewController.h
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"


@class HXAlbumsNavigationBar;


@interface HXAlbumsViewController : UIViewController

@property (weak, nonatomic) IBOutlet HXAlbumsNavigationBar *navigationBar;

@property (nonatomic, strong) NSString *albumID;

@end
