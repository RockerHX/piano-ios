//
//  SongPreloader.h
//  mia
//
//  Created by linyehui on 2015/09/08.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MusicItem;
@class SongPreloader;

@protocol SongPreloaderDelegate <NSObject>

- (BOOL)songPreloaderIsPlayerLoadedThisUrl:(NSString *)url;

@end


@interface SongPreloader : NSObject

@property (nonatomic, weak) id <SongPreloaderDelegate> delegate;
@property (strong, nonatomic) MusicItem * currentItem;

- (void)preloadWithMusicItem:(MusicItem *)item;
- (void)stop;

@end
