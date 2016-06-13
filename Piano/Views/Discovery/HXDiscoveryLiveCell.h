//
//  HXDiscoveryLiveCell.h
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDiscoveryPreviewCell.h"
#import "HXDiscoveryModel.h"


typedef NS_ENUM(NSUInteger, HXDiscoveryLiveCellAction) {
    HXDiscoveryLiveCellActionStartLive,
    HXDiscoveryLiveCellActionChangeCover,
};


@class HXDiscoveryLiveCell;
@protocol HXDiscoveryLiveCellDelegate;


@interface HXDiscoveryLiveCell : HXDiscoveryPreviewCell

@property (weak, nonatomic) IBOutlet          id  <HXDiscoveryLiveCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet    UIButton *changCoverButton;

- (IBAction)startLiveButtonPressed;
- (IBAction)changCoverButtonPressed;

- (void)updateCellWithModel:(HXDiscoveryModel *)model;

@end


@protocol HXDiscoveryLiveCellDelegate <NSObject>

@required
- (void)liveCell:(HXDiscoveryLiveCell *)cell takeAction:(HXDiscoveryLiveCellAction)action;

@end
