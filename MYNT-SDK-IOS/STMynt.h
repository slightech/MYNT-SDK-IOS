//
//  STMynt.h
//  STMyntCoreBluetooth
//
//  Created by gejw on 15/10/27.
//  Copyright © 2015年 Slightech, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STConstants.h"

@interface STMynt : NSObject

// The name of the mynt
@property (nonatomic, strong, readonly, nonnull) NSString *name;
// The current RSSI of peripheral, in dBm. A value of 127is reserved and indicates the RSSI
@property (nonatomic, assign) NSInteger RSSI;
// FirmwareType (BLE | HID)
@property (nonatomic, assign, readonly) MYNTFirmwareType firmwareType;
// HardwareType (CC25 | CC26)
@property (nonatomic, assign, readonly) MYNTHardwareType hardwareType;
// The current connection state of the mynt
@property (nonatomic, assign, readonly) MYNTState state;

// Battery of the mynt
@property (nonatomic, assign, readonly) NSInteger battery;
// Control mode
@property (nonatomic, assign, readonly) MYNTControlMode controlMode;
// Event of the click type
@property (nonatomic, assign, readonly) MYNTClickValue click;
// Event of the double click type
@property (nonatomic, assign, readonly) MYNTClickValue doubleClick;
// Event of the triple click type
@property (nonatomic, assign, readonly) MYNTClickValue tripleClick;
// Event of the long press type
@property (nonatomic, assign, readonly) MYNTClickValue hold;
// Event of the click + long press type
@property (nonatomic, assign, readonly) MYNTClickValue clickHold;
// manufaturer of the mynt
@property (nonatomic, strong, readonly, nullable) NSString *manufaturer;
// Model of the mynt
@property (nonatomic, strong, readonly, nullable) NSString *model;
// SN of the mynt
@property (nonatomic, strong, readonly, nonnull) NSString *sn;
// Firmware of the mynt
@property (nonatomic, strong, readonly, nullable) NSString *firmware;
// Hardware of the mynt
@property (nonatomic, strong, readonly, nullable) NSString *hardware;
// Software of the mynt
@property (nonatomic, strong, readonly, nullable) NSString *software;
// MAC address of the mynt
@property (nonatomic, strong, readonly, nullable) NSString *mac;

// Flag to determine the mynt is discovering or not
@property (nonatomic, assign) BOOL isDiscovering;

@property (nonatomic, weak, nullable) id<STMyntDelegate> delegate;

/**
 *  Connect mynt
 */
- (void)connect;

/**
 * Disconnect mynt
 */
- (void)disconnect;

/**
 *  Alarm mynt or not (alarm will alarm 40s)
 *
 *  @param alarm alarm or stop
 */
- (void)toggleAlarm:(BOOL)alarm;

/**
 *  Set how many times MYNT will alarm after the bluetooth connection broken
 *
 *  @param count alarm times
 */
- (void)writeAlarmCount:(NSInteger)count;

/**
 *  Set how long the alarm will be delayed after the bluetooth connection broken
 *
 *  @param seconds delay time(units: second)
 */
- (void)writeAlarmDelay:(NSInteger)seconds;

/**
 *  Set the control mode of the mynt
 *
 *  @param mode control mode
 */
- (void)writeControlMode:(MYNTControlMode)mode;

/**
 *  Set the custom click type of the mynt
 *
 *  @param clickEvent  click event
 *  @param eventValue  event value
 */
- (void)writeClickValue:(MYNTClickEvent)clickEvent
            eventValue:(MYNTClickValue)eventValue;


/**
 *  Set the custom click types of the mynt
 *
 *  @param click       click
 *  @param doubleClick double click
 *  @param tripleClick triple click
 *  @param hold        long press
 *  @param clickHold   click + long press
 */
- (void)writeClickValue:(MYNTClickValue)click
           doubleClick:(MYNTClickValue)doubleClick
           tripleClick:(MYNTClickValue)tripleClick
                  hold:(MYNTClickValue)hold
             clickHold:(MYNTClickValue)clickHold;

/**
 *  Read the battery state of the mynt
 *
 *  @param battery
 */
- (void)readBattery:(void (^ _Nullable)(NSInteger battery))battery;

/**
 *  Read the rssi of the mynt
 */
- (void)readRSSI;

/**
 *  Read the deviceInfo of the mynt
 *
 *  @param type    info type
 *  @param handler
 */
- (void)readMyntInfo:(MYNTInfoType)type
             handler:(void(^ _Nullable)(NSString * _Nullable))handler;

/**
 *  Read the controlMode of the mynt
 *
 *  @param handler
 */
- (void)readControlMode:(void(^ _Nullable)(MYNTControlMode mode))handler;

/**
 *  Read the custom click types of the mynt
 *
 *  @param handler
 */
- (void)readClickValue:(void(^ _Nullable)(MYNTClickValue click,
                                          MYNTClickValue doubleClick,
                                          MYNTClickValue tripleClick,
                                          MYNTClickValue hold,
                                          MYNTClickValue clickHold))handler;

/**
 *  Update the firmware of the mynt
 *
 *  @param
 */
- (void)updateFirmware:(NSData * _Nullable (^ _Nullable)())start
              progress:(void (^ _Nullable)(CGFloat))progress
               success:(void (^ _Nullable)())success
               failure:(void (^ _Nullable)(MYNTOADError))failure;

@end
