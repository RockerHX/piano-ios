//
//  HXWatcherBoard.m
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXWatcherBoard.h"
#import "AppDelegate.h"

typedef void(^BLOCK)(void);

@implementation HXWatcherBoard {
    BLOCK _closedBlock;
    BLOCK _gagedBlock;
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
+ (instancetype)show {
    HXWatcherBoard *board = [[[NSBundle mainBundle] loadNibNamed:@"HXWatcherBoard" owner:self options:nil] firstObject];
    [board showBoard];
    return board;
}

+ (instancetype)showWithWatcher:(id)watcher closed:(void(^)(void))closed {
    HXWatcherBoard *board = [HXWatcherBoard show];
    board.gagButton.hidden = YES;
    board->_closedBlock = closed;
    [board updateWithWatcher:watcher];
    return board;
}

+ (instancetype)showWithWatcher:(id)watcher gaged:(void(^)(void))gaged closed:(void(^)(void))closed {
    HXWatcherBoard *board = [HXWatcherBoard show];
    board.signatureLabel.hidden = YES;
    board->_gagedBlock = gaged;
    board->_closedBlock = closed;
    [board updateWithWatcher:watcher];
    return board;
}

#pragma mark - Private Methods
- (void)showBoard {
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    UIWindow *mainWindow = delegate.window;
    self.frame = mainWindow.frame;
    [mainWindow addSubview:self];
}

- (void)updateWithWatcher:(id)watcher {
    ;
}

- (void)dismiss {
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
