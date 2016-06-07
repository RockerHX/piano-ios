//
//  MIAAlbumPlayView.m
//  Piano
//
//  Created by 刘维 on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAAlbumPlayView.h"
#import "JOBaseSDK.h"
#import "MusicMgr.h"
#import "MIASongManage.h"
#import "MIAFontManage.h"
#import "MIAPlaySlider.h"

#define SliderColor JORGBCreate(246., 28., 41., 1.)

static CGFloat const kTopSpaceDistance = 10.; //上面的间距大小
static CGFloat const kBottomSpaceDistance = 10.; //下面的间距大小

static CGFloat const kButtonToTimeSpaceDistance = 10.;//播放按钮到开始时间的间距大小
static CGFloat const kTimeToSliderSpaceDistance = 10.; //播放时间到slider的间距大小
//static CGFloat const kButtonToButtonSpaceDistance = 10.;//按钮间的间距大小


static NSString const * kAlbumPlayHostKey = @"kAlbumPlayHostKey";

@interface MIAAlbumPlayView(){

    BOOL playState;//播放的状态.
    BOOL isCurrentHostObject;//播放的是否是当前的模块
    
    dispatch_source_t timer;
}

@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UILabel *startTimeLabel;
@property (nonatomic, strong) MIAPlaySlider *sliderView;
@property (nonatomic, strong) UILabel *remainTimeLabel;
//@property (nonatomic, strong) UIButton *nextButton;
//@property (nonatomic, strong) UIButton *preButton;

//@property (nonatomic, strong) NSTimer * timer;

@property (nonatomic, copy) PlaySongBlock songBlock;

@property (nonatomic, copy) NSArray *songArray;

@end

@implementation MIAAlbumPlayView

- (instancetype)init{

    self = [super init];
    if (self) {
        
        playState = NO;
        
        [self createPlayView];
    }
    return self;
}

- (void)createPlayView{

    self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_playButton addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_playButton];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_playButton superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:kTopSpaceDistance selfView:_playButton superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:-kBottomSpaceDistance selfView:_playButton superView:self];
    [JOAutoLayout autoLayoutWithWidthEqualHeightWithselfView:_playButton superView:self];
    
    self.startTimeLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_Play_Time]];
    [_startTimeLabel setText:@"00:00"];
    [self addSubview:_startTimeLabel];
    
    [JOAutoLayout autoLayoutWithLeftView:_playButton distance:kButtonToTimeSpaceDistance selfView:_startTimeLabel superView:self];
    [JOAutoLayout autoLayoutWithTopYView:_playButton selfView:_startTimeLabel superView:self];
    [JOAutoLayout autoLayoutWithBottomYView:_playButton selfView:_startTimeLabel superView:self];
    [JOAutoLayout autoLayoutWithWidth:[_startTimeLabel sizeThatFits:JOMAXSize].width+1 selfView:_startTimeLabel superView:self];
    
//    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_nextButton setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [_nextButton addTarget:self action:@selector(nextSongAction) forControlEvents:UIControlEventTouchUpInside];
//    [_nextButton setImage:[UIImage imageNamed:@"AD-NextIcon-E"] forState:UIControlStateNormal];
//    [_nextButton setImage:[UIImage imageNamed:@"AD-NextIcon-U"] forState:UIControlStateDisabled];
//    [self addSubview:_nextButton];
//    
//    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_nextButton superView:self];
//    [JOAutoLayout autoLayoutWithTopYView:_playButton selfView:_nextButton superView:self];
//    [JOAutoLayout autoLayoutWithBottomYView:_playButton selfView:_nextButton superView:self];
//    [JOAutoLayout autoLayoutWithWidthEqualHeightWithselfView:_nextButton superView:self];
    
