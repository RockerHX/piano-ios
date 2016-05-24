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
    NSInteger loop = 3;
    NSInteger pageLoop = loop * 2;
    CGFloat x = _lineSpace;
    CGFloat y = _lineSpace;
    NSMutableArray *itemAttributes = [NSMutableArray arrayWithCapacity:itemsCount];
    for(NSInteger index = 0; index < itemsCount; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        NSInteger remainder = (index % loop);
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

//- (CGSize)collectionViewContentSize {
//}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *visibleAttributes = @[].mutableCopy;
    [_layoutAttributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull attributes, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [visibleAttributes addObject:attributes];
        }
    }];
    return visibleAttributes;
}

#pragma mark - Optional Methods
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
//    UICollectionViewLayoutAttributes *finialAttribute = [self layoutAttributesForElementsInPoint:proposedContentOffset];
//    if (finialAttribute) {
//        NSInteger itemIndex = [_layoutAttributes indexOfObject:finialAttribute];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemIndex inSection:0];
//        HXRewardGiftListLayoutStyle style = [_delegate collectionView:self.collectionView layout:self styleForItemAtIndexPath:indexPath];
//        
//        CGPoint finialPoint = CGPointMake(finialAttribute.frame.origin.x - _itemSpacing, proposedContentOffset.y);
//        if (proposedContentOffset.x >= finialAttribute.center.x) {
//            finialPoint.x += (finialAttribute.frame.size.width + _itemSpacing);
//        }
//        
//        if (style == HXRewardGiftListLayoutStyleHeavy) {
//            finialPoint.x -= _itemSpilled;
//        }
//        
//        _indexPath = [self indexPathAtPoint:finialPoint];
//        return finialPoint;
//    } else {
//        _indexPath = [self indexPathAtPoint:proposedContentOffset];
//        return proposedContentOffset;
//    }
//}

#pragma mark - Public Methods
//- (NSIndexPath *)indexPathAtPoint:(CGPoint)point {
//    UICollectionViewLayoutAttributes *finialAttribute = [self layoutAttributesForElementsInPoint:point];
//    NSInteger itemIndex = [_layoutAttributes indexOfObject:finialAttribute];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemIndex inSection:0];
//    return indexPath;
//}

#pragma mark - Private Methods
//- (UICollectionViewLayoutAttributes *)layoutAttributesForElementsInPoint:(CGPoint)point {
//    CGFloat placeholder = _itemSpacing + _itemSpilled;
//    __block UICollectionViewLayoutAttributes *visibleAttributes = nil;
//    [_layoutAttributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull attributes, NSUInteger idx, BOOL * _Nonnull stop) {
//        CGRect rect = (CGRect){attributes.frame.origin.x - placeholder, attributes.frame.origin.y, attributes.frame.size.width + placeholder, attributes.frame.size.height};
//        if (CGRectContainsPoint(rect, point)) {
//            visibleAttributes = attributes;
//            return;
//        }
//    }];
//    return visibleAttributes;
//}

@end
