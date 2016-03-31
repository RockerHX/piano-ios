//
//  MusicItem.m
//  mia
//
//  Created by linyehui on 2015/09/08.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//

#import "MusicItem.h"

NSString * const kDefaultMusicID = @"0";

@implementation MusicItem

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if(self) {
		self.mid = [dictionary objectForKey:@"mid"];
		self.singerID = [dictionary objectForKey:@"singerID"];
		self.singerName = [dictionary objectForKey:@"singerName"];
		self.albumName = [dictionary objectForKey:@"albumName"];
		self.name = [dictionary objectForKey:@"name"];
		self.purl = [dictionary objectForKey:@"purl"];
		self.murl = [dictionary objectForKey:@"murl"];
		self.flag = [dictionary objectForKey:@"flag"];
    }
	
    return self;
}

- (instancetype)copyWithZone:(nullable NSZone *)zone {
	MusicItem *copyItem = [[[self class] allocWithZone:zone] init];
	copyItem.mid = [_mid copy];
	copyItem.singerID = [_singerID copy];
	copyItem.singerName = [_singerName copy];
	copyItem.albumName = [_albumName copy];
	copyItem.name = [_name copy];
	copyItem.purl = [_purl copy];
	copyItem.murl = [_murl copy];
	copyItem.flag = [_flag copy];

	return copyItem;
}


//将对象编码(即:序列化)
- (void) encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:self.mid forKey:@"mid"];
	[aCoder encodeObject:self.singerID forKey:@"singerID"];
	[aCoder encodeObject:self.singerName forKey:@"singerName"];
	[aCoder encodeObject:self.albumName forKey:@"albumName"];
	[aCoder encodeObject:self.name forKey:@"name"];
	[aCoder encodeObject:self.purl forKey:@"purl"];
	[aCoder encodeObject:self.murl forKey:@"murl"];
	[aCoder encodeObject:self.flag forKey:@"flag"];
}

//将对象解码(反序列化)
-(id) initWithCoder:(NSCoder *)aDecoder
{
	if (self=[super init]) {
		self.mid = [aDecoder decodeObjectForKey:@"mid"];
		self.singerID = [aDecoder decodeObjectForKey:@"singerID"];
		self.singerName = [aDecoder decodeObjectForKey:@"singerName"];
		self.albumName = [aDecoder decodeObjectForKey:@"albumName"];
		self.name = [aDecoder decodeObjectForKey:@"name"];
		self.purl = [aDecoder decodeObjectForKey:@"purl"];
		self.murl = [aDecoder decodeObjectForKey:@"murl"];
		self.flag = [aDecoder decodeObjectForKey:@"flag"];
	}

	return (self);

}


@end
