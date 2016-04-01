//
//  HXProfileReplayContainerCell.m
//  Piano
//
//  Created by miaios on 16/4/1.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXProfileReplayContainerCell.h"
#import "HXProfileViewModel.h"
#import "HXProfileReplayCell.h"


@implementation HXProfileReplayContainerCell {
    HXProfileViewModel *_viewModel;
}

#pragma mark - Public Methods
- (void)updateCellWithViewModel:(HXProfileViewModel *)viewModel {
    _viewModel = viewModel;
    
    [self.collectionView reloadData];
}

#pragma mark - Collection View Data Source Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _viewModel.model.replays.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HXProfileReplayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HXProfileReplayCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - Collection View Delegate Methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(_viewModel.replayItemWidth, _viewModel.replayItemHeight);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    HXProfileReplayCell *replayCell = (HXProfileReplayCell *)cell;
    [replayCell updateCellWithReplay:_viewModel.model.replays[indexPath.row]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(replayCell:selectedReplay:)]) {
        [_delegate replayCell:self selectedReplay:_viewModel.model.replays[indexPath.row]];
    }
}

@end
