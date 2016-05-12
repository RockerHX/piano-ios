//
//  MIAVideoModel.h
//  Piano
//
//  Created by 刘维 on 16/5/9.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"

@interface MIAVideoModel : NSObject

@property (nonatomic, copy) NSString *title; //视频的标题
@property (nonatomic, copy) NSString *videoUrl; //视频的地址
@property (nonatomic, copy) NSString *viewCnt; //视频观看的数量
@property (nonatomic, copy) NSString *coverUrl; //展示图片的地址
@property (nonatomic, copy) NSString *addtime;//时间
@property (nonatomic, copy) NSString *coverID;//
@property (nonatomic, copy) NSString *fileID;//
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *summary;//

@end
