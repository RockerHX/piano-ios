//
//  HXNoNetworkView.h
//  mia
//
//  Created by miaios on 15/10/19.
//  Copyright © 2015年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HXNoNetworkView : UIView

+ (instancetype)showOnViewController:(UIViewController *)viewController
                                show:(void(^)(void))showBlock
                                play:(void(^)(void))playBlock;

+ (void)hidden;

- (void)showOnViewController:(UIViewController *)viewController
                        show:(void(^)(void))showBlock
                        play:(void(^)(void))playBlock;

- (void)hidden;

@end
