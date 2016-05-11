//
//  NSArray+JOExtend.h
//  Piano
//
//  Created by 刘维 on 16/5/9.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray(Extend)

/**
 *  将一个数组按给定的的值拆分成一个二维数组,每个数组里面的数量为给定的值
 *  e.g:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"] 按3拆分后为 @[@[@"1",@"2",@"3"],@[@"4",@"5",@"6"],@[@"7"]]
 *
 *  @param number 需要给定数量的拆分的值
 *
 *  @return 新生成的数组.
 */
- (NSMutableArray *)JOSeparateArrayWithNumber:(NSInteger)number;

@end
