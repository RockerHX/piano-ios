//
//  HXLoadingView.m
//  mia
//
//  Created by miaios on 16/2/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLoadingView.h"
#import "HXXib.h"


@interface HXLoadingView ()

@property (weak, nonatomic) IBOutlet   UIView *noContentView;
@property (weak, nonatomic) IBOutlet   UIView *errorView;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet   UIView *loadingView;
@property (weak, nonatomic) IBOutlet HXActivityIndicator *activityIndicatorView;

- (IBAction)retryButtonPressed;

@end


@implementation HXLoadingView

HXXibImplementation

#pragma mark - Property
- (void)setLoadState:(HXLoadState)loadState {
    _loadState = loadState;
    
    switch (loadState) {
        case HXLoadStateLoading: {
            [self showLoadingView];
            break;
        }
        case HXLoadStateSuccess: {
            [self hiddenLoadingView];
            break;
        }
        case HXLoadStateError: {
            [self showErrorView];
            break;
        }
        case HXLoadStateNoContent: {
            [self showNoContentView];
            break;
        }
    }
}

#pragma mark - Action Methods
- (IBAction)retryButtonPressed {
    [self showLoadingView];
    if ([_delegate respondsToSelector:@selector(loadingView:takeAction:)]) {
        [_delegate loadingView:self takeAction:HXLoadingViewActionRetry];
    }
}

#pragma mark - Public Methods
- (void)showOnViewController:(UIViewController *)viewController {
    self.frame = viewController.view.frame;
    [viewController.view addSubview:self];
    [self showLoadingView];
}

#pragma mark - Private Methods
- (void)showLoadingView {
    _errorView.hidden = YES;
    _activityIndicatorView.color = [UIColor colorWithRed:232.0f/255.0f green:35.0f/255.0f blue:111.0f/255.0f alpha:1.0f];
    [_activityIndicatorView startAnimating];
}

- (void)hiddenLoadingView {
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        self.alpha = 1.0f;
        [_activityIndicatorView stopAnimating];
        [self removeFromSuperview];
    }];
}

- (void)showErrorView {
    _noContentView.hidden = YES;
    _errorView.hidden = NO;
}

- (void)showNoContentView; {
    _noContentView.hidden = NO;
    _errorView.hidden = YES;
}

@end
