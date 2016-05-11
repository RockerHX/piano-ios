//
//  JOFunctionObject.h
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/10/23.
//  Copyright © 2015年 刘维. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JOMacro.h"

@protocol FunctionObject
@end

@interface JOFunctionObject : NSObject<FunctionObject>

@property (nonatomic, copy) NSString *functionDescription;

@end
