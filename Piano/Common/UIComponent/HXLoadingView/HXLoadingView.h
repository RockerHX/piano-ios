//
//  HXLoadingView.h
//  mia
//
//  Created by miaios on 16/2/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXActivityIndicator.h"

typedef NS_ENUM(NSUInteger, HXLoadState) {
    HXLoadStateLoading,
    HXLoadStateSuccess,
    HXLoadStateError,
    HXLoadStateNoContent
};

typedef NS_ENUM(NSUInteger, HXLoadingViewAction) {
    HXLoadingViewActionRetry
};

@class HXLoadingView;

@protocol HXLoadingViewDelegate <NSObject>

@optional
- (void)loadingView:(HXLoadingView *)loadingView takeAction:(HXLoadingViewAction)action;

@end

@interface HXLoadingView : UIView

@property (weak, nonatomic) IBOutlet id <HXLoadingViewDelegate>delegate;

@property (nonatomic, assign) HXLoadState loadState;

- (void)showOnViewController:(UIViewController *)viewController;

@end
