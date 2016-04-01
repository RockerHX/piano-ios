//
//  HXProfileReplayContainerCell.h
//  Piano
//
//  Created by miaios on 16/4/1.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HXReplayModel;
@class HXProfileReplayContainerCell;


@protocol HXProfileReplayContainerCellDelegate <NSObject>

@required
- (void)replayCell:(HXProfileReplayContainerCell *)cell selectedReplay:(HXReplayModel *)replay;

@end


@interface HXProfileReplayContainerCell : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet id  <HXProfileReplayContainerCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (void)updateCellWithReplays:(NSArray *)replays;

@end
