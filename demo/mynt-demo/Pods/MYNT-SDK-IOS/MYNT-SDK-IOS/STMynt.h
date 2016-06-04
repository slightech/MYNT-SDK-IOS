//
//  STMynt.h
//  STMyntCoreBluetooth
//
//  Created by gejw on 15/10/27.
//  Copyright © 2015年 Slightech, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYNT_Defines.h"

@class STMynt, STPeripheral;

@protocol STMyntDelegate <NSObject>

@optional

/**
 *  Invoked when the mynt has been discoverd
 *
 *  @param mynt
 */
- (void)myntDidDiscovered:(STMynt * _Nonnull)mynt;

/**
 *  Invoked when the mynt has been discoverd timeout
 *
 *  @param mynt
 */
- (void)myntDidDiscoveredTimeout:(STMynt * _Nonnull)mynt;

/**
 *  Invoked when the mynt has started to connect
 *
 *  @param mynt
 */
- (void)myntDidStartConnect:(STMynt * _Nonnull)mynt;

/**
 *  Invoked when a connection initiated has succeeded
 *
 *  @param mynt
 */
- (void)myntDidConnected:(STMynt * _Nonnull)mynt;

/**
 *  Invoked when a connection initiated has failed to complete
 *
 *  @param mynt
 *  @param error
 */
- (void)mynt:(STMynt * _Nonnull)mynt didConnectFailed:(NSError * _Nullable)error;

/**
 *  Invoked when a connection has been disconnected
 *
 *  @param mynt
 *  @param error
 */
- (void)mynt:(STMynt * _Nonnull)mynt didDisconnected:(NSError * _Nullable)error;

/**
 *  Invoked when the rssi of the mynt has been updated.
 *
 *  @param mynt
 *  @param RSSI the rssi of the mynt
 */
- (void)mynt:(STMynt * _Nonnull)mynt didUpdateRSSI:(NSInteger)RSSI;

/**
 *  Invoked when the battery of the mynt has been updated.
 *
 *  @param mynt
 *  @param battery the battery of the mynt
 */
- (void)mynt:(STMynt * _Nonnull)mynt didUpdateBattery:(NSInteger)battery;

/**
 *  Invoked when the alarm state of the mynt has been updated.
 *
 *  @param mynt
 *  @param alarmState the alarm state of the mynt
 */
- (void)mynt:(STMynt * _Nonnull)mynt didUpdateAlarmState:(BOOL)alarmState;

/**
 *  Invoked when the pair password of the mynt is received (just used with old mynt)
 *
 *  @param mynt
 *  @param password the password will used when the mynt is pairing
 */
- (void)mynt:(STMynt * _Nonnull)mynt didUpdatePassword:(NSString * _Nullable)password;

/**
 *  Invoked when the mynt is clicked
 *
 *  @param mynt
 *  @param clickEvent  the click type of the event (e.g. Click or Double Click)
 */
- (void)mynt:(STMynt * _Nonnull)mynt didReceiveClickEvent:(MYNTClickEvent)clickEvent;

/**
 *  Request the password to pair mynt (just for old version mynt)
 *
 *  @param mynt
 *
 *  @return password (if the password is null or empty, the mynt will repair)
 */
- (NSString * _Nullable)didRequestPassword:(STMynt * _Nonnull)mynt;

/**
 *  Request the state if the mynt need autoconnect or not
 *
 *  @param mynt
 *
 *  @return is need autoconnect ?
 */
- (BOOL)didRequestAutoconnect:(STMynt * _Nonnull)mynt;

/**
 *  Invoked when the connection exception
 *
 *  @param mynt
 */
- (void)didNeedRestartBluetooth:(STMynt * _Nonnull)mynt;

@end

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
@property (nonatomic, assign, readonly) MYNTClickType click;
// Event of the double click type
@property (nonatomic, assign, readonly) MYNTClickType doubleClick;
// Event of the triple click type
@property (nonatomic, assign, readonly) MYNTClickType tripleClick;
// Event of the long press type
@property (nonatomic, assign, readonly) MYNTClickType hold;
// Event of the click + long press type
@property (nonatomic, assign, readonly) MYNTClickType clickHold;
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

// Flag to determine the mynt is discovering or not
@property (nonatomic, assign) BOOL isDiscovering;

@property (nonatomic, weak, nullable) id<STMyntDelegate> delegate;

/**
 *  Connect mynt
 */
- (void)connect;

/**
 *  Connect mynt
 *
 *  @param pair (just used with old mynt)
 *  @param success if the mynt connect success
 *  @param failure if the mynt connect failed
 */
- (void)connect:(void (^ _Nullable)(STMynt * _Nonnull, BOOL))pair
        success:(void (^ _Nullable)(STMynt * _Nonnull))success
        failure:(void (^ _Nullable)(STMynt * _Nonnull, NSError * _Nullable))failure;

/**
 * Disconnect mynt
 */
- (void)disconnect;

@end

// MARK: =====================read & write func=====================
@interface STMynt (RW)

/**
 *  Alarm mynt or not
 *
 *  @param alarm or stop
 */
- (void)findMynt:(BOOL)alarm;

/**
 *  Update the firmware of the mynt
 *
 *  @param
 */
- (void)updateFirmware:(NSData * _Nullable (^ _Nullable)())start
              progress:(void (^ _Nullable)(CGFloat))progress
               success:(void (^ _Nullable)())success
               failure:(void (^ _Nullable)(MYNTOADError))failure;


/**
 *  Set the alarm times of the mynt
 *
 *  @param count alarm times
 */
- (void)writeAlarmCount:(NSInteger)count;

/**
 *  Set the delay time when mynt alarm
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
 *  @param eventType  event type [MYNTClickEventClick | MYNTClickEventDoubleClick | MYNTClickEventTripleClick | MYNTClickEventHold | MYNTClickEventClickHold]
 *  @param eventValue event value
 */
- (void)writeClickType:(MYNTClickEvent)eventType
            eventValue:(MYNTClickType)eventValue;


/**
 *  Set the custom click types of the mynt
 *
 *  @param click       click
 *  @param doubleClick double click
 *  @param tripleClick triple click
 *  @param hold        long press
 *  @param clickHold   click + long press
 */
- (void)writeClickType:(MYNTClickType)click
           doubleClick:(MYNTClickType)doubleClick
           tripleClick:(MYNTClickType)tripleClick
                  hold:(MYNTClickType)hold
             clickHold:(MYNTClickType)clickHold;

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
- (void)readClickType:(void(^ _Nullable)(MYNTClickType click,
                                         MYNTClickType doubleClick,
                                         MYNTClickType tripleClick,
                                         MYNTClickType hold,
                                         MYNTClickType clickHold))handler;

@end
