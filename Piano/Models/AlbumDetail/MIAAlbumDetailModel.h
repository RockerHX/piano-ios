//
//  MIAAlbumDetailModel.h
//  Piano
//
//  Created by 刘维 on 16/5/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAAlbumModel.h"
#import "HXSongModel.h"
#import "MIACommentModel.h"

@interface MIAAlbumDetailModel : NSObject

@property (nonatomic, strong) MIAAlbumModel *album;
@property (nonatomic, strong) NSArray<HXSongModel *> *song;
@property (nonatomic, strong) NSArray<MIACommentModel *> *commentList;
@property (nonatomic, copy) NSString *commentsCnt;

@end
