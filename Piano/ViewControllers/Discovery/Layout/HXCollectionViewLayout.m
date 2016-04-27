//
//  HXCollectionViewLayout.m
//  CollectionViewDemo
//
//  Created by miaios on 16/4/19.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXCollectionViewLayout.h"


@implementation HXCollectionViewLayout {
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
    ;
}

#pragma mark - Property
- (CGFloat)controlWidht {
    return self.collectionView.frame.size.width;
}

- (CGFloat)controlHeight {
    return self.collectionView.frame.size.height;
}

- (CGFloat)itemWidth {
    return self.controlWidht - _itemSpacing*2 - _itemSpilled*2;
}

- (CGFloat)itemHeight {
    return self.controlHeight;
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
    
    CGFloat controlWidht = self.controlWidht;
    CGFloat controlHeight = self.controlHeight;
    
    CGFloat itemWidth = self.itemWidth;
    CGFloat itemHeith = self.itemHeight;
    
    CGFloat x = _itemSpacing + _itemSpilled;
    NSMutableArray *itemAttributes = [NSMutableArray arrayWithCapacity:itemsCount];
    for(NSInteger itemIndex = 0; itemIndex < itemsCount; itemIndex++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemIndex inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        HXCollectionViewLayoutStyle style = [_delegate collectionView:self.collectionView layout:self styleForItemAtIndexPath:indexPath];
        
        CGFloat y = 0.0f;
        HXCollectionViewLayoutStyle lastStyle = HXCollectionViewLayoutStyleHeavy;
        if (style == HXCollectionViewLayoutStylePetty) {
            itemHeith = (controlHeight - _itemSpacing) / 2;
            itemWidth = (controlWidht - _itemSpacing*3 - _itemSpilled*2) / 2;
            
            NSIndexPath *lastIndexPath = nil;
            if (itemIndex) {
                lastIndexPath = [NSIndexPath indexPathForItem:(itemIndex - 1) inSection:0];
                lastStyle = [_delegate collectionView:self.collectionView layout:self styleForItemAtIndexPath:lastIndexPath];
            }
            if (lastIndexPath && (lastStyle == HXCollectionViewLayoutStylePetty)) {
                UICollectionViewLayoutAttributes *lastAttributes = [itemAttributes lastObject];
                if (lastAttributes.frame.origin.y == 0.0f) {
                    y = itemHeith + _itemSpacing;
                }
            }
        }
        
        attributes.frame = CGRectMake(x, y, itemWidth, itemHeith);
        switch (style) {
            case HXCollectionViewLayoutStyleHeavy: {
                x += (itemWidth + _itemSpacing);
                break;
            }
            case HXCollectionViewLayoutStylePetty: {
                if (y > 0.0f) {
                    x += (itemWidth + _itemSpacing);
                }
                break;
            }
        }
        [itemAttributes addObject:attributes];
    }
    _layoutAttributes = [itemAttributes copy];
}

- (CGSize)collectionViewContentSize {
    CGFloat sizeHeight = [_layoutAttributes firstObject].frame.size.height;
    __block CGFloat sizeWidth = 0;
    [_layoutAttributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull attributes, NSUInteger index, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        HXCollectionViewLayoutStyle style = [_delegate collectionView:self.collectionView layout:self styleForItemAtIndexPath:indexPath];
        
        switch (style) {
            case HXCollectionViewLayoutStyleHeavy: {
                sizeWidth += (attributes.frame.size.width + _itemSpacing);
                break;
            }
            case HXCollectionViewLayoutStylePetty: {
                if (attributes.frame.origin.y == 0.0f) {
                    sizeWidth += (attributes.frame.size.width + _itemSpacing);
                }
                break;
            }
        }
    }];
    
    sizeWidth += (_itemSpacing + _itemSpilled);
    
    return CGSizeMake(sizeWidth, sizeHeight);
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

#pragma mark - Optional Methods
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    UICollectionViewLayoutAttributes *finialAttribute = [self layoutAttributesForElementsInPoint:proposedContentOffset];
    if (finialAttribute) {
        NSInteger itemIndex = [_layoutAttributes indexOfObject:finialAttribute];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemIndex inSection:0];
        HXCollectionViewLayoutStyle style = [_delegate collectionView:self.collectionView layout:self styleForItemAtIndexPath:indexPath];
        
        CGPoint finialPoint = CGPointMake(finialAttribute.frame.origin.x - _itemSpacing, proposedContentOffset.y);
        if (proposedContentOffset.x >= finialAttribute.center.x) {
            finialPoint.x += (finialAttribute.frame.size.width + _itemSpacing);
        }
        
        if (style == HXCollectionViewLayoutStyleHeavy) {
            finialPoint.x -= _itemSpilled;
        }
        
        _indexPath = [self indexPathAtPoint:finialPoint];
        return finialPoint;
    } else {
        _indexPath = [self indexPathAtPoint:proposedContentOffset];
        return proposedContentOffset;
    }
}

#pragma mark - Public Methods
- (NSIndexPath *)indexPathAtPoint:(CGPoint)point {
    UICollectionViewLayoutAttributes *finialAttribute = [self layoutAttributesForElementsInPoint:point];
    NSInteger itemIndex = [_layoutAttributes indexOfObject:finialAttribute];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemIndex inSection:0];
    return indexPath;
}

#pragma mark - Private Methods
- (UICollectionViewLayoutAttributes *)layoutAttributesForElementsInPoint:(CGPoint)point {
    CGFloat placeholder = _itemSpacing + _itemSpilled;
    __block UICollectionViewLayoutAttributes *visibleAttributes = nil;
    [_layoutAttributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull attributes, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect rect = (CGRect){attributes.frame.origin.x - placeholder, attributes.frame.origin.y, attributes.frame.size.width + placeholder, attributes.frame.size.height};
        if (CGRectContainsPoint(rect, point)) {
            visibleAttributes = attributes;
            return;
        }
    }];
    return visibleAttributes;
}

@end
