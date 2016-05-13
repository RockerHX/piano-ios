//
//  HXDiscoveryPreviewCell.h
//  Piano
//
//  Created by miaios on 16/5/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDiscoveryCell.h"


@interface HXDiscoveryPreviewCell : HXDiscoveryCell

@property (weak, nonatomic) IBOutlet UIView *previewView;

- (void)playWithURL:(NSString *)url;
- (void)stopPlay;

@end
