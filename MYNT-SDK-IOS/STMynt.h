//
//  STMynt.h
//  STMyntCoreBluetooth
//
//  Created by gejw on 15/10/27.
//  Copyright © 2015年 robinge. All rights reserved.
//

#import <Foundation/Foundation.h>
#if TARGET_OS_IOS
    #import <UIKit/UIKit.h>
    #import <CoreBluetooth/CoreBluetooth.h>
#else
    #import <IOBluetooth/IOBluetooth.h>
#endif
#import "MYNT_Defines.h"

@class STMynt, STPeripheral;
@protocol STMyntDelegate <NSObject>

@optional

- (void)myntDidDiscovered:(STMynt * _Nonnull)mynt;

- (void)myntDidDiscoveredTimeout:(STMynt * _Nonnull)mynt;

- (void)myntDidStartConnect:(STMynt * _Nonnull)mynt;

- (void)myntDidConnected:(STMynt * _Nonnull)mynt;

- (void)mynt:(STMynt * _Nonnull)mynt didConnectFailed:(NSError * _Nullable)error;

- (void)mynt:(STMynt * _Nonnull)mynt didDisconnected:(NSError * _Nullable)error;

- (void)mynt:(STMynt * _Nonnull)mynt didUpdateRSSI:(NSInteger)RSSI;

- (void)mynt:(STMynt * _Nonnull)mynt didUpdateBattery:(NSInteger)battery;

- (void)mynt:(STMynt * _Nonnull)mynt didUpdateAlarmState:(BOOL)alarmState;

- (void)mynt:(STMynt * _Nonnull)mynt didUpdatePassword:(NSString * _Nullable)password;

- (void)mynt:(STMynt * _Nonnull)mynt didReceiveClickEvent:(MYNTClickEvent)clickEvent;

- (NSString * _Nullable)didRequestPassword:(STMynt * _Nonnull)mynt;

- (BOOL)didRequestAutoconnect:(STMynt * _Nonnull)mynt;

- (void)didNeedRestartBluetooth:(STMynt * _Nonnull)mynt;

@end

@interface STMynt : NSObject

// 设备名
@property (nonatomic, strong, readonly, nonnull) NSString *name;
// 信号强度
@property (nonatomic, assign) NSInteger RSSI;
// 固件类型(BLE | HID)
@property (nonatomic, assign, readonly) MYNTFirmwareType firmwareType;
// 硬件类型(CC25 | CC26)
@property (nonatomic, assign, readonly) MYNTHardwareType hardwareType;
// 设备状态
@property (nonatomic, assign, readonly) MYNTState state;

// 电量
@property (nonatomic, assign, readonly) NSInteger battery;
// 控制模式(Default | Music | Camera | PPT | Custom | Default)
@property (nonatomic, assign, readonly) MYNTControlMode controlMode;
// 单击
@property (nonatomic, assign, readonly) MYNTClickType click;
// 双击
@property (nonatomic, assign, readonly) MYNTClickType doubleClick;
// 三连击
@property (nonatomic, assign, readonly) MYNTClickType tripleClick;
// 长按
@property (nonatomic, assign, readonly) MYNTClickType hold;
// 单击 + 长按
@property (nonatomic, assign, readonly) MYNTClickType clickHold;
// 制造商信息
@property (nonatomic, strong, readonly, nullable) NSString *manufaturer;
// 产品型号
@property (nonatomic, strong, readonly, nullable) NSString *model;
// 序列号
@property (nonatomic, strong, readonly, nonnull) NSString *sn;
// 固件版本
@property (nonatomic, strong, readonly, nullable) NSString *firmware;
// 硬件版本
@property (nonatomic, strong, readonly, nullable) NSString *hardware;
// 软件版本
@property (nonatomic, strong, readonly, nullable) NSString *software;

// 是否被发现
@property (nonatomic, assign) BOOL isDiscovering;

@property (nonatomic, weak, nullable) id<STMyntDelegate> delegate;

/**
 *  @author Robin
 *
 *  初始化
 *
 *  @param peripheral
 *
 *  @return
 */
- (instancetype _Nonnull)initWithPeripheral:(STPeripheral * _Nonnull)peripheral;

