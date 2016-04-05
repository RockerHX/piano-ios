//
//  HXAlbumsControlCell.h
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, HXAlbumsControlCellAction) {
    HXAlbumsControlCellActionPlay,
    HXAlbumsControlCellActionPrevious,
    HXAlbumsControlCellActionNext,
};


@class HXAlbumModel;
@class HXAlbumsControlCell;


@protocol HXAlbumsControlCellDelegate <NSObject>

@required
- (void)controlCell:(HXAlbumsControlCell *)cell takeAction:(HXAlbumsControlCellAction)action;

@end


@interface HXAlbumsControlCell : UITableViewCell

@property (weak, nonatomic) IBOutlet          id  <HXAlbumsControlCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet    UIButton *playButton;
@property (weak, nonatomic) IBOutlet     UILabel *starTimeLabel;
@property (weak, nonatomic) IBOutlet    UISlider *slider;
@property (weak, nonatomic) IBOutlet     UILabel *endTimeLabel;

- (IBAction)playButtonPressed;
- (IBAction)previousButtonPressed;
- (IBAction)nextButtonPressed;

- (void)updateCellWithAlbum:(HXAlbumModel *)model;

@end
