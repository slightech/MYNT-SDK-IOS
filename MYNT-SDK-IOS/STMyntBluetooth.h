//
//  STMyntBluetooth.h
//  STMyntCoreBluetooth
//
//  Created by gejw on 16/3/25.
//  Copyright © 2016年 Slightech, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STMynt.h"

@class STMyntBluetooth;
@protocol STMyntBluetoothDelegate <NSObject>

@optional

/**
 *  Invoked when the central manager's state has been updated.
 *
 *  @param myntBluetooth
 *  @param state         the current state of the bluetooth
 */
- (void)myntBluetooth:(STMyntBluetooth * _Nonnull)myntBluetooth didUpdateState:(CBCentralManagerState)state;

/**
 *  Invoked when the mynt has been discoverd.
 *
 *  @param myntBluetooth
 *  @param mynt
 */
- (void)myntBluetooth:(STMyntBluetooth * _Nonnull)myntBluetooth didDiscoverMynt:(STMynt * _Nonnull)mynt;

/**
 *  Invoked when the mynt has been discoverd timeout.
 *
 *  @param myntBluetooth
 *  @param mynt
 */
- (void)myntBluetooth:(STMyntBluetooth * _Nonnull)myntBluetooth didDiscoverTimeoutMynt:(STMynt * _Nonnull)mynt;

/**
 *  Invoked if you need filter the mynts.
 *
 *  @param myntBluetooth
 *  @param sn            the sn of the mynt when the mynt is discoverd.
 *
 *  @return if this mynt need filter(don't ues it), so you can need true.
 */
- (BOOL)myntBluetooth:(STMyntBluetooth * _Nonnull)myntBluetooth didFilterMyntWithSn:(NSString * _Nonnull)sn;

@end

@interface STMyntBluetooth : NSObject
// Flag to determine if the manager is scanning
@property (nonatomic, assign) BOOL isScanning;
// Help others find the mynt
@property (nonatomic, assign) BOOL reportLost;
// TODO: userid
@property (nonatomic, strong, nullable) NSString *userID;
// The current state of the bluetooth
@property (nonatomic, assign) CBCentralManagerState centralState;
// Delegate
@property (nonatomic, weak, nullable) id<STMyntBluetoothDelegate> delegate;

+ (instancetype _Nonnull)sharedInstance;

/**
 *  Get mynt with sn
 *
 *  @param sn the sn of the mynt
 *
 *  @return mynt
 */
- (STMynt * _Nullable)findMyntWithSn:(NSString * _Nonnull)sn;

/**
 *  Start scanning for mynts.
 *
 *  @param block
 */
- (void)startScan;

/**
 *  Stop scanning for mynts.
 */
- (void)stopScan;

@end
