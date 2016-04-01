//
//  HXProfileVideoContainerCell.m
//  Piano
//
//  Created by miaios on 16/4/1.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXProfileVideoContainerCell.h"
#import "HXProfileViewModel.h"
#import "HXProfileVideoCell.h"


@implementation HXProfileVideoContainerCell {
    HXProfileViewModel *_viewModel;
}

#pragma mark - Public Methods
- (void)updateCellWithViewModel:(HXProfileViewModel *)viewModel {
    _viewModel = viewModel;
    
    [self.collectionView reloadData];
}

#pragma mark - Collection View Data Source Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _viewModel.model.videos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HXProfileVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HXProfileVideoCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - Collection View Delegate Methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(_viewModel.videoItemWidth, _viewModel.videoItemHeight);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    HXProfileVideoCell *videoCell = (HXProfileVideoCell *)cell;
    [videoCell updateCellWithVideo:_viewModel.model.videos[indexPath.row]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(videoCell:selectedVideo:)]) {
        [_delegate videoCell:self selectedVideo:_viewModel.model.videos[indexPath.row]];
    }
}

@end
