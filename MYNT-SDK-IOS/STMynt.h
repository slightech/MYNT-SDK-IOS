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

@property (nonatomic, weak, nullable) id<STMyntDelegate> delegate;

// The name of the mynt
@property (nonatomic, strong, readonly, nonnull) NSString *name;
// The current RSSI of peripheral, in dBm. A value of 127is reserved and indicates the RSSI
@property (nonatomic, assign, readonly) NSInteger RSSI;
// Battery of the mynt
@property (nonatomic, assign, readonly) NSInteger battery;
// Flag to determine the mynt is discovering or not
@property (nonatomic, assign, readonly) BOOL isDiscovering;
// HardwareType (MYNTV1 | MYNTV2 | MYNTGPS )
@property (nonatomic, assign, readonly) MYNTHardwareType hardwareType;
// The current connection state of the mynt
@property (nonatomic, assign, readonly) MYNTState state;
// The current connection state of the mynt
@property (nonatomic, assign, readonly) BOOL isAlarm;

// The running mode of the mynt
@property (nonatomic, assign, readonly) BOOL isHIDMode;
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

# pragma mynt info
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
- (void)toggleAlarm:(BOOL)alarm
            handler:(void(^ _Nullable)(NSError * _Nullable error))handler;

/**
 *  Set how many times MYNT will alarm after the bluetooth connection broken
 *
 *  @param count alarm times
 */
- (void)writeAlarmCount:(NSInteger)count
                handler:(void(^ _Nullable)(NSError * _Nullable error))handler;

/**
 *  Set how long the alarm will be delayed after the bluetooth connection broken
 *
 *  @param seconds delay time(units: second)
 */
- (void)writeAlarmDelay:(NSInteger)seconds
                handler:(void(^ _Nullable)(NSError * _Nullable error))handler;

/**
 *  Set the custom click types of the mynt
 *
 *  @param click       click
 *  @param doubleClick double click
 *  @param tripleClick triple click
 *  @param hold        long press
 *  @param clickHold   click + long press
 */
- (void)writeClickValue:(BOOL)isHIDMode
                  click:(MYNTClickValue)click
            doubleClick:(MYNTClickValue)doubleClick
            tripleClick:(MYNTClickValue)tripleClick
                   hold:(MYNTClickValue)hold
              clickHold:(MYNTClickValue)clickHold
                handler:(void(^ _Nullable)(NSError * _Nullable error))handler;

/**
 *  Read the battery state of the mynt
 *
 *  @param success
 *  @param failure
 */
- (void)readBattery:(void (^ _Nullable)(NSArray<NSNumber *> * _Nonnull batteries))success
            failure:(void(^ _Nullable)(NSError * _Nullable error))failure;

/**
 *  Read the rssi of the mynt
 */
- (void)readRSSI:(void(^ _Nullable)(NSError * _Nullable error))handler;

/**
 *  Read the custom click types of the mynt
 *
 *  @param success
 *  @param failure
 */
- (void)readClickValue:(void(^ _Nullable)(MYNTClickValue click,
                                          MYNTClickValue doubleClick,
                                          MYNTClickValue tripleClick,
                                          MYNTClickValue hold,
                                          MYNTClickValue clickHold))success
               failure:(void(^ _Nullable)(NSError * _Nullable error))failure;

/**
 *  Update the firmware of the mynt
 *
 *  @param
 */
- (void)updateFirmware:(NSData * _Nullable (^ _Nullable)())start
              progress:(void (^ _Nullable)(CGFloat))progress
               success:(void (^ _Nullable)())success
               failure:(void (^ _Nullable)(NSError * _Nullable error))failure;

/**
 *  Set the ringtone data of the mynt
 *
 *  @param  data
 *  @param  version
 *  @param  handler
 *
 **/
- (void)writeRingtone:(NSData * _Nonnull)data
              version:(int)version
              handler:(void(^ _Nullable)(NSError * _Nullable error))handler;

/**
 *  Read the version of the ringtone in mynt
 *
 *  @param  handler
 *
 **/
- (void)readRingtoneVersion:(void (^ _Nullable)(NSInteger version, NSError * _Nullable error))handler;

@end

// MARK: - GPS
@interface STMynt (MYNT_GPS)

/**
 * Synchronised time (for GPS)
 *
 * @param complete
 */
- (void)syncTime:(void (^ _Nullable)(NSError * _Nullable))handler;

/**
 * Turn off the mynt (for GPS)
 *
 * @param complete
 */
- (void)shutdown:(void (^ _Nullable)(NSError * _Nullable error))handler;

/**
 * Set the apn of the mynt (for GPS)
 *
 * @param apn
 * @param handler
 */
- (void)writeAPN:(NSString * _Nonnull)apn
         handler:(void (^ _Nullable)(NSError * _Nullable error))handler;

/**
 * Set the locate interval of the mynt (for GPS)
 *
 * @param minute
 * @param handler
 */
- (void)writeLocateInterval:(NSInteger)minute
                    handler:(void (^ _Nullable)(NSError * _Nullable error))handler;

/**
 * Read the locate interval of the mynt (for GPS)
 *
 * @param handler
 */
- (void)readLocateInterval:(void (^ _Nullable)(NSInteger interval, NSError * _Nullable error))handler;

/**
 * Read the iccid of the sim card
 *
 * @param handler (for GPS)
 */
- (void)readICCID:(void (^ _Nullable)(NSString * _Nullable iccic, NSError * _Nullable error))handler;

/**
 * Check the state of the sim card
 *
 * @param handler (for GPS)
 */
- (void)checkNetwork:(void (^ _Nullable)(NSError * _Nullable))handler;

@end
