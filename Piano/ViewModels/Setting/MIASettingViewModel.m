//
//  MIASettingViewModel.m
//  Piano
//
//  Created by 刘维 on 16/5/26.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIASettingViewModel.h"
#import "JOBaseSDK.h"
#import "CacheHelper.h"
#import "HXUserSession.h"
#import "UserSetting.h"

CGFloat const kSettingDefaultCellHeight = 56.;
CGFloat const kSettingHeadImageCellHeight = 61.;
CGFloat const kSettingHeadImageHeight = 36.;

@interface MIASettingViewModel()

@property (nonatomic, copy) ContentDataUpdateBlock contentDataUpdateBlock;

@end

@implementation MIASettingViewModel

- (void)initConfigure{

    [self initTableCellDataArray];
    
    [self checkCacheSize];
}

- (void)initTableCellDataArray{

    _settingCellDataArray = @[@[@"头像",@"昵称",@"签名",@"性别",@"修改密码"],@[@"清除缓存",@"清除下载的歌曲",@"在2G/3G/4G网络下播放"],@[@"意见反馈",@"当前版本",@"退出登录"]];
    
    self.settingCellContentDataArray = [NSMutableArray arrayWithObjects:[NSMutableArray array],[NSMutableArray array],[NSMutableArray array],nil];
    [self loadCellContentDataArray];
}

- (void)checkCacheSize{
    
    [CacheHelper checkCacheSizeWithCompleteBlock:^(unsigned long long cacheSize) {
        float sizeWithMB = cacheSize / 1024 / 1024;
        [[_settingCellContentDataArray objectAtIndex:1] replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%.0f MB", sizeWithMB]];
        [self handlerContentDataUpdate];
    }];
    
    [CacheHelper checkSongCacheSizeWithCompleteBlock:^(unsigned long long cacheSize) {
        float sizeWithMB = cacheSize / 1024 / 1024;
        [[_settingCellContentDataArray objectAtIndex:1] replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%.0f MB", sizeWithMB]];
        [self handlerContentDataUpdate];
    }];
}

- (void)loadCellContentDataArray{

    //头像
    [[_settingCellContentDataArray firstObject] addObject:JOConvertStringToNormalString([HXUserSession session].user.avatarUrl)];
    //昵称
    [[_settingCellContentDataArray firstObject] addObject:JOConvertStringToNormalString([HXUserSession session].user.nickName)];
    //签名
    [[_settingCellContentDataArray firstObject] addObject:JOConvertStringToNormalString([HXUserSession session].user.bio)];
    //性别 1为男性 2为女性
    [[_settingCellContentDataArray firstObject] addObject:JOConvertStringToNormalString([HXUserSession session].user.gender)];
    //修改密码  占位的
    [[_settingCellContentDataArray firstObject] addObject:@""];
    
    //缓存
    [[_settingCellContentDataArray objectAtIndex:1] addObject:@"0M"];
    //歌曲的缓存
    [[_settingCellContentDataArray objectAtIndex:1] addObject:@"0M"];
    //网路播放的状态 占位
    [[_settingCellContentDataArray objectAtIndex:1] addObject:@""];
    
    //意见反馈 占位
    [[_settingCellContentDataArray objectAtIndex:2] addObject:@""];
    //当前版本
    [[_settingCellContentDataArray objectAtIndex:2] addObject:[self version]];
    //退出 占位
    [[_settingCellContentDataArray objectAtIndex:2] addObject:@""];
}

- (NSString *)version{

    NSString *buildVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString *shortVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
   return [NSString stringWithFormat:@"%@.%@", shortVersion, buildVersion];
}

#pragma mark - block

- (void)contentDataUpdateHanlder:(ContentDataUpdateBlock)block{

    self.contentDataUpdateBlock = nil;
    self.contentDataUpdateBlock = block;
}

- (void)handlerContentDataUpdate{

    if (_contentDataUpdateBlock) {
        _contentDataUpdateBlock();
    }
}

#pragma mark - update

- (void)updateNickName:(NSString *)nickName{

    [HXUserSession session].user.nickName = nickName;
    [[HXUserSession session] sysnc];
    
    [[_settingCellContentDataArray firstObject] replaceObjectAtIndex:1 withObject:[HXUserSession session].user.nickName];
    [self handlerContentDataUpdate];
}

- (void)updateAvtarURLString:(NSString *)urlString{

    [HXUserSession session].user.avatarUrl = urlString;
    [[HXUserSession session] sysnc];
    
    [[_settingCellContentDataArray firstObject] replaceObjectAtIndex:0 withObject:[HXUserSession session].user.avatarUrl];
    [self handlerContentDataUpdate];
}

- (void)updateSummay:(NSString *)summary{

    [HXUserSession session].user.bio = summary;
    [[HXUserSession session] sysnc];
    
    [[_settingCellContentDataArray firstObject] replaceObjectAtIndex:2 withObject:[HXUserSession session].user.bio];
    [self handlerContentDataUpdate];
}

- (void)updateGender:(NSString *)gender{

    [HXUserSession session].user.gender = gender;
    [[HXUserSession session] sysnc];
    
    [[_settingCellContentDataArray firstObject] replaceObjectAtIndex:3 withObject:[HXUserSession session].user.gender];
    [self handlerContentDataUpdate];
}
- (void)updateCache{

    [[_settingCellContentDataArray objectAtIndex:1] replaceObjectAtIndex:0 withObject:@"缓存已清除"];
    [self handlerContentDataUpdate];
}
- (void)updateSongCache{
    [[_settingCellContentDataArray objectAtIndex:1] replaceObjectAtIndex:1 withObject:@"下载的歌曲已清除"];
    [self handlerContentDataUpdate];
}

@end
