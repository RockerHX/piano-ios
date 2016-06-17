//
//  MIAProfileLiveView.h
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIABaseShowView.h"

typedef void(^ProfileViewClickBlock)();

@interface MIAProfileLiveView : MIABaseShowView

- (void)profileLiveViewClickHandler:(ProfileViewClickBlock)block;

@end
