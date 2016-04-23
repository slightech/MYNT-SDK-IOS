//
//  STMyntBluetooth.h
//  STMyntCoreBluetooth
//
//  Created by gejw on 16/3/25.
//  Copyright © 2016年 robinge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STMynt.h"

@class STMyntBluetooth;
@protocol STMyntBluetoothDelegate <NSObject>

@optional

- (void)myntBluetooth:(STMyntBluetooth * _Nonnull)myntBluetooth didUpdateState:(CBCentralManagerState)state;

- (void)myntBluetooth:(STMyntBluetooth * _Nonnull)myntBluetooth didDiscoverMynt:(STMynt * _Nonnull)mynt;

- (void)myntBluetooth:(STMyntBluetooth * _Nonnull)myntBluetooth didDiscoverTimeoutMynt:(STMynt * _Nonnull)mynt;

@end

@interface STMyntBluetooth : NSObject

@property (nonatomic, assign) BOOL isScanning;
// 是否帮助报丢
@property (nonatomic, assign) BOOL reportLost;
// userid(用于帮助报丢)
@property (nonatomic, strong, nullable) NSString *userID;
// 蓝牙状态
@property (nonatomic, assign) CBCentralManagerState centralState;
// delegate
@property (nonatomic, weak, nullable) id<STMyntBluetoothDelegate> delegate;

/**
 *  @author Robin
 *
 *  蓝牙SDK单例
 *
 *  @return
 */
+ (instancetype _Nonnull)sharedInstance;

- (STMynt * _Nullable)findMyntWithSn:(NSString * _Nonnull)sn;

/**
 *  @author Robin
 *
 *  开始搜索
 *
 *  @param block
 */
- (void)startScan;

/**
 *  @author Robin
 *
 *  停止搜索
 */
- (void)stopScan;

@end
