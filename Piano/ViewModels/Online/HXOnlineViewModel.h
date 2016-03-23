//
//  HXOnlineViewModel.h
//  Piano
//
//  Created by miaios on 16/3/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "ReactiveCocoa.h"
#import "HXOnlineCell.h"


@interface HXOnlineViewModel : NSObject

@property (nonatomic, assign, readonly) CGFloat  cellHeight;

@property (nonatomic, strong, readonly) RACCommand *requestCommand;

@property (nonatomic, strong, readonly) NSArray *onlineList;

@end
