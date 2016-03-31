//
//  MusicItem.h
//  mia
//
//  Created by linyehui on 2015/09/08.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//

#include <Foundation/Foundation.h>

extern NSString * const kDefaultMusicID;

@interface MusicItem : NSObject <NSCoding, NSCopying>

@property (strong, nonatomic) NSString *mid;
@property (strong, nonatomic) NSString *singerID;
@property (strong, nonatomic) NSString *singerName;
@property (strong, nonatomic) NSString *albumName;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *purl;
@property (strong, nonatomic) NSString *murl;
@property (strong, nonatomic) NSString *flag;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
