//
//  HXSongModel.m
//  Piano
//
//  Created by miaios on 16/4/5.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXSongModel.h"

NSString * const kDefaultMusicID = @"0";

@implementation HXSongModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"mid": @"id"};
}

- (void)mj_keyValuesDidFinishConvertingToObject {
    NSInteger second = _duration / 1000;
    NSInteger minute = second / 60;
    _durationPrompt = [NSString stringWithFormat:@"%02zd:%02zd", minute, (second % 60)];
}

#pragma mark - NSCoding
//将对象编码(即:序列化)
- (void) encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeInteger:_duration forKey:@"duration"];

	[aCoder encodeObject:_mid forKey:@"mid"];
	[aCoder encodeObject:_uID forKey:@"uID"];
	[aCoder encodeObject:_albumID forKey:@"albumID"];
	[aCoder encodeObject:_title forKey:@"title"];
	[aCoder encodeObject:_summary forKey:@"summary"];
	[aCoder encodeObject:_nick forKey:@"nick"];
	[aCoder encodeObject:_coverUrl forKey:@"coverUrl"];
	[aCoder encodeObject:_mp3Url forKey:@"mp3Url"];
}

//将对象解码(反序列化)
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
	if (self=[super init]) {
		_duration = [aDecoder decodeIntegerForKey:@"duration"];

		_mid = [aDecoder decodeObjectForKey:@"mid"];
		_uID = [aDecoder decodeObjectForKey:@"uID"];
		_albumID = [aDecoder decodeObjectForKey:@"albumID"];
		_title = [aDecoder decodeObjectForKey:@"title"];
		_summary = [aDecoder decodeObjectForKey:@"summary"];
		_nick = [aDecoder decodeObjectForKey:@"nick"];
		_coverUrl = [aDecoder decodeObjectForKey:@"coverUrl"];
		_mp3Url = [aDecoder decodeObjectForKey:@"mp3Url"];
	}
	
	return (self);
}

@end
