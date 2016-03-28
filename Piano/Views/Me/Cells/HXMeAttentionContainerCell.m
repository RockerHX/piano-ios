//
//  HXMeAttentionContainerCell.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMeAttentionContainerCell.h"
#import "HXMeAttentionCell.h"


@implementation HXMeAttentionContainerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Collection View Data Source Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HXMeAttentionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HXMeAttentionCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - Collection View Delegate Methods
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    ;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ;
}

@end
