//
//  HXMeViewModel.h
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, HXMeRowType) {
    HXMeRowTypeHeader,
//    HXMeRowType,
//    HXMeRowType,
};


@interface HXMeViewModel : NSObject

@property (nonatomic, assign, readonly) NSInteger  rows;

@property (nonatomic, strong, readonly)   NSArray *rowTypes;

@end
