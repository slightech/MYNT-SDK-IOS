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

@property (nonatomic, strong, readonly) NSString *name;

@property (nonatomic, strong, readonly) NSString *sn;

@property (nonatomic, strong, readonly) NSNumber *RSSI;

@property (nonatomic, weak) id<STMyntDelegate> delegate;

@property (nonatomic, weak) id<STMyntDataSource> dataSource;

- (instancetype)initWithPeripheral:(STPeripheral *)peripheral;

/**
 *  @author Robin, 15-10-27 18:10:17
 *
 *  连接
 */
- (void)connect;

/**
 *  @author Robin, 15-10-27 18:10:33
 *
 *  断开连接
 */
- (void)disconnect;

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
 *  @author Robin, 15-10-27 18:10:33
 *
 *  更新固件
 *
 *  @param delegate
 */
- (void)updateFirmware:(id<STMyntOADDelegate>)delegate;

@end
