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
    BLOCK _reportBlock;
    BLOCK _showProfileBlock;
    BLOCK _attentionBlock;
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
}

- (IBAction)showProfileButtonPressed {
    if (_showProfileBlock) {
        _showProfileBlock(_watcher);
    }
}

- (IBAction)attentionButtonPressed {
    if (_attentionBlock) {
        _attentionBlock(_watcher);
    }
}

- (IBAction)gagedButtonPressed {
    if (_gagedBlock) {
        _gagedBlock(_watcher);
    }
}

- (IBAction)closeButtonPressed {
    [self dismiss];
    
    if (_closedBlock) {
        _closedBlock();
    }
}

#pragma mark - Public Methods
+ (instancetype)showWithWatcher:(HXWatcherModel *)watcher {
    return [HXLiveUserBoard showWithWatcher:watcher report:nil showProfile:nil attention:nil gaged:nil closed:nil];
}

+ (instancetype)showWithWatcher:(HXWatcherModel *)watcher closed:(void(^)(void))closed {
    return [HXLiveUserBoard showWithWatcher:watcher report:nil showProfile:nil attention:nil gaged:nil closed:closed];
}

+ (instancetype)showWithWatcher:(HXWatcherModel *)watcher gaged:(void(^)(HXWatcherModel *watcher))gaged closed:(void(^)(void))closed {
    return [HXLiveUserBoard showWithWatcher:watcher report:nil showProfile:nil attention:nil gaged:gaged closed:closed];
}

+ (instancetype)showWithWatcher:(HXWatcherModel *)watcher report:(void(^)(HXWatcherModel *watcher))report showProfile:(void(^)(HXWatcherModel *watcher))showProfile attention:(void(^)(HXWatcherModel *watcher))attention gaged:(void(^)(HXWatcherModel *watcher))gaged closed:(void(^)(void))closed {
    HXLiveUserBoard *board = [[[NSBundle mainBundle] loadNibNamed:@"HXLiveUserBoard" owner:self options:nil] firstObject];
    [board updateWithWatcher:watcher];
    [board showBoard];
    board->_reportBlock      = report;
    board->_showProfileBlock = showProfile;
    board->_attentionBlock   = attention;
    board->_gagedBlock       = gaged;
    board->_closedBlock      = closed;
    board.reportButton.hidden = !report;
    board.controlContainer.hidden = !(showProfile && attention);
    board.gagedButton.hidden = !gaged;
    return board;
}

- (void)dismiss {
    [UIView animateWithDuration:0.2f animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
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


@end
