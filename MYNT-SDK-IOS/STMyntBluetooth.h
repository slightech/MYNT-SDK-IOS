//
//  STMyntBluetooth.h
//  STMyntCoreBluetooth
//
//  Created by gejw on 16/3/25.
//  Copyright © 2016年 Slightech, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STMynt.h"

@interface STMyntBluetooth : NSObject
// Flag to determine if the manager is scanning
@property (nonatomic, assign, readonly) BOOL isScanning;
// The current state of the bluetooth
@property (nonatomic, assign, readonly) CBCentralManagerState centralState;
// Help others find the mynt
@property (nonatomic, assign) BOOL isReportUnknownMynt;
// Delegate
@property (nonatomic, weak, nullable) id<STMyntBluetoothDelegate> delegate;

+ (instancetype _Nonnull)sharedInstance;

/**
 *  Set the AppKey
 *
 *  @param appKey
 */
- (void)setMyntAppKey:(NSString * _Nonnull)appKey;

/**
 *  The params will upload when uploading the found devices
 *
 *  @param params Customize parameters
 */
- (void)setCustomParams:(NSString * _Nullable)params;

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

/**
 *  get the mynt with sn
 *
 *  @param sn the sn of the mynt
 *
 *  @return
 */
- (STMynt * _Nullable)findMyntWithSn:(NSString *_Nonnull)sn;

@end
