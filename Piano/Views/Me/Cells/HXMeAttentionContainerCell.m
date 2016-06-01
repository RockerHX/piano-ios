//
//  HXMeAttentionContainerCell.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMeAttentionContainerCell.h"
#import "HXHostProfileViewModel.h"
#import "HXMeAttentionCell.h"


@implementation HXMeAttentionContainerCell {
    HXHostProfileViewModel *_viewModel;
}

#pragma mark - Public Methods
- (void)updateCellWithViewModel:(HXHostProfileViewModel *)viewModel {
    _viewModel = viewModel;
    
    [self.collectionView reloadData];
}

#pragma mark - Collection View Data Source Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _viewModel.model.attentions.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HXMeAttentionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HXMeAttentionCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - Collection View Delegate Methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(_viewModel.attentionItemWidth, _viewModel.attetionItemHeight);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    HXMeAttentionCell *attentionCell = (HXMeAttentionCell *)cell;
    [attentionCell updateCellWithAttention:_viewModel.model.attentions[indexPath.row]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(attentionCell:selectedAttention:)]) {
        [_delegate attentionCell:self selectedAttention:_viewModel.model.attentions[indexPath.row]];
    }
}

@end
