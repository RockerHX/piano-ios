//
//  LocationMgr.h
//  mia
//
//  Created by linyehui on 2015/10/19.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^LocationDidUpdateBlock)(CLLocationCoordinate2D coordinate, NSString *address);

@interface LocationMgr : NSObject

/**
 *  使用单例初始化
 *
 */
+ (id)standard;

//@property (assign, nonatomic) long currentModelID;
@property (assign, nonatomic) CLLocationCoordinate2D 	currentCoordinate;
@property (copy, nonatomic) NSString					*currentAddress;

- (void)initLocationMgr;
- (void)startUpdatingLocationWithOnceBlock:(LocationDidUpdateBlock) block;

@end
