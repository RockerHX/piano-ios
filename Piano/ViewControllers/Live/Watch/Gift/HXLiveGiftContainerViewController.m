//
//  HXLiveGiftContainerViewController.m
//  Piano
//
//  Created by miaios on 16/5/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveGiftContainerViewController.h"
#import "HXLiveGiftItemCell.h"
#import "UIConstants.h"
#import "HXRewardGiftListLayout.h"


@implementation HXLiveGiftContainerViewController

#pragma mark - Property
- (void)setGifts:(NSArray *)gifts {
    _gifts = gifts;
    
    _selectedIndex = -1;
    if ([self.collectionView.collectionViewLayout isKindOfClass:[HXRewardGiftListLayout class]]) {
        ((HXRewardGiftListLayout *)self.collectionView.collectionViewLayout).lineSpace = 0.0f;
    }
    [self.collectionView reloadData];
}

- (CGFloat)contianerHeight {
    return ((HXRewardGiftListLayout *)self.collectionView.collectionViewLayout).controlHeight;
}

#pragma mark - UICollectionView Data Source Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _gifts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HXLiveGiftItemCell class]) forIndexPath:indexPath];
}

#pragma mark - UICollectionView Delegate Methods
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    HXLiveGiftItemCell *itemCell = (HXLiveGiftItemCell *)cell;
    [itemCell updateWithGift:_gifts[indexPath.row]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectedIndex < 0) {
        _selectedIndex = indexPath.row;
    }
    
    HXGiftModel *selectedGift = _gifts[_selectedIndex];
    selectedGift.selected = NO;
    
    HXGiftModel *selectGift = _gifts[indexPath.row];
    selectGift.selected = YES;
    
    _selectedIndex = indexPath.row;
    [collectionView reloadData];
    
    if (_delegate && [_delegate respondsToSelector:@selector(container:selectedGift:)]) {
        [_delegate container:self selectedGift:selectGift];
    }
}

@end
