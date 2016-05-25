//
//  HXLiveBarrageCell.m
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveBarrageCell.h"
#import "UIConstants.h"


@implementation HXLiveBarrageCell

#pragma mark - Load Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    ;
}

- (void)viewConfigure {
    ;
}

#pragma mark - Public Methods
- (void)updateWithBarrage:(HXBarrageModel *)barrage {
    _contentLabel.text = barrage.prompt;
}

@end
