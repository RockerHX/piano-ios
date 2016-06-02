//
//  HXMeRewardAlbumContainerCell.m
//  Piano
//
//  Created by miaios on 16/6/1.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMeRewardAlbumContainerCell.h"
#import "HXHostProfileViewModel.h"
#import "HXMeRewardAlbumCell.h"


@implementation HXMeRewardAlbumContainerCell {
    HXHostProfileViewModel *_viewModel;
}

#pragma mark - Public Methods
- (void)updateCellWithViewModel:(HXHostProfileViewModel *)viewModel {
    _viewModel = viewModel;
    
    [self.collectionView reloadData];
}

#pragma mark - Collection View Data Source Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _viewModel.model.albums.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HXMeRewardAlbumCell class]) forIndexPath:indexPath];
}

#pragma mark - Collection View Delegate Methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(_viewModel.albumItemWidth, _viewModel.albumItemHeight);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    HXMeRewardAlbumCell *albumCell = (HXMeRewardAlbumCell *)cell;
    [albumCell updateCellWithAlbum:_viewModel.model.albums[indexPath.row]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(rewardAlbumCell:selectedAlbum:)]) {
        [_delegate rewardAlbumCell:self selectedAlbum:_viewModel.model.albums[indexPath.row]];
    }
}

@end
