//
//  LocationMgr.m
//  mia
//
//  Created by linyehui on 2015/10/19.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//
//

#import "LocationMgr.h"
#import "NSString+IsNull.h"

@interface LocationMgr() <CLLocationManagerDelegate>

@end

@implementation LocationMgr {
	CLLocationManager 		*_locationManager;
	LocationDidUpdateBlock	_didUpdateBlock;
}

/**
 *  使用单例初始化
 *
 */
+ (id)standard{
    static LocationMgr *aLocationMgr = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        aLocationMgr = [[self alloc] init];
    });
    return aLocationMgr;
}

- (id)init {
	self = [super init];
	if (self) {
	}

	return self;
}

- (void)dealloc {
}

#pragma mark - Public Methods

- (void)initLocationMgr {
	if (nil == _locationManager) {
		_locationManager = [[CLLocationManager alloc] init];
	}

	_locationManager.delegate = self;

	//设置定位的精度
	_locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;

	//设置定位服务更新频率
	_locationManager.distanceFilter = 500;

	if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=8.0) {

		[_locationManager requestWhenInUseAuthorization];	// 前台定位
		//[mylocationManager requestAlwaysAuthorization];	// 前后台同时定位
	}
}

- (void)startUpdatingLocationWithOnceBlock:(LocationDidUpdateBlock) block {
	_didUpdateBlock = [block copy];
	[_locationManager startUpdatingLocation];
}

#pragma mark -private method

#pragma mark - delegate method

// 获取地理位置变化的起始点和终点,didUpdateToLocation：
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {

	CLLocation * earthlocation = [[CLLocation alloc]initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
	//CLLocation *marsLoction = [location locationMarsFromEarth];
	NSLog(@"didUpdateToLocation 当前位置的纬度:%.2f, 经度%.2f", earthlocation.coordinate.latitude, earthlocation.coordinate.longitude);

	CLGeocoder *geocoder = [[CLGeocoder alloc]init];
	[geocoder reverseGeocodeLocation:earthlocation completionHandler:^(NSArray *placemarks,NSError *error) {
		if (placemarks.count > 0) {
			CLPlacemark *placemark = [placemarks objectAtIndex:0];
			NSLog(@"______%@", placemark.name); 					// eg. Apple Inc.
//			NSLog(@"______%@", placemark.thoroughfare); 			// street name, eg. Infinite Loop
//			NSLog(@"______%@", placemark.subThoroughfare); 			// eg. 1
//			NSLog(@"______%@", placemark.locality); 				// city, eg. Cupertino
//			NSLog(@"______%@", placemark.subLocality); 				// neighborhood, common name, eg. Mission District
//			NSLog(@"______%@", placemark.administrativeArea); 		// state, eg. CA
//			NSLog(@"______%@", placemark.subAdministrativeArea); 	// county, eg. Santa Clara
//			NSLog(@"______%@", placemark.postalCode); 				// zip code, eg. 95014
//			NSLog(@"______%@", placemark.ISOcountryCode); 			// eg. US
//			NSLog(@"______%@", placemark.country); 					// eg. United States
//			NSLog(@"______%@", placemark.inlandWater); 				// eg. Lake Tahoe
//			NSLog(@"______%@", placemark.ocean); 					// eg. Pacific Ocean
			if ([placemark.areasOfInterest count] > 0) {
				NSLog(@"______%@", placemark.areasOfInterest[0]); 	// eg. Golden Gate Park
			}

			_currentCoordinate = earthlocation.coordinate;
			if ([NSString isNull:placemark.locality] || [NSString isNull:placemark.subLocality]) {
				_currentAddress = nil;
            } else {
//                _currentAddress = [NSString stringWithFormat:@"%@, %@", placemark.locality, placemark.subLocality];
                _currentAddress = placemark.subLocality;
			}
		}
	}];

	[manager stopUpdatingLocation];
	if (_didUpdateBlock) {
		_didUpdateBlock(_currentCoordinate, _currentAddress);
		_didUpdateBlock = nil;
	}
}

@end
















