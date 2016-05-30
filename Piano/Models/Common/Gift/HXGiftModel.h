//
//  HXGiftModel.h
//  Piano
//
//  Created by miaios on 16/5/19.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"


typedef NS_ENUM(NSUInteger, HXGiftType) {
    HXGiftTypeStatic = 1,
    HXGiftTypeDynamic = 2,
};


@interface HXGiftModel : NSObject

@property (nonatomic, assign)      NSInteger  mcoin;
@property (nonatomic, assign)     HXGiftType  type;
@property (nonatomic, assign) NSTimeInterval  playTime;

@property (nonatomic, strong)  NSString *ID;
@property (nonatomic, strong)  NSString *name;
@property (nonatomic, strong)  NSString *prompt;
@property (nonatomic, strong)  NSString *iconUrl;
@property (nonatomic, strong)  NSString *animateUrl;

@property (nonatomic, strong)  NSString *nickName;
@property (nonatomic, strong)  NSString *avatarUrl;

@property (nonatomic, assign)      BOOL  selected;
@property (nonatomic, assign)      BOOL  status;
@property (nonatomic, assign) NSInteger  count;

@property (nonatomic, strong) NSData *iconData;
@property (nonatomic, strong) NSData *animationData;

- (void)download:(void(^)(HXGiftModel *gift))completed;

@end