//    self.preButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_preButton addTarget:self action:@selector(preSongAction) forControlEvents:UIControlEventTouchUpInside];
//    [_preButton setImage:[UIImage imageNamed:@"AD-PreviousIcon-E"] forState:UIControlStateNormal];
//    [_preButton setImage:[UIImage imageNamed:@"AD-PreviousIcon-U"] forState:UIControlStateDisabled];
//    [_preButton setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self addSubview:_preButton];
//    
//    [JOAutoLayout autoLayoutWithRightView:_nextButton distance:-kButtonToButtonSpaceDistance selfView:_preButton superView:self];
//    [JOAutoLayout autoLayoutWithTopYView:_playButton selfView:_preButton superView:self];
//    [JOAutoLayout autoLayoutWithBottomYView:_playButton selfView:_preButton superView:self];
//    [JOAutoLayout autoLayoutWithWidthEqualHeightWithselfView:_preButton superView:self];
    
    self.remainTimeLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_Play_Time]];
    [_remainTimeLabel setText:@"00:00"];
    [self addSubview:_remainTimeLabel];
    
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-5. selfView:_remainTimeLabel superView:self];
    [JOAutoLayout autoLayoutWithTopYView:_playButton selfView:_remainTimeLabel superView:self];
    [JOAutoLayout autoLayoutWithBottomYView:_playButton selfView:_remainTimeLabel superView:self];
    [JOAutoLayout autoLayoutWithWidth:[_remainTimeLabel sizeThatFits:JOMAXSize].width+1 selfView:_remainTimeLabel superView:self];
    
    self.sliderView = [MIAPlaySlider newAutoLayoutView];
    [_sliderView setMinimumTrackTintColor:SliderColor];
    [_sliderView setMaximumTrackTintColor:JORGBSameCreate(210.)];
    [_sliderView setValue:0.];
    [_sliderView setMinimumValue:0.];
    [_sliderView setMaximumValue:1.];
    [_sliderView addTarget:self action:@selector(sliderAction) forControlEvents:UIControlEventValueChanged];
    [_sliderView setThumbImage:[UIImage imageNamed:@"AD-SliderThumb"] forState:UIControlStateNormal];
    [self addSubview:_sliderView];
    
    [JOAutoLayout autoLayoutWithTopYView:_playButton distance:5. selfView:_sliderView superView:self];
    [JOAutoLayout autoLayoutWithBottomYView:_playButton distance:-5. selfView:_sliderView superView:self];
    [JOAutoLayout autoLayoutWithLeftView:_startTimeLabel distance:kTimeToSliderSpaceDistance selfView:_sliderView superView:self];
    [JOAutoLayout autoLayoutWithRightView:_remainTimeLabel distance:-kTimeToSliderSpaceDistance selfView:_sliderView superView:self];
}

- (void)dealloc{

    if ([[MusicMgr standard] isCurrentHostObject:self]){
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MusicMgrNotificationPlayerEvent object:nil];
    }
}

- (void)songPlayStateChange:(NSNotification *)notification{

    NSDictionary *notificationDic = [notification userInfo];
    if ([[notificationDic objectForKey:MusicMgrNotificationKey_PlayerEvent] integerValue] == MiaPlayerEventDidCompletion) {
        //一首歌播放完的通知 播放下一首
        if (_songBlock) {
            _songBlock([[MusicMgr standard] currentItem],[[MusicMgr standard] currentIndex]);
        }
    }
}

//第一次进入这个模块的时候 需要更新当前页面的播放状态
- (void)firstPlayUpdateState{

    //判断播放的是否是当前模块
//    if ([[MusicMgr standard] isCurrentHostObject:self]) {
//    
//        //添加播放完的通知
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(songPlayStateChange:) name:MusicMgrNotificationPlayerEvent object:nil];
//
//        [self addPlayTimeObserver];
//
//        [self playButtonUpdateState];
//        [self preButtonUpdateState];
//        [self nextButtonUpdateState];
//        
//    }else{
        //下一首,上一首的点击状态不可用 slider也不可滑动
    
    //此版本不理会再次进入正在播放专辑页面,每一次进入都当做是进入一张全新的专辑页面
        playState = NO;
        [_playButton setImage:[UIImage imageNamed:@"AD-PlayIcon-L"] forState:UIControlStateNormal];
//        [_preButton setEnabled:NO];
//        [_nextButton setEnabled:NO];
        [_sliderView setEnabled:NO];
//    }
}

- (void)playButtonUpdateState{

    playState = [[MusicMgr standard] isPlaying];
    
    if ([[MusicMgr standard] isPlaying]) {
        //正在播放
        [_playButton setImage:[UIImage imageNamed:@"AD-PauseIcon-L"] forState:UIControlStateNormal];
    }else{
        //未播放状态
        [_playButton setImage:[UIImage imageNamed:@"AD-PlayIcon-L"] forState:UIControlStateNormal];
    }
}

//上一首的按钮状态更新
- (void)preButtonUpdateState{
    
    NSString *firstMP3URLString = ((HXSongModel *)[_songArray firstObject]).mp3Url;
    if ([[MusicMgr standard] isPlayingWithUrl:firstMP3URLString]) {
        //是第一首歌 上一首的按钮不可点击状态
//        [_preButton setEnabled:NO];
    }else{
//        [_preButton setEnabled:YES];
    }
}

//下一首的按钮的状态监听
- (void)nextButtonUpdateState{
    
    NSString *endMP3URLString = ((HXSongModel *)[_songArray lastObject]).mp3Url;
    if ([[MusicMgr standard] isPlayingWithUrl:endMP3URLString]) {
        //是最后首歌 下一首的按钮不可点击状态
//        [_nextButton setEnabled:NO];
    }else{
//        [_nextButton setEnabled:YES];
    }
}

