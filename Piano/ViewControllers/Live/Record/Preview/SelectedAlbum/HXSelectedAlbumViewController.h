//
//  HXSelectedAlbumViewController.h
//  Piano
//
//  Created by miaios on 16/5/17.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"


@class HXAlbumModel;
@protocol HXSelectedAlbumViewControllerDelegate;


@interface HXSelectedAlbumViewController : UIViewController

@property (weak, nonatomic) IBOutlet id  <HXSelectedAlbumViewControllerDelegate>delegate;

- (IBAction)closeButtonPressed;


@end

@protocol HXSelectedAlbumViewControllerDelegate <NSObject>

@required
- (void)selectedAlbumViewController:(HXSelectedAlbumViewController *)viewController selectedAlbum:(HXAlbumModel *)album;

@end
