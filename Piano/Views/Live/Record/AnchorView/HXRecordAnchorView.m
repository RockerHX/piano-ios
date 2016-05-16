//
//  HXRecordAnchorView.m
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXRecordAnchorView.h"
#import "HXXib.h"


@implementation HXRecordAnchorView {
    dispatch_source_t _timer;
    NSInteger _duration;
}

HXXibImplementation

#pragma mark - Event Response
- (IBAction)avatarButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(anchorView:takeAction:)]) {
        [_delegate anchorView:self takeAction:HXRecordAnchorViewActionShowAnchor];
    }
}

#pragma mark - Public Methods
- (void)startRecordTime {
    uint64_t interval = NSEC_PER_SEC;
    dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, 0), interval, 0);
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateDurationTime];
        });
    });
    dispatch_resume(_timer);
}

- (void)stopRecordTime {
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

#pragma mark - Private Methods
- (void)updateDurationTime {
    _duration++;
    
    NSInteger seconds = _duration % 60;
    NSInteger minutes = _duration / 60;
    NSInteger hours = minutes / 60;
    
    _durationLabel.text = [NSString stringWithFormat:@"%02zd:%02zd:%02zd", hours, minutes, seconds];
}

@end
