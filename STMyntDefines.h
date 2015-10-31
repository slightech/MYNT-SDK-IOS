//
//  STEnumDefines.h
//  STMyntCoreBluetooth
//
//  Created by gejw on 15/10/27.
//  Copyright © 2015年 robinge. All rights reserved.
//

#ifndef STEnumDefines_h
#define STEnumDefines_h
#endif /* STEnumDefines_h */

#define ST_BLUETOOTH_POWERON @"ST_BLUETOOTH_POWERON"
#define ST_BLUETOOTH_POWEROFF @"ST_BLUETOOTH_POWEROFF"

typedef NS_ENUM(NSInteger, STOADErrorCode) {
    _FILE_ERROR,
    _CONNECTION_SET_ERROR,
    _BLOCK_WRITE_ERROR
};

typedef NS_ENUM(NSInteger, STPeripheralInfoType) {
    _MANUFACTURER,
    _MODEL,
    _SN,
    _FIRMWARE,
    _HARDWARE,
    _SOFTWARE,
};

typedef NS_ENUM(NSInteger, STPeripheralEventType) {
    _CLICK,
    _DOUBLECLICK,
    _TRIPLECLICK,
    _LONGPRESS
};