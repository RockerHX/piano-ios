//
//  HXProfileAlbumContainerCell.m
//  Piano
//
//  Created by miaios on 16/4/1.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXProfileAlbumContainerCell.h"
#import "HXProfileAlbumCell.h"


@implementation HXProfileAlbumContainerCell {
    NSArray *_albums;
}

#pragma mark - Public Methods
- (void)updateCellWithAlbums:(NSArray *)albums {
    _albums = albums;
    
    [self.collectionView reloadData];
}

#pragma mark - Collection View Data Source Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _albums.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HXProfileAlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HXProfileAlbumCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - Collection View Delegate Methods
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    HXProfileAlbumCell *albumCell = (HXProfileAlbumCell *)cell;
    [albumCell updateCellWithAlbum:_albums[indexPath.row]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(albumCell:selectedAlbum:)]) {
        [_delegate albumCell:self selectedAlbum:_albums[indexPath.row]];
    }
}

@end
