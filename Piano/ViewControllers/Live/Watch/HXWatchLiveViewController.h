//
//  HXWatchLiveViewController.h
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"


@class HXLiveAnchorView;
@class HXLiveAlbumView;


@interface HXWatchLiveViewController : UIViewController

@property (weak, nonatomic) IBOutlet           UIView *liveView;
@property (weak, nonatomic) IBOutlet           UIView *endCountContainer;

@property (weak, nonatomic) IBOutlet HXLiveAnchorView *anchorView;
@property (weak, nonatomic) IBOutlet  HXLiveAlbumView *albumView;

@property (nonatomic, strong) NSString *roomID;

- (IBAction)closeButtonPressed;

@end
