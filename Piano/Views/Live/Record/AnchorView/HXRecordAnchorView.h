//
//  HXRecordAnchorView.h
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HXRecordAnchorViewAction) {
    HXRecordAnchorViewActionShowAnchor,
};


@class HXRecordAnchorView;


@protocol HXRecordAnchorViewDelegate <NSObject>

@required
- (void)anchorView:(HXRecordAnchorView *)anchorView takeAction:(HXRecordAnchorViewAction)action;

@end


@interface HXRecordAnchorView : UIView

@property (weak, nonatomic) IBOutlet id  <HXRecordAnchorViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIButton *avatar;
@property (weak, nonatomic) IBOutlet  UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet  UILabel *countLabel;

- (IBAction)avatarButtonPressed;

- (void)startRecordTime;
- (void)stopRecordTime;

@end
