//
//  HXDiscoveryLiveCell.h
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDiscoveryCell.h"
#import "HXDiscoveryModel.h"


@interface HXDiscoveryLiveCell : HXDiscoveryCell

@property (weak, nonatomic) IBOutlet UIImageView *cover;

- (IBAction)startLiveButtonPressed;

@end
