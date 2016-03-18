//
//  UserDefaultsUtils.h
//
//  Created by linyehui on 14-11-16.
//
//

#import <Foundation/Foundation.h>

@interface UserDefaultsUtils : NSObject

+ (void)saveValue:(id) value forKey:(NSString *)key;
+ (id)valueWithKey:(NSString *)key;

+ (BOOL)boolValueWithKey:(NSString *)key;
+ (void)saveBoolValue:(BOOL)value withKey:(NSString *)key;

+ (double)doubleValueWithKey:(NSString *)key;
+ (void)saveDoubleValue:(double)value withKey:(NSString *)key;

+ (void)removeObjectForKey:(NSString *)defaultName;

@end
