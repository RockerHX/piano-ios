//
//  HXLiveEndViewController.m
//  Piano
//
//  Created by miaios on 16/3/30.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveEndViewController.h"
#import "FXBlurView.h"
#import "HXUserSession.h"
#import "UIImageView+WebCache.h"
#import "HXLiveModel.h"
#import "MiaAPIHelper.h"


@interface HXLiveEndViewController ()
@end


@implementation HXLiveEndViewController

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameLive;
}

#pragma mark - Status Bar
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    [MiaAPIHelper getRoomStat:_liveModel.roomID completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            NSDictionary *data = userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
            _totalViewCountLabel.text = @([data[@"viewCnt"] integerValue]).stringValue;
            _appendFansCountLabel.text = @([data[@"newFansCnt"] integerValue]).stringValue;
            _appendMCurrencyCountLabel.text = @([data[@"newMcoinsCnt"] integerValue]).stringValue;
        }
    } timeoutBlock:nil];
    
    _countContainerView.hidden = !_isAnchor;
}

- (void)viewConfigure {
    _blurView.contentMode = UIViewContentModeScaleAspectFill;
    _containerView.backgroundColor = [UIColor clearColor];
    
    [self updateUI];
}

#pragma mark - Event Methods
- (IBAction)backButtonPressed {
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    if (_delegate && [_delegate respondsToSelector:@selector(endViewControllerWouldLikeExitRoom:)]) {
        [_delegate endViewControllerWouldLikeExitRoom:self];
    }
}

#pragma mark - Private Methods
- (void)updateUI {
    __weak __typeof__(self)weakSelf = self;
    [_avatar sd_setImageWithURL:[NSURL URLWithString:(_isAnchor ? [HXUserSession session].user.avatarUrl : _liveModel.avatarUrl)] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        __strong __typeof__(self)strongSelf = weakSelf;
        strongSelf.blurView.image = [image blurredImageWithRadius:10.0f iterations:10 tintColor:[UIColor blackColor]];;
    }];
    _nickNameLabel.text = (_isAnchor ? [HXUserSession session].nickName : _liveModel.nickName);
}

@end
