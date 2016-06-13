//
//  MIAHostProfileModel.m
//  Piano
//
//  Created by 刘维 on 16/6/13.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAHostProfileModel.h"

@implementation HostProfileFollowModel

@end

@implementation HostMusicAlbumModel

@end

@implementation MIAHostProfileModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"followList": @"HostProfileFollowModel",
             @"musicAlbum": @"HostMusicAlbumModel"};
}

@end
