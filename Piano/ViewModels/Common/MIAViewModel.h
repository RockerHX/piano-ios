//
//  MIAViewModel.h
//  Piano
//
//  Created by 刘维 on 16/5/9.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "ReactiveCocoa.h"
#import "MiaAPIHelper.h"

@interface MIAViewModel : NSObject

@property (nonatomic, strong) RACCommand *fetchCommand;

- (void)initConfigure;

@end
