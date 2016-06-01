//
//  HXMeRewardAlbumContainerCell.m
//  Piano
//
//  Created by miaios on 16/6/1.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMeRewardAlbumContainerCell.h"
#import "HXMeRewardAlbumCell.h"


@implementation HXMeRewardAlbumContainerCell {
    NSArray *_albums;
}

#pragma mark - Public Methods
- (void)updateCellWithAlbums:(NSArray *)albums {
    _albums = albums;
    
    [_collectionView reloadData];
}

#pragma mark - Collection View Data Source Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _albums.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HXMeRewardAlbumCell class]) forIndexPath:indexPath];
}

#pragma mark - Collection View Delegate Methods
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    HXMeRewardAlbumCell *albumCell = (HXMeRewardAlbumCell *)cell;
    [albumCell updateCellWithAlbum:_albums[indexPath.row]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(attentionCell:selectedAlbum:)]) {
        [_delegate attentionCell:self selectedAlbum:_albums[indexPath.row]];
    }
}

@end
