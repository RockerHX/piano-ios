//
//  MIAProfileViewModel.m
//  Piano
//
//  Created by 刘维 on 16/5/9.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAProfileViewModel.h"

CGFloat const kProfileHeadViewHeight = 500.;

@implementation MIAProfileViewModel

- (instancetype)initWithUID:(NSString *)uid{

    self = [super init];
    if (self) {
        _uid = uid;
    }
    return self;
}

- (void)initConfigure{

    
}

@end
