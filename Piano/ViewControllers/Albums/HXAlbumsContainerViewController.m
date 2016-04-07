//
//  HXAlbumsContainerViewController.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXAlbumsContainerViewController.h"
#import "HXAlbumsControlCell.h"
#import "HXAlbumsSongCell.h"
#import "HXAlbumsCommentCountCell.h"
#import "HXAlbumsCommentCell.h"
#import "MusicMgr.h"


@interface HXAlbumsContainerViewController () <
HXAlbumsControlCellDelegate
>
@end


@implementation HXAlbumsContainerViewController {
    HXAlbumsControlCell *_controlCell;
    
    dispatch_source_t _timer;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    ;
}

- (void)viewConfigure {
    ;
}

#pragma mark - Public Methods
- (void)refresh {
    [self.tableView reloadData];
    
    [self updateControlCellPlayState];
}

#pragma mark - Private Methods
- (void)updateControlCellPlayState {
    MusicMgr *musicMgr = [MusicMgr standard];
    if ([musicMgr isCurrentHostObject:self]) {
        _controlCell.playButton.selected = [musicMgr isPlaying];
    }
}

- (void)updateControlCellTimeDisplay {
    MusicMgr *musicMgr = [MusicMgr standard];
    
    NSInteger musicDurationSecond = musicMgr.durationSeconds;
    NSInteger musicDurationMinute = musicDurationSecond / 60;
    
    NSInteger musicPlaySecond = musicMgr.currentPlayedSeconds;
    NSInteger musicPlayMinute = musicPlaySecond / 60;
    
    _controlCell.playTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", musicPlayMinute, (musicPlaySecond % 60)];
    _controlCell.slider.value = musicMgr.currentPlayedPostion;
    _controlCell.durationTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", musicDurationMinute, (musicDurationSecond % 60)];
}

- (void)startMusicTimeRead {
    uint64_t interval = NSEC_PER_SEC;
    dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, 0), interval, 0);
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateControlCellTimeDisplay];
        });
    });
    dispatch_resume(_timer);
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    HXAlbumsRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    switch (rowType) {
        case HXAlbumsRowTypeControl: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXAlbumsControlCell class]) forIndexPath:indexPath];
            _controlCell = (HXAlbumsControlCell *)cell;
            break;
        }
        case HXAlbumsRowTypeSong: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXAlbumsSongCell class]) forIndexPath:indexPath];
            break;
        }
        case HXAlbumsRowTypeCommentCount: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXAlbumsCommentCountCell class]) forIndexPath:indexPath];
            break;
        }
        case HXAlbumsRowTypeComment: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXAlbumsCommentCell class]) forIndexPath:indexPath];
            break;
        }
    }
    return cell;
}

#pragma mark - Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0f;
    HXAlbumsRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    switch (rowType) {
        case HXAlbumsRowTypeControl: {
            height = _viewModel.controlHeight;
            break;
        }
        case HXAlbumsRowTypeSong: {
            height = _viewModel.songHeight;
            break;
        }
        case HXAlbumsRowTypeCommentCount: {
            height = _viewModel.promptHeight;
            break;
        }
        case HXAlbumsRowTypeComment: {
            height = 70.0f;
            height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([HXAlbumsCommentCell class]) cacheByIndexPath:indexPath configuration:^(HXAlbumsCommentCell *cell) {
                [(HXAlbumsCommentCell *)cell updateCellWithComment:_viewModel.comments[indexPath.row - _viewModel.commentStartIndex]];
            }];
            break;
        }
    }
    return height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    HXAlbumsRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    switch (rowType) {
        case HXAlbumsRowTypeControl: {
            [(HXAlbumsControlCell *)cell updateCellWithAlbum:_viewModel.model];
            break;
        }
        case HXAlbumsRowTypeSong: {
            NSInteger index = indexPath.row - _viewModel.songStartIndex;
            [(HXAlbumsSongCell *)cell updateCellWithSong:_viewModel.songs[index] index:index];
            break;
        }
        case HXAlbumsRowTypeCommentCount: {
            ((HXAlbumsCommentCountCell *)cell).countLabel.text = @(_viewModel.comments.count).stringValue;
            break;
        }
        case HXAlbumsRowTypeComment: {
            [(HXAlbumsCommentCell *)cell updateCellWithComment:_viewModel.comments[indexPath.row - _viewModel.commentStartIndex]];
            break;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HXAlbumsRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    switch (rowType) {
        case HXAlbumsRowTypeSong: {
            [self startMusicTimeRead];
            if (_delegate && [_delegate respondsToSelector:@selector(container:selectedSong:)]) {
                [_delegate container:self selectedSong:_viewModel.songs[indexPath.row - _viewModel.songStartIndex]];
            }
            break;
        }
        case HXAlbumsRowTypeComment: {
            if (_delegate && [_delegate respondsToSelector:@selector(container:selectedComment:)]) {
                [_delegate container:self selectedComment:_viewModel.comments[indexPath.row - _viewModel.commentStartIndex]];
            }
            break;
        }
        default: {
            break;
        }
    }
}

#pragma mark - HXAlbumsControlCellDelegate Methods
- (void)controlCell:(HXAlbumsControlCell *)cell takeAction:(HXAlbumsControlCellAction)cellAction {
    HXAlbumsAction action;
    switch (cellAction) {
        case HXAlbumsControlCellActionPlay: {
            action = HXAlbumsActionPlay;
            [self startMusicTimeRead];
            break;
        }
        case HXAlbumsControlCellActionPause: {
            action = HXAlbumsActionPause;
            break;
        }
        case HXAlbumsControlCellActionPrevious: {
            action = HXAlbumsActionPrevious;
            break;
        }
        case HXAlbumsControlCellActionNext: {
            action = HXAlbumsActionNext;
            break;
        }
    }
    if (_delegate && [_delegate respondsToSelector:@selector(container:takeAction:)]) {
        [_delegate container:self takeAction:action];
    }
}

@end
