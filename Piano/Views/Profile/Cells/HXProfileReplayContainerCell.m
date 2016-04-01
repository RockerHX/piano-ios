//
//  HXProfileReplayContainerCell.m
//  Piano
//
//  Created by miaios on 16/4/1.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXProfileReplayContainerCell.h"
#import "HXProfileReplayCell.h"


@implementation HXProfileReplayContainerCell {
    NSArray *_replays;
}

#pragma mark - Public Methods
- (void)updateCellWithReplays:(NSArray *)replays {
    _replays = replays;
    
    [self.collectionView reloadData];
}

#pragma mark - Collection View Data Source Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _replays.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HXProfileReplayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HXProfileReplayCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - Collection View Delegate Methods
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    HXProfileReplayCell *replayCell = (HXProfileReplayCell *)cell;
    [replayCell updateCellWithReplay:_replays[indexPath.row]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(replayCell:selectedReplay:)]) {
        [_delegate replayCell:self selectedReplay:_replays[indexPath.row]];
    }
}

@end
