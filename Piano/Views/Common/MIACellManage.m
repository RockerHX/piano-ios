//
//  MIACellManage.m
//  Piano
//
//  Created by 刘维 on 16/5/9.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIACellManage.h"

@implementation MIACellManage

+ (MIABaseTableViewCell *)getCellWithType:(MIACellType)type{

    MIABaseTableViewCell *cell = nil;
    
    if (type == MIACellTypeLive) {
        return [MIACellManage createCellWithClass:[MIAProfileLiveCell class]];
//        cell = [[MIAProfileLiveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"profileLiveCell"];
    }else if(type == MIACellTypeAlbum){
       return [MIACellManage createCellWithClass:[MIAProfileAlbumCell class]];
//        cell = [[MIAProfileAlbumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"profileAlbumCell"];
    }else if (type == MIACellTypeVideo){
        return [MIACellManage createCellWithClass:[MIAProfileVideoCell class]];
//        cell = [[MIAProfileVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"profileVideoCell"];
    }else if (type == MIACellTypeReplay){
        return [MIACellManage createCellWithClass:[MIAProfileReplayCell class]];
//        cell = [[MIAProfileReplayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"profileReplayCell"];
    }
    
    if (type == MIACellTypeNormal) {
        return [MIACellManage createCellWithClass:[MIABaseTableViewCell class]];
    }
    
    return cell;
}

+ (MIABaseTableViewCell *)createCellWithClass:(Class)class{

    return [[class alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(class)];
}

@end
