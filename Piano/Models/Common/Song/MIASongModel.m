//
//  MIASongModel.m
//  Piano
//
//  Created by 刘维 on 16/5/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIASongModel.h"

@implementation MIASongModel

- (void)mj_keyValuesDidFinishConvertingToObject {
    NSInteger second = [_duration doubleValue] / 1000;
    NSInteger minute = second / 60;
    _songTime = [NSString stringWithFormat:@"%02zd:%02zd", minute, (second % 60)];
}

@end
