//
//  HXWatcherBoard.m
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXWatcherBoard.h"
#import "AppDelegate.h"
#import "HXWatcherModel.h"
#import "UIImageView+WebCache.h"

typedef void(^BLOCK)(void);

@implementation HXWatcherBoard {
    BLOCK _closedBlock;
    BLOCK _gagedBlock;
    
    HXWatcherModel *_watcher;
}

#pragma mark - Initialize Methods
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfigure];
        [self viewConfigure];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initConfigure];
        [self viewConfigure];
    }
    return self;
}

#pragma mark - Configure Methods
- (void)initConfigure {
    ;
}

- (void)viewConfigure {
    ;
}

#pragma mark - Event Response
- (IBAction)closeButtonPressed {
    [self dismiss];
    
    if (_closedBlock) {
        _closedBlock();
    }
}

- (IBAction)gagButtonPressed {
    if (_gagedBlock) {
        _gagedBlock();
    }
}

#pragma mark - Public Methods
+ (instancetype)showWithWatcher:(HXWatcherModel *)watcher {
    HXWatcherBoard *board = [[[NSBundle mainBundle] loadNibNamed:@"HXWatcherBoard" owner:self options:nil] firstObject];
    [board updateWithWatcher:watcher];
    [board showBoard];
    return board;
}

+ (instancetype)showWithWatcher:(HXWatcherModel *)watcher closed:(void(^)(void))closed {
    HXWatcherBoard *board = [self showWithWatcher:watcher gaged:nil closed:closed];
    board.gagButton.hidden = YES;
    board.signatureLabel.hidden = NO;
    return board;
}

+ (instancetype)showWithWatcher:(HXWatcherModel *)watcher gaged:(void(^)(void))gaged closed:(void(^)(void))closed {
    HXWatcherBoard *board = [HXWatcherBoard showWithWatcher:watcher];
    board.gagButton.hidden = NO;
    board.signatureLabel.hidden = YES;
    board->_gagedBlock = gaged;
    board->_closedBlock = closed;
    return board;
}

#pragma mark - Private Methods
- (void)showBoard {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *mainWindow = delegate.window;
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
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