/**
 *  @author Robin
 *
 *  连接
 */
- (void)connect;

/**
 *  @author Robin
 *
 *  连接设备
 *
 *  @param pair
 *  @param success
 *  @param failure
 */
- (void)connect:(void (^ _Nullable)(STMynt * _Nonnull, BOOL))pair
        success:(void (^ _Nullable)(STMynt * _Nonnull))success
        failure:(void (^ _Nullable)(STMynt * _Nonnull, NSError * _Nullable))failure;

/**
 *  @author Robin, 16-02-26 21:02:18
 *
 *  断开连接
 */
- (void)disconnect;

@end

// MARK: =====================读写=====================
@interface STMynt (RW)

/**
 *  @author Robin, 15-10-27 18:10:06
 *
 *  寻找小觅（小觅持续报警40s）
 *
 *  @param alarm 是否报警
 */
- (void)findMynt:(BOOL)alarm;

/**
 *  @author Robin, 15-10-27 18:10:33
 *
 *  更新固件
 *
 *  @param
 */
- (void)updateFirmware:(NSData * _Nullable (^ _Nullable)())start
              progress:(void (^ _Nullable)(CGFloat))progress
               success:(void (^ _Nullable)())success
               failure:(void (^ _Nullable)(MYNTOADError))failure;


/**
 *  @author Robin, 15-10-27 18:10:30
 *
 *  设置报警次数
 *
 *  @param count 次数
 */
- (void)writeAlarmCount:(NSInteger)count;

/**
 *  @author Robin, 15-10-27 18:10:11
 *
 *  设置延时报警
 *
 *  @param seconds 延时时间(单位:s)
 */
- (void)writeAlarmDelay:(NSInteger)seconds;

/**
 *  @author Robin, 15-12-02 20:12:20
 *
 *  设置控制模式
 *
 *  @param mode 模式
 */
- (void)writeControlMode:(MYNTControlMode)mode;

/**
 *  @author Robin
 *
 *  设置按键类型
 *
 *  @param eventType  按键类型 [MYNTClickEventClick | MYNTClickEventDoubleClick | MYNTClickEventTripleClick | MYNTClickEventHold | MYNTClickEventClickHold]
 *  @param eventValue 按键值
 */
- (void)writeClickType:(MYNTClickEvent)eventType
            eventValue:(MYNTClickType)eventValue;


/**
 *  @author Robin, 16-12-31 16:12:55
 *
 *  设置按键类型
 *
 *  @param click       单击
 *  @param doubleClick 双击
 *  @param tripleClick 三连击
 *  @param hold        长按
 *  @param clickHold   单击+长按
 */
- (void)writeClickType:(MYNTClickType)click
           doubleClick:(MYNTClickType)doubleClick
           tripleClick:(MYNTClickType)tripleClick
                  hold:(MYNTClickType)hold
             clickHold:(MYNTClickType)clickHold;

/**
 *  @author Robin, 15-10-27 18:10:18
 *
 *  读取电量
 */
- (void)readBattery:(void (^ _Nullable)(NSInteger battery))battery;

/**
 *  @author Robin, 15-12-08 18:12:15
 *
 *  读取信号
 */
- (void)readRSSI;

/**
 *  @author Robin, 16-12-31 16:12:19
 *
 *  读取设备信息
 *
 *  @param type    信息类型
 *  @param handler 回调
 */
- (void)readMyntInfo:(MYNTInfoType)type
             handler:(void(^ _Nullable)(NSString * _Nullable))handler;

/**
 *  @author Robin, 15-12-02 20:12:52
 *
 *  读取控制模式
 *
 *  @param handler
 */
- (void)readControlMode:(void(^ _Nullable)(MYNTControlMode mode))handler;

/**
 *  @author Robin, 16-12-31 16:12:03
 *
 *  读取点击事件(HID设备)
 *
 *  @param handler
 */
- (void)readClickType:(void(^ _Nullable)(MYNTClickType click,
                               MYNTClickType doubleClick,
                               MYNTClickType tripleClick,
                               MYNTClickType hold,
                               MYNTClickType clickHold))handler;

@end
