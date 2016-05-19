//
//  HXLiveAlbumView.m
//  Piano
//
//  Created by miaios on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveAlbumView.h"
#import "HXXib.h"
#import "BlocksKit+UIKit.h"
#import "UIImageView+WebCache.h"
#import "FXBlurView.h"
#import "HXAlbumModel.h"


@implementation HXLiveAlbumView {
    BOOL _front;
    
    NSTimer *_timer;
}

HXXibImplementation

#pragma mark - Load Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    __weak __typeof__(self)weakSelf = self;
    [self bk_whenTapped:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(liveAlbumsViewTaped:)]) {
            [strongSelf.delegate liveAlbumsViewTaped:strongSelf];
        }
    }];
}

- (void)viewConfigure {
    ;
}

#pragma mark - Property
- (void)setCoverUrl:(NSString *)coverUrl {
    _coverUrl = coverUrl;
    
    __weak __typeof__(self)weakSelf = self;
    [_albumCover sd_setImageWithURL:[NSURL URLWithString:coverUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        __strong __typeof__(self)strongSelf = weakSelf;
        strongSelf.albumCover.image = image;
        strongSelf.blurCover.image = [image blurredImageWithRadius:10.0f iterations:10.0f tintColor:[UIColor blackColor]];
    }];
}

- (void)setCount:(NSInteger)count {
    _count = count;
    _countLabel.text = @(count).stringValue;
}

#pragma mark - Public Methods
- (void)updateWithAlbum:(HXAlbumModel *)album {
    if (album) {
        _countLabel.text = @(album.rewardCount).stringValue;
        __weak __typeof__(self)weakSelf = self;
        [_albumCover sd_setImageWithURL:[NSURL URLWithString:album.coverUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            __strong __typeof__(self)strongSelf = weakSelf;
            [strongSelf coverLoadCompleted];
        }];
    }
}

- (void)stopAlbumAnmation {
    [_timer invalidate];
}

#pragma mark - Private Methods
- (void)coverLoadCompleted {
    _blurCover.image = [_albumCover.image blurredImageWithRadius:30.0f iterations:10 tintColor:[UIColor blackColor]];
    [self startTiming];
}

- (void)startTiming {
    __weak __typeof__(self)weakSelf = self;
    _timer = [NSTimer bk_scheduledTimerWithTimeInterval:3.0f block:^(NSTimer *timer) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf albumAnimation];
    } repeats:YES];
}

- (void)albumAnimation {
    _front = !_front;
    
    UIViewAnimationOptions animationOptions = _front ? UIViewAnimationOptionTransitionFlipFromLeft : UIViewAnimationOptionTransitionFlipFromRight;
    [UIView transitionFromView:(_front ? _coverContainer : _blurContainer)
                        toView:(_front ? _blurContainer : _coverContainer)
                      duration:1.0f
                       options:(animationOptions | UIViewAnimationOptionShowHideTransitionViews)
                    completion:nil];
}

@end
