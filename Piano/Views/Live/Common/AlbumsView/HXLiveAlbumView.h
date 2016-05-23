//
//  HXLiveAlbumView.h
//  Piano
//
//  Created by miaios on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXAlbumModel;
@class HXLiveAlbumView;


@protocol HXLiveAlbumViewDelegate <NSObject>

@required
- (void)liveAlbumsViewTaped:(HXLiveAlbumView *)albumsView;

@end


@interface HXLiveAlbumView : UIView

@property (weak, nonatomic) IBOutlet          id  <HXLiveAlbumViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet      UIView *coverContainer;
@property (weak, nonatomic) IBOutlet UIImageView *albumCover;
@property (weak, nonatomic) IBOutlet      UIView *blurContainer;
@property (weak, nonatomic) IBOutlet UIImageView *blurCover;
@property (weak, nonatomic) IBOutlet     UILabel *countLabel;

@property (nonatomic, strong)  NSString *coverUrl;
@property (nonatomic, assign) NSInteger  count;

- (void)updateWithAlbum:(HXAlbumModel *)album;
- (void)stopAlbumAnmation;

@end
