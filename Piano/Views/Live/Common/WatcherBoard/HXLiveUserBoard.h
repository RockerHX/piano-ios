//
//  HXLiveUserBoard.h
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXWatcherModel.h"


@interface HXLiveUserBoard : UIView

@property (weak, nonatomic) IBOutlet      UIView *summaryContainer;
@property (weak, nonatomic) IBOutlet      UIView *controlContainer;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet     UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *signatureLabel;
@property (weak, nonatomic) IBOutlet    UIButton *showProfileButton;
@property (weak, nonatomic) IBOutlet    UIButton *reportButton;
@property (weak, nonatomic) IBOutlet    UIButton *gagedButton;

- (IBAction)showProfileButtonPressed;
- (IBAction)reportButtonPressed;
- (IBAction)gagedButtonPressed;
- (IBAction)closeButtonPressed;

+ (instancetype)showWithWatcher:(HXWatcherModel *)watcher;
+ (instancetype)showWithWatcher:(HXWatcherModel *)watcher closed:(void(^)(void))closed;
+ (instancetype)showWithWatcher:(HXWatcherModel *)watcher gaged:(void(^)(HXWatcherModel *watcher))gaged closed:(void(^)(void))closed;

+ (instancetype)showWithWatcher:(HXWatcherModel *)watcher
                    showProfile:(void(^)(HXWatcherModel *watcher))showProfile
                         report:(void(^)(HXWatcherModel *watcher))report
                          gaged:(void(^)(HXWatcherModel *watcher))gaged
                         closed:(void(^)(void))closed;

@end
