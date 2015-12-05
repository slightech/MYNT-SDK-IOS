//
//  STMyntDelegate.h
//  STMyntCoreBluetooth
//
//  Created by gejw on 15/10/27.
//  Copyright © 2015年 robinge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STMyntDefines.h"

typedef STPeripheralInfoType STMyntInfoType;
typedef STPeripheralEventType STMyntEventType;

@class STMynt;
@class STMyntCentralManager;

#pragma STMyntCentralDelegate

@protocol STMyntCentralDelegate <NSObject>
@optional

/**
 *  @author Robin, 15-10-27 16:10:07
 *
 *  发现设备
 *
 *  @param central    中心
 *  @param peripheral 周边
 */
- (void)central:(STMyntCentralManager*)central didFoundMynt:(STMynt *)mynt;

/**
 *  @author Robin, 15-10-27 16:10:19
 *
 *  发现设备超时 默认20秒没发现  为消失
 *
 *  @param central    中心
 *  @param peripheral 周边
 */
- (void)central:(STMyntCentralManager*)central didDisfoundMynt:(STMynt *)mynt;

/**
 *  @author Robin, 15-12-01 15:12:53
 *
 *  状态恢复的设备
 *
 *  @param central <#central description#>
 *  @param mynt    <#mynt description#>
 */
- (void)central:(STMyntCentralManager *)central didRestoreMynt:(STMynt *)mynt;

/**
 *  @author Robin, 15-12-01 15:12:17
 *
 *  准备重连的设备
 *
 *  @param central
 *  @param mynt
 */
- (void)central:(STMyntCentralManager*)central willReconnectMynt:(STMynt *)mynt;

@end

#pragma STMyntDelegate

@protocol STMyntDelegate <NSObject>
@optional

/**
 *  @author Robin, 15-10-29 21:10:34
 *
 *  连接成功
 *
 *  @param mynt
 */
- (void)myntDidConnectSuccess:(STMynt *)mynt;

/**
 *  @author Robin, 15-10-29 21:10:40
 *
 *  连接失败
 *
 *  @param mynt
 *  @param error
 */
- (void)mynt:(STMynt *)mynt didConnectFailed:(NSError *)error;

/**
 *  @author Robin, 15-10-29 21:10:47
 *
 *  断开连接
 *
 *  @param mynt
 *  @param error
 */
- (void)mynt:(STMynt *)mynt didDisconnect:(NSError *)error;

/**
 *  @author Robin, 15-12-05 14:12:52
 *
 *  是否开始绑定
 *
 *  @param mynt
 *  @param HID
 */
- (void)mynt:(STMynt *)mynt willStartBind:(BOOL)HID;

/**
 *  @author Robin, 15-10-29 21:10:28
 *
 *  接收RSSI
 *
 *  @param mynt
 *  @param RSSI
 */
- (void)mynt:(STMynt *)mynt didReadRSSI:(NSNumber *)RSSI;

/**
 *  @author Robin, 15-10-29 21:10:37
 *
 *  读取电量
 *
 *  @param mynt
 *  @param battery
 */
- (void)mynt:(STMynt *)mynt didReadBattery:(NSNumber *)battery;

/**
 *  @author Robin, 15-10-29 21:10:45
 *
 *  读取mynt信息
 *
 *  @param mynt
 *  @param myntInfo
 *  @param infoType
 */
- (void)mynt:(STMynt *)mynt didReadMyntInfo:(NSString *)myntInfo
    infoType:(STMyntInfoType)infoType;

/**
 *  @author Robin, 15-10-29 21:10:52
 *
 *  固件发现新版本
 *
 *  @param mynt
 *  @param lastVersion
 */
- (void)mynt:(STMynt *)mynt didFindNewFirmware:(NSNumber *)lastVersion;

/**
 *  @author Robin, 15-10-29 21:10:02
 *
 *  收到点击事件
 *
 *  @param mynt
 *  @param event
 */
- (void)mynt:(STMynt *)mynt didMyntEvent:(STMyntEventType)event;

/**
 *  @author Robin, 15-10-29 21:10:17
 *
 *  小觅响铃
 *
 *  @param mynt
 *  @param alarm 
 */
- (void)mynt:(STMynt *)mynt didAlarmState:(BOOL)alarm;

/**
 *  @author Robin, 15-12-02 20:12:28
 *
 *  hid模式
 *
 *  @param mynt
 *  @param mode 
 */
- (void)mynt:(STMynt *)mynt didReadHIDMode:(STPeripheralHIDMode)mode;

@end

#pragma STMyntDataSource

@protocol STMyntBindDelegate <NSObject>
@optional

/**
 *  @author Robin, 15-12-01 17:12:14
 *
 *  开始绑定
 *
 *  @param peripheral 周边
 */
- (void)didStartBind:(STMynt *)mynt;

/**
 *  @author Robin, 15-12-01 17:12:02
 *
 *  向上层请求秘钥
 *
 *  @param peripheral
 *
 *  @return 秘钥(如果为nil，则为请求秘钥)
 */
- (NSString *)didRequestPassword:(STMynt *)mynt;

/**
 *  @author Robin, 15-10-27 14:10:37
 *
 *  绑定结果
 *
 *  @param peripheral 周边
 *  @param error      错误信息(成功时为nil)
 */
- (void)mynt:(STMynt *)mynt didBindResult:(NSError *)error;

/**
 *  @author Robin, 15-10-27 14:10:10
 *
 *  收到密钥
 *
 *  @param peripheral 周边
 *  @param password   密码
 */
- (void)mynt:(STMynt *)mynt didReceivePassword:(NSString *)password;

@end

#pragma STMyntDataSource

@protocol STMyntOADDelegate <NSObject>
@optional

/**
 *  @author Robin, 15-10-29 16:10:02
 *
 *  oad开始
 *
 *  @param mynt    mynt
 *  @param imgName 正在刷入的固件名
 */
- (void)oad:(STMynt *)mynt didStart:(NSString *)imgName;

/**
 *  @author Robin, 15-10-29 16:10:43
 *
 *  oad开始
 *
 *  @param mynt     mynt
 *  @param progress 进度
 *  @param time     剩余时间
 */
- (void)oad:(STMynt *)mynt didProgress:(float)progress time:(NSString *)time;

/**
 *  @author Robin, 15-10-29 16:10:31
 *
 *  oad成功
 *
 *  @param mynt mynt
 */
- (void)oadDidComplete:(STMynt *)mynt;

/**
 *  @author Robin, 15-10-29 16:10:52
 *
 *  oad错误
 *
 *  @param mynt mynt
 *  @param error 错误码
 */
- (void)oad:(STMynt *)mynt error:(STOADErrorCode)error;

@end


