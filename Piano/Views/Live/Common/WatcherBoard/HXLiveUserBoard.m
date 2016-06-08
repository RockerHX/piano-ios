//
//  HXLiveUserBoard.m
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveUserBoard.h"
#import "UIImageView+WebCache.h"


typedef void(^BLOCK)(HXWatcherModel *watcher);
typedef void(^VOID_BLOCK)(void);


@implementation HXLiveUserBoard {
    BLOCK _showProfileBlock;
    BLOCK _reportBlock;
    BLOCK _gagedBlock;
    VOID_BLOCK _closedBlock;
    
    HXWatcherModel *_watcher;
}

#pragma mark - Load Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    ;
}

- (void)viewConfigure {
    _summaryContainer.layer.cornerRadius = 4.0f;
    _summaryContainer.layer.shadowColor = [UIColor blackColor].CGColor;
    _summaryContainer.layer.shadowOpacity = 1.0f;
    _summaryContainer.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
}

#pragma mark - Event Response
- (IBAction)reportButtonPressed {
    if (_reportBlock) {
        _reportBlock(_watcher);
    }
    [self dismiss];
}

- (IBAction)showProfileButtonPressed {
    if (_showProfileBlock) {
        _showProfileBlock(_watcher);
    }
    [self dismiss];
}

- (IBAction)gagedButtonPressed {
    if (_gagedBlock) {
        _gagedBlock(_watcher);
    }
    [self dismiss];
}

- (IBAction)closeButtonPressed {
    if (_closedBlock) {
        _closedBlock();
    }
    [self dismiss];
}

#pragma mark - Public Methods
+ (instancetype)showWithWatcher:(HXWatcherModel *)watcher {
    return [HXLiveUserBoard showWithWatcher:watcher showProfile:nil report:nil gaged:nil closed:nil];
}

+ (instancetype)showWithWatcher:(HXWatcherModel *)watcher closed:(void(^)(void))closed {
    return [HXLiveUserBoard showWithWatcher:watcher showProfile:nil report:nil gaged:nil closed:closed];
}

+ (instancetype)showWithWatcher:(HXWatcherModel *)watcher gaged:(void(^)(HXWatcherModel *watcher))gaged closed:(void(^)(void))closed {
    return [HXLiveUserBoard showWithWatcher:watcher showProfile:nil report:nil gaged:gaged closed:closed];
}

+ (instancetype)showWithWatcher:(HXWatcherModel *)watcher showProfile:(void(^)(HXWatcherModel *))showProfile report:(void(^)(HXWatcherModel *))report gaged:(void(^)(HXWatcherModel *))gaged closed:(void(^)(void))closed {
    HXLiveUserBoard *board = [[[NSBundle mainBundle] loadNibNamed:@"HXLiveUserBoard" owner:self options:nil] firstObject];
    [board updateWithWatcher:watcher];
    [board showBoard];
    board->_showProfileBlock = showProfile;
    board->_reportBlock      = report;
    board->_gagedBlock       = gaged;
    board->_closedBlock      = closed;
    board.controlContainer.hidden = !(showProfile && report);
    [board.gagedButton setTitle:((report && gaged) ? @"举报" : @"禁言") forState:UIControlStateNormal];
    return board;
}

#pragma mark - Private Methods
- (void)showBoard {
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    self.frame = mainWindow.frame;
    [mainWindow addSubview:self];
}

- (void)updateWithWatcher:(HXWatcherModel *)watcher {
    _watcher = watcher;
    
    [_avatar sd_setImageWithURL:[NSURL URLWithString:watcher.avatarUrl]];
    _nickNameLabel.text = watcher.nickName;
    _signatureLabel.text = watcher.signature;
}

- (void)dismiss {
    [UIView animateWithDuration:0.2f animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
