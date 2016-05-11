//
//  MIAAlbumDetailView.h
//  Piano
//
//  Created by 刘维 on 16/5/11.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AlbumDetailType) {

    AlbumDetailTypeNoReward, //进入未打赏过的专辑详情页
    AlbumDetailTypeReward, //进入已打赏过的专辑详情页
};

@interface MIAAlbumDetailView : UIView

- (CGFloat)albumDetailViewHeight;

@end
