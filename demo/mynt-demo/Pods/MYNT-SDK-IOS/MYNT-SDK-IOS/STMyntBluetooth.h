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
@property (nonatomic, assign) BOOL isScanning;
// Help others find the mynt
@property (nonatomic, assign) BOOL reportLost;
// The current state of the bluetooth
@property (nonatomic, assign) CBCentralManagerState centralState;
// Delegate
@property (nonatomic, weak, nullable) id<STMyntBluetoothDelegate> delegate;

+ (instancetype _Nonnull)sharedInstance;

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
 *  Retrieves all mynts that are connected to the system (not only in app)
 *
 *  @return
 */
- (NSArray <STMynt *> * _Nullable)retrieveConnectedMynts;

/**
 *  get the mynt with sn
 *
 *  @param sn the sn of the mynt
 *
 *  @return
 */
- (STMynt * _Nullable)findMyntWithSn:(NSString *_Nonnull)sn;

@end
