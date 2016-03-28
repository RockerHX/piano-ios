//
//  HXAlbumsContainerViewController.h
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HXAlbumsContainerViewControllerDelegate <NSObject>

@required

@end


@interface HXAlbumsContainerViewController : UITableViewController

@property (weak, nonatomic) IBOutlet id  <HXAlbumsContainerViewControllerDelegate>delegate;

@end
