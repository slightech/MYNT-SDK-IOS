//
//  STMynt.h
//  STMyntCoreBluetooth
//
//  Created by gejw on 15/10/27.
//  Copyright © 2015年 robinge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STMyntDelegate.h"

@class STPeripheral;
@interface STMynt : NSObject

/**
 *  @author Robin, 15-11-30 15:11:14
 *
 *  设备名
 */
@property (nonatomic, strong, readonly) NSString *name;

/**
 *  @author Robin, 15-11-30 15:11:10
 *
 *  序列号
 */
@property (nonatomic, strong, readonly) NSString *sn;

/**
 *  @author Robin, 15-11-30 15:11:10
 *
 *  序列号
 */
@property (nonatomic, strong, readonly) NSString *UUIDString;

/**
 *  @author Robin, 15-11-30 15:11:56
 *
 *  是否自动连接
 */
@property (nonatomic, assign, readonly) BOOL HID;

/**
 *  @author Robin, 15-11-30 15:11:37
 *
 *  信号强度
 */
@property (nonatomic, strong, readonly) NSNumber *RSSI;

/**
 *  @author Robin, 15-12-01 16:12:49
 *
 *  状态
 */
@property (nonatomic, assign, readonly) CBPeripheralState state;

@property (nonatomic, weak) id<STMyntDelegate> delegate;

@property (nonatomic, weak) id<STMyntBindDelegate> bindDelegate;

- (instancetype)initWithPeripheral:(STPeripheral *)peripheral;

/**
 *  @author Robin, 15-10-27 18:10:17
 *
 *  连接
 */
- (void)connect;

/**
 *  @author Robin, 15-11-27 16:11:28
 *
 *  断开连接
 *
 */
- (void)disconnect;

/**
 *  @author Robin, 15-11-30 15:11:44
 *
 *  移除设备
 */
- (void)remove;

/**
 *  @author Robin, 15-10-27 18:10:06
 *
 *  寻找小觅（小觅持续报警40s）
 *
 *  @param alarm 是否报警
 */
- (void)findMynt:(BOOL)alarm;

/**
 *  @author Robin, 15-10-27 18:10:28
 *
 *  报警
 *
 *  @param alarm 是否报警
 */
- (void)alarm:(BOOL)alarm;

/**
 *  @author Robin, 15-10-27 18:10:18
 *
 *  读取电量
 */
- (void)readBattery;

/**
 *  @author Robin, 15-12-02 16:12:43
 *
 *  读取设备信息
 */
- (void)readDeviceInfo;

/**
 *  @author Robin, 15-10-27 18:10:30
 *
 *  设置报警次数
 *
 *  @param count 次数
 */
- (void)setAlarmCount:(int)count;

/**
 *  @author Robin, 15-10-27 18:10:11
 *
 *  设置延时报警
 *
 *  @param seconds 延时时间(单位:s)
 */
- (void)setAlarmDelay:(int)seconds;

/**
 *  @author Robin, 15-12-02 20:12:20
 *
 *  设置hid
 *
 *  @param mode 模式
 */
- (void)setHIDMode:(STPeripheralHIDMode)mode;

/**
 *  @author Robin, 15-12-02 20:12:52
 *
 *  读取hid模式
 *
 *  @param handler
 */
- (void)readHIDMode:(void(^)(STPeripheralHIDMode mode))handler;

/**
 *  @author Robin, 15-10-27 18:10:33
 *
 *  更新固件
 *
 *  @param delegate
 */
- (void)updateFirmware:(id<STMyntOADDelegate>)delegate;

@end
