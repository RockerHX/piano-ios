//
//  HXDiscoveryPreviewCell.m
//  Piano
//
//  Created by miaios on 16/5/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDiscoveryPreviewCell.h"
#import "HXDownLoadCache.h"
#import <AVFoundation/AVFoundation.h>


@implementation HXDiscoveryPreviewCell {
    AVPlayer *_player;
    AVPlayerLayer *_previewLayer;
}

#pragma mark - Load Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self loadConfigure];
    [self viewConfigure];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _previewLayer.frame = self.bounds;
}

#pragma mark - Configure Methods
- (void)loadConfigure {
}

- (void)viewConfigure {
    _previewLayer = [AVPlayerLayer new];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _previewLayer.frame = self.bounds;
    [self.previewView.layer addSublayer:_previewLayer];
}

#pragma mark - Public Methods
- (void)playWithURL:(NSString *)url {
    NSURL *downLoadURL = [NSURL URLWithString:url];
    [[HXDownLoadCache cache] downLoadWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self startPlayWithURL:downLoadURL data:data];
    }];
}

#pragma mark - Private Methods
- (void)startPlayWithURL:(NSURL *)url data:(NSData *)data {
    NSString *fileName = [url.absoluteString lastPathComponent];
    NSString *tempDirectory = NSTemporaryDirectory();
    NSString *filePath = [tempDirectory stringByAppendingFormat:@"/%@", fileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [data writeToFile:filePath atomically:YES];
    }
    
    NSURL *videoURL = [NSURL fileURLWithPath:filePath];
    _player = [AVPlayer playerWithURL:videoURL];
    _previewLayer.player = _player;
    [_player play];
    _previewView.hidden = NO;
}

- (void)stopPlay {
    _previewView.hidden = YES;
    [_player pause];
    _player = nil;
}

@end
