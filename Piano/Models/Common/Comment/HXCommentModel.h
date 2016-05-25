//
//  HXCommentModel.h
//  Piano
//
//  Created by miaios on 16/3/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"


@interface HXCommentModel : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *uID;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *content;

@property (nonatomic, assign)     BOOL  backAlbum;
@property (nonatomic, assign)     BOOL  backGift;

@property (nonatomic, assign) NSInteger  createDate;
@property (nonatomic, strong)  NSString *date;

@end
