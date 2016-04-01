//
//  HXProfileAlbumContainerCell.m
//  Piano
//
//  Created by miaios on 16/4/1.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXProfileAlbumContainerCell.h"
#import "HXProfileViewModel.h"
#import "HXProfileAlbumCell.h"


@implementation HXProfileAlbumContainerCell {
    HXProfileViewModel *_viewModel;
}

#pragma mark - Public Methods
- (void)updateCellWithViewModel:(HXProfileViewModel *)viewModel {
    _viewModel = viewModel;
    
    [self.collectionView reloadData];
}

#pragma mark - Collection View Data Source Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _viewModel.model.albums.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HXProfileAlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HXProfileAlbumCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - Collection View Delegate Methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(_viewModel.albumItemWidth, _viewModel.albumItemHeight);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    HXProfileAlbumCell *albumCell = (HXProfileAlbumCell *)cell;
    [albumCell updateCellWithAlbum:_viewModel.model.albums[indexPath.row]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(albumCell:selectedAlbum:)]) {
        [_delegate albumCell:self selectedAlbum:_viewModel.model.albums[indexPath.row]];
    }
}

@end
