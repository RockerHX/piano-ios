//
//  HXAlbumsContainerViewController.h
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXAlbumsViewModel.h"


@class HXAlbumsContainerViewController;


@protocol HXAlbumsContainerViewControllerDelegate <NSObject>

@required
- (void)container:(HXAlbumsContainerViewController *)container selectedSong:(HXSongModel *)song;
- (void)container:(HXAlbumsContainerViewController *)container selectedComment:(HXCommentModel *)comment;

@end


@interface HXAlbumsContainerViewController : UITableViewController

@property (weak, nonatomic) IBOutlet id  <HXAlbumsContainerViewControllerDelegate>delegate;

@property (nonatomic, strong) HXAlbumsViewModel *viewModel;

- (void)refresh;

@end
