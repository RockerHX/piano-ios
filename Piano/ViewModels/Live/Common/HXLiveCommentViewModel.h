//
//  HXLiveCommentViewModel.h
//  Piano
//
//  Created by miaios on 16/3/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "ReactiveCocoa.h"


@interface HXLiveCommentViewModel : NSObject

@property (nonatomic, strong, readonly)   NSString *roomID;
@property (nonatomic, strong, readonly)   NSString *content;

@property (nonatomic, strong, readonly) RACCommand *sendCommand;

- (instancetype)initWithRoomID:(NSString *)roomID;

@end
