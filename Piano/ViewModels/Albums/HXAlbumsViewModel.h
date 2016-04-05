//
//  HXAlbumsViewModel.h
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "ReactiveCocoa.h"
#import "UITableView+FDTemplateLayoutCell.h"


typedef NS_ENUM(NSUInteger, HXAlbumsRowType) {
    HXAlbumsRowTypeControl,
    HXAlbumsRowTypeSong,
    HXAlbumsRowTypeCommentCount,
    HXAlbumsRowTypeComment,
};


@interface HXAlbumsViewModel : NSObject

@property (nonatomic, strong, readonly)   NSString *albumID;
@property (nonatomic, strong, readonly) RACCommand *fetchCommand;

@property (nonatomic, assign, readonly)    CGFloat  controlHeight;
@property (nonatomic, assign, readonly)    CGFloat  songHeight;
@property (nonatomic, assign, readonly)    CGFloat  promptHeight;

@property (nonatomic, assign, readonly)  NSInteger  songStartIndex;
@property (nonatomic, assign, readonly)  NSInteger  commentStartIndex;

@property (nonatomic, assign, readonly)  NSInteger  rows;
@property (nonatomic, strong, readonly)    NSArray *rowTypes;

- (instancetype)initWithAlbumID:(NSString *)albumID;

@end
