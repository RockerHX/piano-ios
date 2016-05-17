//
//  HXSelectedAlbumViewController.h
//  Piano
//
//  Created by miaios on 16/5/17.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"


@protocol HXSelectedAlbumViewControllerDelegate;


@interface HXSelectedAlbumViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet          id  <HXSelectedAlbumViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet      UIView *tapView;
@property (weak, nonatomic) IBOutlet      UIView *containerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

- (void)showOnViewController:(UIViewController *)viewController;
- (void)dismiss;

@end

@protocol HXSelectedAlbumViewControllerDelegate <NSObject>

@required
- (void)selectedAlbumViewController:(HXSelectedAlbumViewController *)viewController selectedAlbum:(id)album;

@end
