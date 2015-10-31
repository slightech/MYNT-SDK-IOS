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

#if TARGET_OS_IOS

/**
 *  @author Robin, 15-10-31 18:10:46
 *
 *  即将恢复的设备(程序被杀掉之后   会自动恢复设备, 请在这个时候设置相应的delegate  接收回调信息)
 *  只针对于 ios
 *
 *  @param central 中心
 *  @param mynt    周边
 */
- (void)central:(STMyntCentralManager*)central willRestoreMynt:(STMynt *)mynt;

#endif

@end

#pragma STMyntDelegate

@protocol STMyntDelegate <NSObject>

/**
 *  @author Robin, 15-10-29 21:10:26
 *
 *  开始连接
 *
 *  @param mynt
 *  @param error
 */
- (void)mynt:(STMynt *)mynt didStartConnect:(NSError *)error;

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
 *  @author Robin, 15-10-29 21:10:54
 *
 *  开始绑定
 *
 *  @param mynt
 */
- (void)myntDidStartBind:(STMynt *)mynt;

/**
 *  @author Robin, 15-10-29 21:10:59
 *
 *  绑定成功
 *
 *  @param mynt
 */
- (void)myntDidBindSuccess:(STMynt *)mynt;

/**
 *  @author Robin, 15-10-29 21:10:06
 *
 *  绑定失败
 *
 *  @param mynt
 *  @param error
 */
- (void)mynt:(STMynt *)mynt didBindFailed:(NSError *)error;

/**
 *  @author Robin, 15-10-29 21:10:18
 *
 *  接收密码
 *
 *  @param mynt
 *  @param password
 */
- (void)mynt:(STMynt *)mynt didReceivePassword:(NSString *)password;

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

@end

#pragma STMyntDataSource

@protocol STMyntDataSource <NSObject>

/**
 *  @author Robin, 15-10-29 16:10:55
 *
 *  请求秘钥
 *
 *  @param mynt
 *  @param msg (暂时没啥效果  用于sdk向上层提示信息)
 *
 *  @return
 */
- (NSString *)mynt:(STMynt *)mynt didRequestPassword:(NSString *)msg;

@end

#pragma STMyntDataSource

@protocol STMyntOADDelegate <NSObject>

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


