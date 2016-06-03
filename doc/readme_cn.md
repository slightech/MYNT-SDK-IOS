# 如何使用SDK

## Enum
> [查看定义](readme_cn_3.md)

## STMyntBluetooth
> STMyntBluetooth 使用了单例模式

```
STMyntBluetooth.sharedInstance()
```
### - (void)startScan;
> 使用``startScan ``进行设备搜索，不单单是搜索周边设备，如果您的小觅已经被系统层绑定，也会被搜索到

```
STMyntBluetooth.sharedInstance().startScan()
```

### - (void)stopScan;
> 如果需要停止扫描 则调用``stopScan ``

```
STMyntBluetooth.sharedInstance().stopScan()
```

### @property (nonatomic, assign) BOOL isScanning;
> 你可以通过 ``isScanning `` 来判断 是否正在扫描
> 
> ⚠️: 如果蓝牙被关闭了，但是你没有停止搜索，这个状态还是会为true

```
STMyntBluetooth.sharedInstance().isScanning
```

### @property (nonatomic, assign) CBCentralManagerState centralState;
> 如果你想知道现在的蓝牙状态 可以通过 ``centralState `` 来获取

```
STMyntBluetooth.sharedInstance().centralState
```

### @property (nonatomic, assign) BOOL reportLost;
> 如果你需要将SDK设置为公益寻找，帮助他人一起寻找丢失的小觅，你可以将``reportLost ``设置为true

```
STMyntBluetooth.sharedInstance(). reportLost = true
```

### - (NSArray <STMynt *> * _Nullable)retrieveConnectedMynts;
> 获取已连接的小觅，不单单是被app绑定的小觅，包含系统中已连接的小觅也会一起返回

```
let mynts = STMyntBluetooth.sharedInstance().retrieveConnectedMynts()
```

### - (STMynt * _Nullable)findMyntWithSn:(NSString *_Nonnull)sn;
> 你可以通过sn来查询STMynt

```
let mynt = STMyntBluetooth.sharedInstance().findMyntWithSn("K043E9H9A0")
```
### @property (nonatomic, weak, nullable) id\<STMyntBluetoothDelegate> delegate;
> [STMyntBluetoothDelegate](readme_cn_1.md)

---
## STMynt 

### @property (nonatomic, strong, readonly, nonnull) NSString *name;
> 小觅的名字

```
mynt.name
```

### @property (nonatomic, assign) NSInteger RSSI;
> 小觅的信号强度

```
mynt.RSSI
```

### @property (nonatomic, assign, readonly) MYNTFirmwareType firmwareType;
> 小觅的固件版本

```
mynt.firmwareType
```

### @property (nonatomic, assign, readonly) MYNTHardwareType hardwareType;
> 小觅的硬件版本 [通过芯片区分 CC25芯片, CC26芯片]
> 
> ⚠️: 市面上只有CC26的芯片在流通

```
mynt.hardwareType
```

### @property (nonatomic, assign, readonly) MYNTState state;
> 小觅的链接状态 

```
mynt.state
```

### @property (nonatomic, assign, readonly) NSInteger battery;
> 小觅的电量

```
mynt.battery
```

### @property (nonatomic, assign, readonly) MYNTControlMode controlMode;
> 小觅的控制模式

```
mynt.controlMode
```

### @property (nonatomic, assign, readonly) MYNTClickValue click;
> 小觅的单击事件

```
mynt.click
```

### @property (nonatomic, assign, readonly) MYNTClickValue doubleClick;
> 小觅的双击事件

```
mynt.doubleClick
```

### @property (nonatomic, assign, readonly) MYNTClickValue tripleClick;
> 小觅的三击事件

```
mynt.tripleClick
```

### @property (nonatomic, assign, readonly) MYNTClickValue hold;
> 小觅的长按事件

```
mynt.hold
```

### @property (nonatomic, assign, readonly) MYNTClickValue clickHold;
> 小觅的单击＋长按事件

```
mynt.clickHold
```

### @property (nonatomic, strong, readonly, nullable) NSString *manufaturer;
> 小觅的制造商

```
mynt.manufaturer
```

### @property (nonatomic, strong, readonly, nullable) NSString *model;
> 小觅的型号

```
mynt.model
```

### @property (nonatomic, strong, readonly, nonnull) NSString *sn;
> 小觅的sn

