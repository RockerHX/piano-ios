//
//  HXAlbumsViewController.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXAlbumsViewController.h"
#import "HXAlbumsNavigationBar.h"
#import "HXAlbumsBottomBar.h"
#import "HXAlbumsContainerViewController.h"
#import "MusicMgr.h"
#import "HXAlbumsCommentViewController.h"


@interface HXAlbumsViewController () <
HXAlbumsNavigationBarDelegate,
HXAlbumsContainerViewControllerDelegate,
HXAlbumsBottomBarDelegate,
HXAlbumsCommentViewControllerDelegate
>
@end


@implementation HXAlbumsViewController {
    HXAlbumsContainerViewController *_containerViewController;
    HXAlbumsViewModel *_viewModel;
}

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameAlbums;
}

+ (NSString *)navigationControllerIdentifier {
    return @"HXAlbumsNavigationController";
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _containerViewController = segue.destinationViewController;
    _containerViewController.delegate = self;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MusicMgrNotificationPlayerEvent object:nil];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPlayerEvent:) name:MusicMgrNotificationPlayerEvent object:nil];
    
    [self showHUD];
    
    _viewModel = [[HXAlbumsViewModel alloc] initWithAlbumID:_albumID];
    _containerViewController.viewModel = _viewModel;
    
    @weakify(self)
    RACSignal *fetchSignal = [_viewModel.fetchCommand execute:nil];
    [fetchSignal subscribeError:^(NSError *error) {
        @strongify(self)
        [self hiddenHUD];
        [self showBannerWithPrompt:error.domain];
    } completed:^{
        @strongify(self)
        [self hiddenHUD];
        [self->_containerViewController refresh];
    }];
}

- (void)viewConfigure {
    ;
}

#pragma mark - Notification Methods
- (void)notificationPlayerEvent:(NSNotification *)notification {
//	NSString *mid = notification.userInfo[MusicMgrNotificationKey_MusicID];
    [_containerViewController refresh];
}

#pragma mark - HXAlbumsNavigationBarDelegate Methods
- (void)navigationBar:(HXAlbumsNavigationBar *)bar takeAction:(HXAlbumsNavigationBarAction)action {
    switch (action) {
        case HXAlbumsNavigationBarActionBack: {
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
    }
}

#pragma mark - HXAlbumsBottomBarDelegate Methods
- (void)bottomView:(HXAlbumsBottomBar *)view takeAction:(HXAlbumsBottomBarAction)action {
    switch (action) {
        case HXAlbumsBottomBarActionComment: {
            HXAlbumsCommentViewController *commentViewController = [HXAlbumsCommentViewController instance];
            commentViewController.delegate = self;
            commentViewController.albumID = _albumID;
            [self addChildViewController:commentViewController];
            [self.view addSubview:commentViewController.view];
            break;
        }
    }
}

#pragma mark - HXAlbumsContainerViewControllerDelegate Methods
- (void)container:(HXAlbumsContainerViewController *)container takeAction:(HXAlbumsAction)action {
    MusicMgr *musicMgr = [MusicMgr standard];
    switch (action) {
        case HXAlbumsActionPlay: {
			if (musicMgr.currentUrlInPlayer
				&& [musicMgr isCurrentHostObject:_containerViewController]) {
				[musicMgr pause];
			} else {
				[musicMgr setPlayList:_viewModel.songs hostObject:_containerViewController];
				[musicMgr playCurrent];
			}
            break;
        }
        case HXAlbumsActionPause: {
            [musicMgr pause];
            break;
        }
        case HXAlbumsActionPrevious: {
            [musicMgr playPrevios];
            break;
        }
        case HXAlbumsActionNext: {
            [musicMgr playNext];
            break;
        }
    }
}

- (void)container:(HXAlbumsContainerViewController *)container selectedSong:(HXSongModel *)song {
    NSInteger index = [_viewModel.songs indexOfObject:song];
	MusicMgr *musicMgr = [MusicMgr standard];

	if (musicMgr.currentUrlInPlayer
		&& [musicMgr isCurrentHostObject:_containerViewController]
		&& [musicMgr.currentItem.mid isEqualToString:song.mid]) {
		[musicMgr pause];
		song.play = musicMgr.isPlaying;
	} else {
		[musicMgr setPlayList:_viewModel.songs hostObject:_containerViewController];
		[[MusicMgr standard] playWithIndex:index];
	}
}

- (void)container:(HXAlbumsContainerViewController *)container selectedComment:(HXCommentModel *)comment {
    ;
}

#pragma mark - HXAlbumsCommentViewControllerDelegate Methods
- (void)commentViewControllerCompleted:(HXAlbumsCommentViewController *)viewController {
    @weakify(self)
    RACSignal *reloadCommentSignal = [_viewModel.reloadCommentCommand execute:nil];
    [reloadCommentSignal subscribeError:^(NSError *error) {
        @strongify(self)
        [self showBannerWithPrompt:error.domain];
    } completed:^{
        @strongify(self)
        [self->_containerViewController refresh];
    }];
}

@end
