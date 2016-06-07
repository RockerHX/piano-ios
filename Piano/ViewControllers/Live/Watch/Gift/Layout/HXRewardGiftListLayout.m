//
//  HXRewardGiftListLayout.m
//  CollectionViewDemo
//
//  Created by miaios on 16/4/19.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXRewardGiftListLayout.h"


@implementation HXRewardGiftListLayout {
    NSArray<UICollectionViewLayoutAttributes *> *_layoutAttributes;
}

#pragma mark - Init Methods
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Load Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setup];
}

#pragma mark - Configure Methods
- (void)setup {
    _lineSpace = 1.0f;
    _columnOfRow = 3;
}

#pragma mark - Property
- (CGFloat)controlWidth {
    return self.collectionView.frame.size.width;
}

- (CGFloat)controlHeight {
    return (self.itemWidth * 2) + (_lineSpace * 3);
}

- (CGFloat)itemWidth {
    return (self.controlWidth - (_lineSpace * 4)) / 3;
}

- (CGFloat)itemHeight {
    return self.itemWidth;
}

#pragma mark - Required Methods
- (void)prepareLayout {
    [super prepareLayout];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSInteger itemsCount = [self.collectionView numberOfItemsInSection:0];
    
    if (sectionCount > 1) {
        assert(@"Collection View Section Count Must Only One!");
        return;
    }
    
    CGFloat controlWidth = self.controlWidth;
    CGFloat itemWidth = self.itemWidth;
    CGFloat itemHeight = itemWidth;
    CGFloat itemSize = itemWidth + _lineSpace;
    
    BOOL newLine = NO;
    NSInteger pageLoop = _columnOfRow * 2;
    CGFloat x, y = _lineSpace;
    NSMutableArray *itemAttributes = [NSMutableArray arrayWithCapacity:itemsCount];
    for(NSInteger index = 0; index < itemsCount; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        NSInteger remainder = (index % _columnOfRow);
        NSInteger page = (index / pageLoop);
        x = _lineSpace + (controlWidth * page) + (itemSize * remainder);
        
        if (index && !remainder) {
            newLine = !newLine;
        }
        y = _lineSpace + (newLine ? itemSize : 0);
        
        attributes.frame = CGRectMake(x, y, itemWidth, itemHeight);
        [itemAttributes addObject:attributes];
    }
    _layoutAttributes = [itemAttributes copy];
}

- (CGSize)collectionViewContentSize {
    NSInteger pageLoop = _columnOfRow * 2;
    CGFloat sizeWidth = ((_layoutAttributes.count / pageLoop) + 1) * self.controlWidth;
    
    return CGSizeMake(sizeWidth, self.controlHeight);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *visibleAttributes = @[].mutableCopy;
    [_layoutAttributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull attributes, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [visibleAttributes addObject:attributes];
        }
    }];
    return visibleAttributes;
}

@end
