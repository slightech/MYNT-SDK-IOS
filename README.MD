## MTNT SDK

[![Support](https://img.shields.io/badge/support-iOS%207%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
[![Support](https://img.shields.io/badge/support-osx%2010.9%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;

## [中文文档](README/readme_cn.md)

Installation
	

Add **pod 'MYNT-SDK-IOS', :git=>"https://github.com/slightech/MYNT-SDK-IOS.git"** to your Podfile
	2. Run 
	3. Import <>


###1. 在Podfile中添加

```
pod 'MyntCoreBluetooth', :git=>"https://github.com/slightech/MyntCoreBluetoothSDK.git"
```

###2. 导入头文件

```
#import <STMyntCoreBluetooth.h>
```
> 如果是 Swift 工程，请在对应bridging-header.h中导入

###3. 初始化MyntCoreBluetooth

> Objective-C
>
> ```
// 方式1 默认打开 【找丢模式】
[[STMyntCentralManager sharedInstance] installWithDelegate:self];
>
// 方式2 选择性开关【找丢模式】
[[STMyntCentralManager sharedInstance] installWithDelegate:self needReportLost:YES];
```

---

> Swift
> 
> ```
>// 方式1 默认打开 【找丢模式】
STMyntCentralManager.sharedInstance().installWithDelegate(self)
>
>// 方式2 选择性开关【找丢模式】
STMyntCentralManager.sharedInstance().installWithDelegate(self, needReportLost: true)
> ```

### 4. 实现STMyntCentralDelegate

> Objective-c  
> 
> ```
> - (void)central:(STMyntCentralManager *)central didFoundMynt:(STMynt *)mynt {
>  // 发现周边设备
> }
> 
> - (void)central:(STMyntCentralManager *)central didDisfoundMynt:(STMynt *)mynt {
>  // 设备发现20秒后无相应  会调用此方法
> }
>
> - (void)central:(STMyntCentralManager *)central willRestoreMynt:(STMynt *)mynt {
> // app被杀掉之后  会自动重启  回调此方法  
> // 只需要对STMynt重新设置delegate和dataSource
> }
> ```

---

> Swift
> 
> ```
> func central(central: STMyntCentralManager!, didFoundMynt mynt: STMynt!) {
>  // 发现周边设备
> }
    
> func central(central: STMyntCentralManager!, didDisfoundMynt mynt: STMynt!) {
>  // 设备发现20秒后无相应  会调用此方法
> }
>
> func central(central: STMyntCentralManager!, willRestoreMynt mynt: STMynt!) {
> // app被杀掉之后  会自动重启  回调此方法  
> // 只需要对STMynt重新设置delegate和dataSource
> }
> ``` 

###5. 对每个STMynt设置STMyntDataSource
 STMyntDataSource 用于向app层请求上次保存的mynt密钥  方便重新连接
 
> * 如果有密码 返回密码 SDK会发送密钥给Mynt 自动绑定
> 
> * 如果没有密码 则返回nil SDK会向Mynt请求密钥

===
> Objective-c
> 
> ```
> - (NSString *)peripheral:(STPeripheral *)peripheral
      didRequestPassword:(NSString *)msg {
    return password;
}
> ```

---

> Swift
> 
> ```
> func mynt(mynt: STMynt!, didRequestPassword msg: String!) -> String! {
    return password
}
> ```

###6. 对每个STMynt设置STPeripheralDelegate
> 具体不给出说明  每个方法都有注释
 
 ---
 至此，恭喜你的工程已经成功集成 MyntCoreBluetoothSDK，接下来编译并运行你的工程吧 ：）
 
## 操作Mynt的几个方法
 
```
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
```