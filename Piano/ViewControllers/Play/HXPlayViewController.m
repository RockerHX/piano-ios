//
//  HXPlayViewController.m
//  mia
//
//  Created by miaios on 16/2/25.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXPlayViewController.h"
#import "HXPlayTopBar.h"
#import "HXPlaySummaryView.h"
#import "HXPlayBottomBar.h"
//#import "MusicMgr.h"
#import "UIImageView+WebCache.h"
#import "HXUserSession.h"
#import "MiaAPIHelper.h"
//#import "LocationMgr.h"
#import "HXAlertBanner.h"
//#import "FavoriteMgr.h"
//#import "HXMusicDetailViewController.h"

@interface HXPlayViewController () <
HXPlayTopBarDelegate,
HXPlaySummaryViewDelegate,
HXPlayBottomBarDelegate
>
@end

@implementation HXPlayViewController {
    BOOL _shouldHideenNavigationBar;
    
//    MusicMgr *_musicMgr;
    dispatch_source_t _timer;
}

#pragma mark - Class Methods
+ (NSString *)navigationControllerIdentifier {
    return @"HXPlayNavigationController";
}

+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNamePlay;
}

#pragma mark - View Controller Lift Cycle
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	[self viewConfigure];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:_shouldHideenNavigationBar animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:MusicMgrNotificationPlayerEvent object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:FavoriteMgrNotificationKey_EmptyList object:nil];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
//    _musicMgr = [MusicMgr standard];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPlayerEvent:) name:MusicMgrNotificationPlayerEvent object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationEmptyList) name:FavoriteMgrNotificationKey_EmptyList object:nil];
}

- (void)viewConfigure {
    [self updatePlayView];
}

#pragma mark - Notification Methods
- (void)notificationPlayerEvent:(NSNotification *)notification {
    [self updatePlayView];
}

- (void)notificationEmptyList {
//	if (_musicMgr.playList.count) {
//		return;
//	}

    [self dismiss];
}

#pragma mark - Private Methods
- (void)dismiss {
    _shouldHideenNavigationBar = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)updatePlayView {
//    [_coverBG sd_setImageWithURL:[NSURL URLWithString:_musicMgr.currentItem.music.purl] placeholderImage:nil];
    
    [self updateTopBar];
    [self updateSummaryView];
    [self updateBottomBar];
}

- (void)updateTopBar {
//    ShareItem *item = _musicMgr.currentItem;
//    _topBar.sharerNameLabel.text = item.sNick;
}

- (void)updateSummaryView {
//    [_summaryView updateWithMusic:_musicMgr.currentItem.music];
}

- (void)updateBottomBar {
    [self startMusicTimeRead];
    
//    ShareItem *item = _musicMgr.currentItem;
//    _bottomBar.favorited = item.favorite;
//    _bottomBar.infected = item.isInfected;
//    
//    NSInteger playIndex = _musicMgr.currentIndex;
//    BOOL isFirst = (playIndex == 0);
//    BOOL isLast = (playIndex == _musicMgr.musicCount);
//    
//    NSInteger nextIndex = _musicMgr.currentIndex + 1;
//    if (nextIndex < _musicMgr.playList.count) {
//        ShareItem *nextItem = _musicMgr.playList[nextIndex];
//        if (nextItem.placeHolder) {
//            isLast = YES;
//        }
//    }
//    
//    _bottomBar.pause = _musicMgr.isPlaying;
//    _bottomBar.enablePrevious = !isFirst;
//    _bottomBar.enableNext = !isLast;
}

- (void)startMusicTimeRead {
    uint64_t interval = NSEC_PER_SEC;
    dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, 0), interval, 0);
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updatePlayTime];
        });
    });
    dispatch_resume(_timer);
}

- (void)updatePlayTime {
//    _bottomBar.musicTime = _musicMgr.durationSeconds;
//    _bottomBar.slider.value = _musicMgr.currentPlayedPostion;
//    _bottomBar.playTime = _musicMgr.currentPlayedSeconds;
}

- (NSArray *)musicList {
    NSMutableArray *musicList = @[].mutableCopy;
//    NSArray *playList = _musicMgr.playList;
//    for (ShareItem *item in playList) {
//        MusicItem *music = item.music;
//        if (music && [music isKindOfClass:[MusicItem class]]) {
//            [musicList addObject:music];
//        }
//    }
    return [musicList copy];
}

- (void)play {
//    [_musicMgr playCurrent];
}

- (void)pause {
//	if ([_musicMgr isPlaying]) {
//		[_musicMgr pause];
//	} else {
//		[_musicMgr playCurrent];
//	}
}

- (void)previous {
//    [_musicMgr playPrevios];
    [self updatePlayView];
}

- (void)next {
//    [_musicMgr playNext];
    [self updatePlayView];
}

