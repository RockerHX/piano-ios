//
//  HXAlbumsViewModel.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXAlbumsViewModel.h"
#import "UIConstants.h"


@implementation HXAlbumsViewModel

#pragma mark - Initialize Methods
- (instancetype)init {
    self = [super init];
    if (self) {
        ;
    }
    return self;
}

#pragma mark - Configure Methods
- (void)initConfigure {
    _songStartIndex = 1;
}

#pragma mark - Property
- (CGFloat)controlHeight {
    return SCREEN_WIDTH - 10.0f - 15.0f + 61.0f;
}

- (CGFloat)songHeight {
    return 50.0f;
}

- (CGFloat)promptHeight {
    return 50.0f;
}

- (NSInteger)rows {
    return _rowTypes.count;
}

@end
