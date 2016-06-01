//
//  HXSelectedAlbumContainerViewController.h
//  Piano
//
//  Created by miaios on 16/6/1.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HXSelectedAlbumContainerViewControllerDelegate;


@interface HXSelectedAlbumContainerViewController : UICollectionViewController

@property (weak, nonatomic) IBOutlet id  <HXSelectedAlbumContainerViewControllerDelegate>delegate;

@property (nonatomic, strong) NSArray *albums;

@end


@protocol HXSelectedAlbumContainerViewControllerDelegate <NSObject>

@required
- (void)container:(HXSelectedAlbumContainerViewController *)contianer selectedIndex:(NSInteger )index;

@end
