//
//  MIAAlbumViewController.h
//  Piano
//
//  Created by 刘维 on 16/5/11.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,MIAAlbumRewardType) {

    MIAAlbumRewardTypeNormal,//从普通的专辑页面进入的类型
    MIAAlbumRewardTypeMyReward,//从我打赏过的专辑进入的类型
};

@interface MIAAlbumViewController : UIViewController

@property (nonatomic, copy) NSString *albumUID;//专辑的ID
@property (nonatomic, assign) MIAAlbumRewardType rewardType; //打赏的状态

@end
