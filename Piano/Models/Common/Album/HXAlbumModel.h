//
//  HXAlbumModel.h
//  Piano
//
//  Created by miaios on 16/3/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"


@interface HXAlbumModel : NSObject

@property (nonatomic, strong)  NSString *ID;
@property (nonatomic, strong)  NSString *uID;
@property (nonatomic, strong)  NSString *nickName;
@property (nonatomic, strong)  NSString *title;
@property (nonatomic, strong)  NSString *summary;
@property (nonatomic, strong)  NSString *coverUrl;
@property (nonatomic, assign) NSInteger  rewardCount;

@end