- (void)takeFavoriteAction {
    switch ([HXUserSession session].state) {
        case HXUserStateLogout: {
            [self shouldLogin];
            break;
        }
        case HXUserStateLogin: {
//            ShareItem *item = _musicMgr.currentItem;
//            [MiaAPIHelper favoriteMusicWithShareID:item.sID
//                                        isFavorite:!item.favorite
//                                     completeBlock:
//             ^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
//                 if (success) {
//                     id act = userInfo[MiaAPIKey_Values][@"act"];
//                     id sID = userInfo[MiaAPIKey_Values][@"id"];
//                     BOOL favorite = [act intValue];
//                     if ([item.sID integerValue] == [sID intValue]) {
//                         item.favorite = favorite;
//                     }
//                     
//                     [HXAlertBanner showWithMessage:(favorite ? @"收藏成功" : @"取消收藏成功") tap:nil];
//                     [self updatePlayView];
//                     // 收藏操作成功后同步下收藏列表并检查下载
//                     [[FavoriteMgr standard] syncFavoriteList];
//                 } else {
//                     id error = userInfo[MiaAPIKey_Values][MiaAPIKey_Error];
//                     [HXAlertBanner showWithMessage:[NSString stringWithFormat:@"%@", error] tap:nil];
//                 }
//             } timeoutBlock:^(MiaRequestItem *requestItem) {
//                 [HXAlertBanner showWithMessage:@"收藏失败，网络请求超时" tap:nil];
//             }];
            break;
        }
    }
}

- (void)takeInfectAction {
    switch ([HXUserSession session].state) {
        case HXUserStateLogout: {
            [self shouldLogin];
            break;
        }
        case HXUserStateLogin: {
//            ShareItem *item = _musicMgr.currentItem;
//            // 传播出去不需要切换歌曲，需要记录下传播的状态和上报服务器
//            [MiaAPIHelper InfectMusicWithLatitude:[[LocationMgr standard] currentCoordinate].latitude
//                                        longitude:[[LocationMgr standard] currentCoordinate].longitude
//                                          address:[[LocationMgr standard] currentAddress]
//                                             spID:item.spID
//                                    completeBlock:
//             ^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
//                 if (success) {
//                     int isInfected = [userInfo[MiaAPIKey_Values][@"data"][@"isInfected"] intValue];
//                     int infectTotal = [userInfo[MiaAPIKey_Values][@"data"][@"infectTotal"] intValue];
//                     NSArray *infectArray = userInfo[MiaAPIKey_Values][@"data"][@"infectList"];
//                     NSString *spID = [userInfo[MiaAPIKey_Values][@"data"][@"spID"] stringValue];
//                     
//                     if ([spID isEqualToString:item.spID]) {
//                         item.infectTotal = infectTotal;
//                         [item parseInfectUsersFromJsonArray:infectArray];
//                         item.isInfected = isInfected;
//                     }
//                     [self updatePlayView];
//                     [HXAlertBanner showWithMessage:@"妙推成功！" tap:nil];
//                 } else {
//                     NSString *error = userInfo[MiaAPIKey_Values][MiaAPIKey_Error];
//                     [HXAlertBanner showWithMessage:error tap:nil];
//                 }
//             } timeoutBlock:^(MiaRequestItem *requestItem) {
//                 item.isInfected = YES;
//                 [HXAlertBanner showWithMessage:@"妙推失败，网络请求超时" tap:nil];
//             }];
            break;
        }
    }
}

- (void)showMusicDetail {
//    HXMusicDetailViewController *detailViewController = [HXMusicDetailViewController instance];
//    detailViewController.playItem = _musicMgr.currentItem;
//    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - HXPlayTopBarDelegate Methods
- (void)topBar:(HXPlayTopBar *)bar takeAction:(HXPlayTopBarAction)action {
    switch (action) {
        case HXPlayTopBarActionBack: {
            [self dismiss];
            break;
        }
    }
}

#pragma mark - HXPlaySummaryViewDelegate Methods
- (void)summaryViewTaped:(HXPlaySummaryView *)summaryView {
    [self showMusicDetail];
}

#pragma mark - HXPlayBottomBarDelegate Methods
- (void)bottomBar:(HXPlayBottomBar *)bar takeAction:(HXPlayBottomBarAction)action {
    switch (action) {
        case HXPlayBottomBarActionPrevious: {
            [self previous];
            break;
        }
        case HXPlayBottomBarActionPause: {
            [self pause];
            break;
        }
        case HXPlayBottomBarActionNext: {
            [self next];
            break;
        }
    }
}

- (void)bottomBar:(HXPlayBottomBar *)bar seekToPosition:(float)postion {
//	[_musicMgr seekToPosition:postion];
}

@end
