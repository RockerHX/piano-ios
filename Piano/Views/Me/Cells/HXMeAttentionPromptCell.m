//
//  HXMeAttentionPromptCell.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMeAttentionPromptCell.h"


@implementation HXMeAttentionPromptCell

#pragma mark - Public Methods
- (void)updateCellWithCount:(NSInteger)count {
    _countLabel.text = @(count).stringValue;
}

@end
