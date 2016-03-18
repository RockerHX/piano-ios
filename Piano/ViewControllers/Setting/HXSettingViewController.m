//
//  HXSettingViewController.m
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXSettingViewController.h"
#import "HXSettingSession.h"

@interface HXSettingViewController () <
UIPickerViewDataSource,
UIPickerViewDelegate
>
@end

@implementation HXSettingViewController {
    NSArray *_qualities;
}

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameSetting;
}

+ (NSString *)navigationControllerIdentifier {
    return @"HXSettingNavigationController";
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    _qualities = @[@"超低质量", @"低质量", @"普通质量", @"高质量", @"超高质量", @"自定义"];
    [self loadDefaultConfigure];
}

- (void)viewConfigure {
    ;
}

- (void)loadDefaultConfigure {
    HXSettingSession *session = [HXSettingSession share];
//    if ([ud objectForKey:@"accountID"] == nil){
//        [self generateAcount];
//        [self presetLiveQuality];
//        
//        self.lablePrompt.hidden = false;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            self.lablePrompt.hidden = true;
//        });
//    }
//    
//    self.accountID.text = [[NSString alloc] initWithFormat:@"%u", (UInt32)[ud doubleForKey:@"accountID"]];
//    self.accountName.text = [ud stringForKey:@"accountName"];
//    
//    NSString *strPic = [ud stringForKey:@"accountPic"];
//    [self.accountPic setImage:[UIImage imageNamed:strPic]];
    
    [self updateLiveQualityDetails:session.configPreset];
    
    NSInteger rowSelected = session.configPreset;
    if ([session isCustomConfigure]) {
        //自定义参数时，列表项为最后一项
        rowSelected = _qualities.count - 1;
    }
    [self pickerViewSelectRowWithRow:rowSelected];
}

#pragma mark - Event Response
- (IBAction)resolutionSliderChanged:(UISlider *)sender {
    ZegoAVConfig *zegoAVConfig= [ZegoAVConfig defaultZegoAVConfig:ZegoAVConfigPreset_Verylow];
    [zegoAVConfig setVideoResolution:(int)sender.value];
    
    CGSize szResolution = [zegoAVConfig getVideoResolution];
    
    _resolutionLabel.text = [NSString stringWithFormat:@"%@ x %@", @(szResolution.width), @(szResolution.height)];
    
    [self pickerViewSelectRowWithRow:(_qualities.count - 1)];
    
    [[HXSettingSession share] updateCustomResolution:@(sender.value).integerValue];
}

- (IBAction)fpsSliderChanged:(UISlider *)sender {
    _fpsLabel.text = [NSString stringWithFormat:@"%@", @(sender.value).stringValue];
    
    [self pickerViewSelectRowWithRow:(_qualities.count - 1)];
    
    [[HXSettingSession share] updateCustomFPS:@(sender.value).integerValue];
}

- (IBAction)bitrateSliderChanged:(UISlider *)sender {
    _bitrateLabel.text = [NSString stringWithFormat:@"%@", @(sender.value).stringValue];
    
    [self pickerViewSelectRowWithRow:(_qualities.count - 1)];
    
    [[HXSettingSession share] updateCustomBitrate:@(sender.value).integerValue];
}

#pragma mark - Private Methods
- (void)updateLiveQualityDetails:(ZegoAVConfigPreset)preset {
    NSInteger resolution, fps, bitrate;
    CGSize resolutionSize;
    
    HXSettingSession *session = [HXSettingSession share];
    if ([session isCustomConfigure]) {
        //自定义各种参数
        resolution = session.customResolution;
        fps = session.customFPS;
        bitrate = session.customBitrate;
        
        ZegoAVConfig *zegoAVConfig= [ZegoAVConfig defaultZegoAVConfig:ZegoAVConfigPreset_Verylow];
        [zegoAVConfig setVideoResolution:(ZegoAVConfigVideoResolution)resolution];
        
        resolutionSize = [zegoAVConfig getVideoResolution];
    } else {
        ZegoAVConfig *zegoAVConfig= [ZegoAVConfig defaultZegoAVConfig:preset];
        resolution = 0;
        resolutionSize = [zegoAVConfig getVideoResolution];
        switch ((NSInteger)resolutionSize.width) {
            case 320:
                resolution = 0;
                break;
            case 352:
                resolution = 1;
                break;
            case 640:
                resolution = 2;
                break;
            case 960:
                resolution = 3;
                break;
            case 1280:
                resolution = 4;
                break;
            case 1920:
                resolution = 5;
                break;
                
            default:
                resolution = -1;
                break;
        }
        
        fps = [zegoAVConfig getVideoFPS];
        bitrate = [zegoAVConfig getVideoBitrate];
        
        [self updateParametersWithResolution:resolution fps:fps bitrate:bitrate];
    }
    
    //Update UI
    _resolutionSlider.value = resolution;
    _fpsSlider.value = fps;
    _bitrateSlider.value = bitrate;
    
    _resolutionLabel.text = [NSString stringWithFormat:@"%@ x %@", @(resolutionSize.width).stringValue, @(resolutionSize.height).stringValue];
    _fpsLabel.text = @(fps).stringValue;
    _bitrateLabel.text = @(bitrate).stringValue;
}

- (void)updateParametersWithResolution:(NSInteger)resolution fps:(NSInteger)fps bitrate:(NSInteger)bitrate {
    HXSettingSession *session = [HXSettingSession share];
    [session updateParametersWithResolution:(ZegoAVConfigVideoResolution)resolution fps:(ZegoAVConfigVideoFps)fps bitrate:(ZegoAVConfigVideoBitrate)bitrate];
}

- (void)pickerViewSelectRowWithRow:(NSInteger)row {
    [_liveQualityPicker selectRow:row inComponent:0 animated:YES];
}

#pragma mark - UIPickerViewDataSource Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _qualities.count;
}

#pragma mark - UIPickerViewDelegate Methods
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _qualities[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    HXSettingSession *session = [HXSettingSession share];
    ZegoAVConfigPreset configPreset = (ZegoAVConfigPreset)row;
    if (row < (_qualities.count - 1)) {
        [session updateConfigPreset:configPreset];
    } else {
        //自定义
        configPreset = -1;
        [session updateConfigPreset:configPreset];
    }
    [self updateLiveQualityDetails:configPreset];
}

@end
