//
//  HXAlbumsContainerViewController.h
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXAlbumsViewModel.h"

typedef NS_ENUM(NSUInteger, HXAlbumsAction) {
    HXAlbumsActionPlay,
    HXAlbumsActionPause,
    HXAlbumsActionPrevious,
    HXAlbumsActionNext,
};


@class HXAlbumsContainerViewController;


@protocol HXAlbumsContainerViewControllerDelegate <NSObject>

@required
- (void)container:(HXAlbumsContainerViewController *)container takeAction:(HXAlbumsAction)action;
- (void)container:(HXAlbumsContainerViewController *)container selectedSong:(HXSongModel *)song;
- (void)container:(HXAlbumsContainerViewController *)container selectedComment:(HXCommentModel *)comment;
- (void)containerFetchMoreComment:(HXAlbumsContainerViewController *)container;

@end


@interface HXAlbumsContainerViewController : UITableViewController

@property (weak, nonatomic) IBOutlet id  <HXAlbumsContainerViewControllerDelegate>delegate;

@property (nonatomic, strong) HXAlbumsViewModel *viewModel;

- (void)refresh;
- (void)endFetch;

@end
