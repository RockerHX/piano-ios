//
//  HXWatcherContainerViewController.m
//  Piano
//
//  Created by miaios on 16/3/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXWatcherContainerViewController.h"
#import "HXWatcherCell.h"


@interface HXWatcherContainerViewController ()
@end


@implementation HXWatcherContainerViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    ;
}

- (void)viewConfigure {
    ;
}

#pragma mark - Property
- (void)setWatchers:(NSArray *)watchers {
    _watchers = watchers;
    
    if (watchers.count) {
        [self.collectionView reloadData];
    }
}

#pragma mark - UICollection View Data Source Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _watchers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HXWatcherCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HXWatcherCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - UICollection View Delegate Methods
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    HXWatcherCell *watcherCell = (HXWatcherCell *)cell;
    [watcherCell updateWithWatcher:_watchers[indexPath.row]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(watcherContainer:shouldShowWatcher:)]) {
        [_delegate watcherContainer:self shouldShowWatcher:_watchers[indexPath.row]];
    }
}

@end
