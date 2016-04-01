//
//  HXMeAttentionContainerCell.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMeAttentionContainerCell.h"
#import "HXMeAttentionCell.h"


@implementation HXMeAttentionContainerCell {
    NSArray *_attentions;
}

#pragma mark - Public Methods
- (void)updateCellWithAttentions:(NSArray *)attentions {
    _attentions = attentions;
    
    [self.collectionView reloadData];
}

#pragma mark - Collection View Data Source Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _attentions.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HXMeAttentionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HXMeAttentionCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - Collection View Delegate Methods
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    HXMeAttentionCell *attentionCell = (HXMeAttentionCell *)cell;
    [attentionCell updateCellWithAttention:_attentions[indexPath.row]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(attentionCell:selectedAttention:)]) {
        [_delegate attentionCell:self selectedAttention:_attentions[indexPath.row]];
    }
}

@end
