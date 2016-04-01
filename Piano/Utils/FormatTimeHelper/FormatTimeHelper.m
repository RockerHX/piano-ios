//
//  FormatTimeHelper.h
//
//  Created by linyehui on 2016-02-02
//
//

#import "DateTools.h"
#import "FormatTimeHelper.h"

@implementation FormatTimeHelper {
}

+ (NSString *)formatTimeWith:(NSInteger)time {
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
	NSInteger hours = [date hoursEarlierThan:[NSDate date]];
	NSString *prompt = @"刚刚";
	if (hours <= 0) {
		prompt = @"刚刚";
	} else if (hours > 0 && hours <= 24) {
		prompt = [NSString stringWithFormat:@"%zd小时前", hours];
	} else {
		NSInteger days = [date daysEarlierThan:[NSDate date]];
		if (days < 10) {
			prompt = [NSString stringWithFormat:@"%zd天前", days];
		} else {
			prompt = [date formattedDateWithFormat:@"yyyy-MM-dd"];
		}
	}
	return prompt;
}

@end
