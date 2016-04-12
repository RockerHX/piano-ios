//
//  SongPreloader.h
//  mia
//
//  Created by linyehui on 2015/09/08.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HXSongModel;
@class SongPreloader;

@protocol SongPreloaderDelegate <NSObject>

- (BOOL)songPreloaderIsPlayerLoadedThisUrl:(NSString *)url;

@end


@interface SongPreloader : NSObject

@property (nonatomic, weak)            id  <SongPreloaderDelegate>delegate;
@property (strong, nonatomic) HXSongModel *currentItem;

- (void)preloadWithItem:(HXSongModel *)item;
- (void)stop;

@end
