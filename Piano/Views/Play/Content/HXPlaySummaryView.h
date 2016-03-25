//
//  HXPlaySummaryView.h
//  mia
//
//  Created by miaios on 16/2/25.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MusicItem;
@class HXPlaySummaryView;

@protocol HXPlaySummaryViewDelegate <NSObject>

@required
- (void)summaryViewTaped:(HXPlaySummaryView *)summaryView;

@end

@interface HXPlaySummaryView : UIView

@property (weak, nonatomic) IBOutlet      id  <HXPlaySummaryViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet      UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet     UILabel *songNameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *singerNameLabel;
@property (weak, nonatomic) IBOutlet  UITextView *lyricsView;

- (void)displayWithMusic:(MusicItem *)music;

@end
