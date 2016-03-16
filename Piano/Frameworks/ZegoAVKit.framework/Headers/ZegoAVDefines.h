//
//  ZegoAVApiDefines.h
//  zegoavkit
//
//  Copyright © 2016 Zego. All rights reserved.
//

#ifndef ZegoAVApiDefines_h
#define ZegoAVApiDefines_h


typedef unsigned int	uint32;

typedef enum{
    FLAG_RESOLUTION = 0x1,
    FLAG_FPS = 0x2,
    FLAG_BITRATE = 0x4
}SetConfigReturnType;

typedef enum{
    ZegoVideoViewModeScaleAspectFit     = 0,    //等比缩放，可能有黑边
    ZegoVideoViewModeScaleAspectFill    = 1,    //等比缩放填充整View，可能有部分被裁减
    ZegoVideoViewModeScaleToFill        = 2,    //填充整个View
}ZegoVideoViewMode;

typedef enum{
    CustomDataType_data = 1,    //NSData存的byte数组
    CustomDataType_file = 2
}CustomDataType;

typedef enum
{
    CAPTURE_ROTATE_0    = 0,
    CAPTURE_ROTATE_90   = 90,
    CAPTURE_ROTATE_180  = 180,
    CAPTURE_ROTATE_270  = 270
}CAPTURE_ROTATE;

typedef enum
{
    RemoteViewIndex_First = 0,
    RemoteViewIndex_Second = 1
}RemoteViewIndex;


#endif /* ZegoAVApiDefines_h */
