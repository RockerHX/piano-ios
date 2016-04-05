//
//  HXSongModel.h
//  Piano
//
//  Created by miaios on 16/4/5.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"


@interface HXSongModel : NSObject

@property(nonatomic, assign) NSInteger  duration;

@property(nonatomic, strong)  NSString *ID;
@property(nonatomic, strong)  NSString *uID;
@property(nonatomic, strong)  NSString *albumID;
@property(nonatomic, strong)  NSString *nickName;
@property(nonatomic, strong)  NSString *title;
@property(nonatomic, strong)  NSString *summary;
@property(nonatomic, strong)  NSString *coverUrl;
@property(nonatomic, strong)  NSString *mp3Url;

@end
