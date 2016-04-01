//
//  HXVideoModel.h
//  Piano
//
//  Created by miaios on 16/3/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"


@interface HXVideoModel : NSObject

@property (nonatomic, assign) NSInteger  viewCount;

@property (nonatomic, strong)  NSString *title;
@property (nonatomic, strong)  NSString *videoUrl;
@property (nonatomic, strong)  NSString *coverUrl;

@end