```
mynt.sn
```

### @property (nonatomic, strong, readonly, nullable) NSString *firmware;
> 小觅的固件信息

```
mynt.firmware
```

### @property (nonatomic, strong, readonly, nullable) NSString *hardware;
> 小觅的硬件信息

```
mynt.hardware
```

### @property (nonatomic, strong, readonly, nullable) NSString *software;
> 小觅的软件信息

```
mynt.software
```

### @property (nonatomic, assign) BOOL isDiscovering;
> 一个标志位，用于查看mynt是否被发现

```
mynt.isDiscovering
```

### @property (nonatomic, weak, nullable) id\<STMyntDelegate> delegate;
> [STMyntDelegate](readme_cn_2.md)

### - (void)connect;
> 连接小觅

```
mynt.connect()
```

### - (void)disconnect;
> 断开小觅的连接

```
mynt.disconnect()
```

### - (void)toggleAlarm:(BOOL)alarm;
> 让小觅报警(一般用于找小觅 小觅会持续报警40秒后停止，你也可以手动小觅的按钮取消报警)

```
mynt.toggleAlarm(true)
```

### - (void)writeAlarmCount:(NSInteger)count;
> 设置小觅断线后的报警次数
> 
> ⚠️: 小觅断线后是会报警的

```
mynt.writeAlarmCount(3)
```

### - (void)writeAlarmDelay:(NSInteger)seconds;
> 设置小觅断线后的报警延迟时间
> 
> ⚠️: 小觅断线后是会报警的

```
mynt.writeAlarmDelay(20)
```

### - (void)writeControlMode:(MYNTControlMode)mode;
> 设置小觅的控制模式，当控制模式为Custom时 小觅的点击事件才会生效

```
mynt?.writeControlMode(.Music)
```

### - (void)writeClickValue:(MYNTClickEvent)clickEvent eventValue:(MYNTClickValue)eventValue;
> 设置小觅的点击事件 如果设置的值不是
> 
> ⚠️: 如果设置了点击事件，小觅的控制模式将自动切换为Custom

```
mynt?.writeClickValue(.Click, eventValue: .MusicNext)
```

### - (void)writeClickValue:(MYNTClickValue)click doubleClick:(MYNTClickValue)doubleClick tripleClick:(MYNTClickValue)tripleClick hold:(MYNTClickValue)hold clickHold:(MYNTClickValue)clickHold;
> 设置小觅的点击事件
> 
> ⚠️: 如果设置了点击事件，小觅的控制模式将自动切换为Custom

```
mynt?.writeClickValue(.MusicPlay, doubleClick: .MusicPlay, tripleClick: .MusicPlay, hold: .MusicPlay, clickHold: .MusicPlay)
```

### - (void)readBattery:(void (^ _Nullable)(NSInteger battery))battery;
> 读取电池电量

```
mynt?.readBattery({ (battery) in
    NSLog("current battery -> \(battery)")
})

```

### - (void)readRSSI;
> 读取信号强度
> 
> ⚠️: 信号强度会在 ``mynt:didUpdateRSSI:``中回调

```
mynt.readRSSI()
```

### - (void)readMyntInfo:(MYNTInfoType)type handler:(void(^ _Nullable)(NSString * _Nullable))handler;
> 读取小觅的设备信息，可以读取的值: 厂商、型号、序列号、硬件信息、软件信息、固件信息

```
mynt?.readMyntInfo(.Manufaturer, handler: { (info) in
    NSLog("manufaturer -> \(info)")
})
```

### - (void)readControlMode:(void(^ _Nullable)(MYNTControlMode mode))handler;
> 读取小觅的控制模式

```
mynt?.readControlMode({ (controlMode) in
    NSLog("current controlmode -> \(controlMode)")
})
```

### - (void)readClickValue:(void(^ _Nullable)(MYNTClickValue click, MYNTClickValue doubleClick,  MYNTClickValue tripleClick, MYNTClickValue hold, MYNTClickValue clickHold))handler;
> 读取小觅的点击设置

```
mynt?.readClickValue({ (click, doubleClick, tripleClick, hold, clickHold) in
    NSLog("click -> \(click) doubleClick -> \(doubleClick) tripleClick -> \(tripleClick) hold -> \(hold) clickHold -> \(clickHold)")
})
```