//播放进度的监听
- (void)addPlayTimeObserver{

    uint64_t interval = NSEC_PER_SEC;
    dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, 0), interval, 0);
    @weakify(self);
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
    @strongify(self);
            [self updatePlaySliderView];
        });
    });
    dispatch_resume(timer);
}

//更新Slider上面的值
- (void)updatePlaySliderView{

    MusicMgr *musicMgr = [MusicMgr standard];
    
    NSInteger musicDurationSecond = musicMgr.durationSeconds;
    NSInteger musicDurationMinute = musicDurationSecond / 60;
    
    NSInteger musicPlaySecond = musicMgr.currentPlayedSeconds;
    NSInteger musicPlayMinute = musicPlaySecond / 60;
    
    self.startTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", musicPlayMinute, (musicPlaySecond % 60)];
    self.sliderView.value = musicMgr.currentPlayedPostion;
    self.remainTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", musicDurationMinute, (musicDurationSecond % 60)];
}

#pragma mark - Button Action

- (void)sliderAction{
    
    [[MusicMgr standard] seekToPosition:_sliderView.value];
}

- (void)playAction{
    
    playState = playState?NO:YES;
    
    [_sliderView setEnabled:YES];
    
    if ([[MusicMgr standard] isCurrentHostObject:self]){
        //是当前的播放模块 那么对播放完的监听跟对播放时间的监听前面已经添加 无须再处理
        
    }else{
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(songPlayStateChange:) name:MusicMgrNotificationPlayerEvent object:nil];
        [self addPlayTimeObserver];
    }
    
    if (playState) {
        //播放
        [[MusicMgr standard] setPlayList:_songArray hostObject:self];
        [[MusicMgr standard] playCurrent];
        
        if (_songBlock) {
            _songBlock([[MusicMgr standard] currentItem],[[MusicMgr standard] currentIndex]);
        }
        
        [self preButtonUpdateState];
        [self nextButtonUpdateState];
    }else{
        //暂停
        if ([[MusicMgr standard] isPlaying]) {
            [[MusicMgr standard] pause];
        }
    }
    
    [self playButtonUpdateState];
}

- (void)nextSongAction{

    [[MusicMgr standard] playNext];
    [self preButtonUpdateState];
    [self nextButtonUpdateState];
    
    if (_songBlock) {
        _songBlock([[MusicMgr standard] currentItem],[[MusicMgr standard] currentIndex]);
    }
}

- (void)preSongAction{

    [[MusicMgr standard] playPrevios];
    [self preButtonUpdateState];
    [self nextButtonUpdateState];
    
    if (_songBlock) {
        _songBlock([[MusicMgr standard] currentItem],[[MusicMgr standard] currentIndex]);
    }
}

#pragma mark - Block

- (void)songChangeHandler:(PlaySongBlock)block{
 
    self.songBlock = nil;
    self.songBlock = block;
}

#pragma mark - Data Operation

- (void)setSongModelArray:(NSArray *)songModelArray{

    self.songArray = nil;
    self.songArray = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:songModelArray]];;
    
    for (HXSongModel *songmModel in _songArray) {
        
        NSString *mp3URLString = songmModel.mp3Url;
        if ([[MIASongManage shareSongManage] songIsExistWithURLString:mp3URLString]) {
            //存在 则替换成本地的地址
            
            songmModel.mp3Url = [NSString stringWithFormat:@"file://%@",[[MIASongManage shareSongManage] songPathWithURLString:mp3URLString]];
        }
    }
    
    [self firstPlayUpdateState];
}

- (void)playSongIndex:(NSInteger)songIndex{

    [_sliderView setEnabled:YES];
    
    playState = YES;
    
    if ([[MusicMgr standard] isCurrentHostObject:self]){
        //是当前的播放模块 那么对播放完的监听跟对播放时间的监听前面已经添加 无须再处理
        
    }else{
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(songPlayStateChange:) name:MusicMgrNotificationPlayerEvent object:nil];
        [self addPlayTimeObserver];
    }

    //播放歌曲
    [[MusicMgr standard] setPlayList:_songArray hostObject:self];
    [[MusicMgr standard] playWithIndex:songIndex];
    
    if (_songBlock) {
        _songBlock([[MusicMgr standard] currentItem],[[MusicMgr standard] currentIndex]);
    }
    
    [self preButtonUpdateState];
    [self nextButtonUpdateState];
    [self playButtonUpdateState];
}

- (NSString *)convertToTimerStringWithValue:(CGFloat)value{

   return [NSString stringWithFormat:@"%.2d:%.2d", (int)value / 60 , (int)value % 60];
}

- (NSString *)getHostObject{

    return [NSString stringWithFormat:@"%@%@",kAlbumPlayHostKey,((HXSongModel *)[_songArray firstObject]).albumID];
}

@end
