//
//  HXProfileViewModel.h
//  Piano
//
//  Created by miaios on 16/3/30.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "ReactiveCocoa.h"


typedef NS_ENUM(NSUInteger, HXProfileRowType) {
    HXProfileRowTypeHeader,
    HXProfileRowTypeLiving,
    HXProfileRowTypeAlbumPrompt,
    HXProfileRowTypeAlbumContainer,
    HXProfileRowTypeVedioPrompt,
    HXProfileRowTypeVedioContainer,
    HXProfileRowTypeReplayPrompt,
    HXProfileRowTypeReplayContainer,
};


@interface HXProfileViewModel : NSObject

@property (nonatomic, strong, readonly) RACCommand *fetchCommand;

@property (nonatomic, assign, readonly)   CGFloat  headerHeight;
@property (nonatomic, assign, readonly)   CGFloat  livingHeight;
@property (nonatomic, assign, readonly)   CGFloat  albumHeight;
@property (nonatomic, assign, readonly)   CGFloat  vedioHeight;
@property (nonatomic, assign, readonly)   CGFloat  replayHeight;

@property (nonatomic, assign, readonly) NSInteger  rows;
@property (nonatomic, strong, readonly)   NSArray *rowTypes;

@property (nonatomic, strong, readonly) NSArray *albums;
@property (nonatomic, strong, readonly) NSArray *videos;
@property (nonatomic, strong, readonly) NSArray *replays;

@property (nonatomic, strong, readonly) NSString *uid;

- (instancetype)initWithUID:(NSString *)UID;

@end
