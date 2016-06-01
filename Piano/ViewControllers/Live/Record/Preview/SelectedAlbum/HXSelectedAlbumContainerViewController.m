//
//  HXSelectedAlbumContainerViewController.m
//  Piano
//
//  Created by miaios on 16/6/1.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXSelectedAlbumContainerViewController.h"
#import "HXPreviewSelectedAlbumCell.h"
#import "UIView+Frame.h"


@interface HXSelectedAlbumContainerViewController () <
UICollectionViewDelegateFlowLayout
>
@end


@implementation HXSelectedAlbumContainerViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Property
- (void)setAlbums:(NSArray *)albums {
    _albums = [albums copy];
    [self.collectionView reloadData];
}

#pragma mark - Collection View Data Source Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _albums.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HXPreviewSelectedAlbumCell class]) forIndexPath:indexPath];
}

#pragma mark - Collection View Delegate Methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (self.view.width - 60.0f) / 2;
    CGFloat height = width + 50.0f;
    return CGSizeMake(width, height);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    HXPreviewSelectedAlbumCell *selectedCell = (HXPreviewSelectedAlbumCell *)cell;
    [selectedCell updateWithAlbum:_albums[indexPath.row]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(container:selectedAlbum:)]) {
        [_delegate container:self selectedAlbum:_albums[indexPath.row]];
    }
}

@end
