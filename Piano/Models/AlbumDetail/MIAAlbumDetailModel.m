//
//  MIAAlbumDetailModel.m
//  Piano
//
//  Created by 刘维 on 16/5/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAAlbumDetailModel.h"

@implementation MIAAlbumDetailModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"song": @"MIASongModel",
             @"commentList": @"MIACommentModel"};
}

@end
