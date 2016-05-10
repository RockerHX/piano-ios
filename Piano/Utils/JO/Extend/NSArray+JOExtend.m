//
//  NSArray+JOExtend.m
//  Piano
//
//  Created by 刘维 on 16/5/9.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "NSArray+JOExtend.h"

@implementation NSArray(Extend)

- (NSMutableArray *)JOSeparateArrayWithNumber:(NSInteger)number{

    NSMutableArray *separateArray = [NSMutableArray array];    
    NSMutableArray *tempArray = [NSMutableArray array];

    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx%number == 0 && idx != 0) {
            [separateArray addObject:[tempArray mutableCopy]];
            [tempArray removeAllObjects];
        }
        [tempArray addObject:obj];
    }];
    
    [separateArray addObject:tempArray];
    
    return separateArray;
}

@end
