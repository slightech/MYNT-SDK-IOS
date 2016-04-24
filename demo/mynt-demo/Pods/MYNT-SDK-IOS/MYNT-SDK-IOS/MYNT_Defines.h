//
//  mynt_defines.h
//  mynt_defines
//
//  Created by gejw on 15/12/25.
//  Copyright © 2015年 slightech. All rights reserved.
//



typedef NS_ENUM(NSInteger, MYNTClickType) {
    MYNTClickTypeNone = 0x00,
    MYNTClickTypeMusicPlay = 0x01,
    MYNTClickTypeMusicNext = 0x02,
    MYNTClickTypeMusicPrevious = 0x03,
    MYNTClickTypeMusicVolumeUp = 0x04,
    MYNTClickTypeMusicVolumeDown = 0x05,
    MYNTClickTypeCameraShutter = 0x09,
    MYNTClickTypeCameraBurst = 0x0A,
    MYNTClickTypePPTNextPage = 0x06,
    MYNTClickTypePPTPreviousPage = 0x07,
    MYNTClickTypePPTExit = 0x08,
    MYNTClickTypePhoneFlash = 0xA0,
    MYNTClickTypePhoneAlarm = 0xA1
} ;

#define MYNTControlModeString(enum) [@[@"MYNTControlModeBLE", @"MYNTControlModeMusic", @"MYNTControlModeCamera", @"MYNTControlModePPT", @"MYNTControlModeCustom", @"MYNTControlModeDefault"] objectAtIndex:enum]
typedef NS_ENUM(NSInteger, MYNTControlMode) {
    MYNTControlModeBLE = 0x00,
    MYNTControlModeMusic = 0x01,
    MYNTControlModeCamera = 0x02,
    MYNTControlModePPT = 0x03,
    MYNTControlModeCustom = 0x04,
    MYNTControlModeDefault = 0x05,
} ;

#define MYNTClickEventString(enum) [@[@"MYNTClickEventClick", @"MYNTClickEventDoubleClick", @"MYNTClickEventTripleClick", @"MYNTClickEventHold", @"MYNTClickEventClickHold", @"MYNTClickEventPhoneFlash", @"MYNTClickEventPhoneAlarm", @"MYNTClickEventPhoneAlarmOff"] objectAtIndex:enum]
typedef NS_ENUM(NSInteger, MYNTClickEvent) {
    MYNTClickEventClick = 0x01,
    MYNTClickEventDoubleClick = 0x02,
    MYNTClickEventTripleClick = 0x03,
    MYNTClickEventHold = 0x09,
    MYNTClickEventClickHold,
    MYNTClickEventPhoneFlash = 0xA0,
    MYNTClickEventPhoneAlarm = 0xA1,
    MYNTClickEventPhoneAlarmOff = 0xA2
} ;

#define MYNTInfoTypeString(enum) [@[@"MYNTInfoTypeManufaturer", @"MYNTInfoTypeModel", @"MYNTInfoTypeSn", @"MYNTInfoTypeFirmware", @"MYNTInfoTypeHardware", @"MYNTInfoTypeSoftware"] objectAtIndex:enum]
typedef NS_ENUM(NSInteger, MYNTInfoType) {
    MYNTInfoTypeManufaturer = 0,
    MYNTInfoTypeModel,
    MYNTInfoTypeSn,
    MYNTInfoTypeFirmware,
    MYNTInfoTypeHardware,
    MYNTInfoTypeSoftware,
};

// 硬件类型
typedef NS_ENUM(NSInteger, MYNTHardwareType) {
    MYNTHardwareTypeCC25XX = 0x00,
    MYNTHardwareTypeCC26XX = 0x01
};

// 固件类型
typedef NS_ENUM(NSInteger, MYNTFirmwareType) {
    MYNTFirmwareTypeBLE = 0x00,
    MYNTFirmwareTypeHID = 0x01
};

#define MYNTOADErrorString(enum) [@[@"MYNTOADErrorFileError", @"MYNTOADErrorConnectionSetError", @"MYNTOADErrorBlockWriteError", @"MYNTOADErrorDisconnected"] objectAtIndex:enum]
typedef NS_ENUM(NSInteger, MYNTOADError) {
    MYNTOADErrorFileError = 0,
    MYNTOADErrorConnectionSetError,
    MYNTOADErrorBlockWriteError,
    MYNTOADErrorDisconnected
};

typedef NS_ENUM(NSInteger, MYNTState) {
    MYNTStateDisconnected = 0, // 断开连接
    MYNTStateConnecting, // 连接中
    MYNTStateConnected, // 连接成功
};