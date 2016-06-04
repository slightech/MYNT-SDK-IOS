# How to use the SDK

## Enum
> [see](readme_en_3.md)

## STMyntBluetooth
> The STMyntBluetooth is a singleton

```
STMyntBluetooth.sharedInstance()
```
### - (void)startScan;
> Use to start scanning mynt (if mynt has paired in system, always return).

```
STMyntBluetooth.sharedInstance().startScan()
```

### - (void)stopScan;
> Use to stop scanning mynt.

```
STMyntBluetooth.sharedInstance().stopScan()
```

### @property (nonatomic, assign) BOOL isScanning;
> You can get the state of ``isScanning`` with True / False.
> 
> ⚠️: If bluetooth is closed, but you do not stopScan, the state of ``isScanning `` will always be true.

```
STMyntBluetooth.sharedInstance().isScanning
```

### @property (nonatomic, assign) CBCentralManagerState centralState;
> The state of the Bluetooth

```
STMyntBluetooth.sharedInstance().centralState
```

### @property (nonatomic, assign) BOOL reportLost;
> If you want to help others find mynts, you can set ``reportList`` true

```
STMyntBluetooth.sharedInstance(). reportLost = true
```

### - (NSArray <STMynt *> *)retrieveConnectedMynts;
> All of the connectd mynts, not only in app.

```
let mynts = STMyntBluetooth.sharedInstance().retrieveConnectedMynts()
```

### - (STMynt *)findMyntWithSn:(NSString *_Nonnull)sn;
> You can get the mynt object with the sn from iOS

```
let mynt = STMyntBluetooth.sharedInstance().findMyntWithSn("K043E9H9A0")
```
### @property (nonatomic, weak, nullable) id\<STMyntBluetoothDelegate> delegate;
> [STMyntBluetoothDelegate](readme_en_1.md)

---
## STMynt 

### @property (nonatomic, strong, readonly, nonnull) NSString *name;
> The name of the mynt.

```
mynt.name
```

### @property (nonatomic, assign) NSInteger RSSI;
> the signal strength of the mynt.

```
mynt.RSSI
```

### @property (nonatomic, assign, readonly) MYNTFirmwareType firmwareType;
> the firmwareType of the mynt.

```
mynt.firmwareType
```

### @property (nonatomic, assign, readonly) MYNTHardwareType hardwareType;
> the hardwareType of the mynt. [CC25XX CSR | CC26XX CSR]
> 
> ⚠️: Only CC26XX CSR 

```
mynt.hardwareType
```

### @property (nonatomic, assign, readonly) MYNTState state;
> The connecting state of the mynt. 

```
mynt.state
```

### @property (nonatomic, assign, readonly) NSInteger battery;
> The battery quatity information of the mynt.

```
mynt.battery
```

### @property (nonatomic, assign, readonly) MYNTControlMode controlMode;
> The controlmode of the mynt.

```
mynt.controlMode
```

### @property (nonatomic, assign, readonly) MYNTClickValue click;
> The value of the operation: click.

```
mynt.click
```

### @property (nonatomic, assign, readonly) MYNTClickValue doubleClick;
> The value of the operation: doubleclick.

```
mynt.doubleClick
```

### @property (nonatomic, assign, readonly) MYNTClickValue tripleClick;
> The value of the operation: tripleclick.

```
mynt.tripleClick
```

### @property (nonatomic, assign, readonly) MYNTClickValue hold;
> The value of the operation: hold.

```
mynt.hold
```

### @property (nonatomic, assign, readonly) MYNTClickValue clickHold;
> The value of the operation: click + hold.

```
mynt.clickHold
```

### @property (nonatomic, strong, readonly, nullable) NSString *manufaturer;
> The manufaturer of the mynt.

```
mynt.manufaturer
```

### @property (nonatomic, strong, readonly, nullable) NSString *model;
> The model of the mynt.

```
mynt.model
```

### @property (nonatomic, strong, readonly, nonnull) NSString *sn;
> The sn of the mynt.

```
mynt.sn
```

### @property (nonatomic, strong, readonly, nullable) NSString *firmware;
> The firmware information of the mynt. (BLE-26XX-2.1.0)

```
mynt.firmware
```

### @property (nonatomic, strong, readonly, nullable) NSString *hardware;
> The firmware compiling date of the mynt. (16041516:xx(year) xx(month) xx(day) xx(hour))

```
mynt.hardware
```

### @property (nonatomic, strong, readonly, nullable) NSString *software;
> The firmware version of the mynt.

```
mynt.software
```

### @property (nonatomic, assign) BOOL isDiscovering;
> The flag will be true if the mynt is discoverd.

```
mynt.isDiscovering
```

### @property (nonatomic, weak, nullable) id\<STMyntDelegate> delegate;
> [STMyntDelegate](readme_en_2.md)

### - (void)connect;
> Used to start Func (connect)

```
mynt.connect()
```

### - (void)disconnect;
> Used to cancel Func (connect)

```
mynt.disconnect()
```

### - (void)toggleAlarm:(BOOL)alarm;
> Uesd to set mynt ring or not.
> 
> ⚠️:When you press the mynt ring icon in App, Mynt will ring for 40 Sec. You can click the button on mynt to stop ringing. This is used for finding items(mynt).

```
mynt.toggleAlarm(true)
```

### - (void)writeAlarmCount:(NSInteger)count;
> Used to set the alarm times of the mynt wnen mynt is disconnect
> 
> ⚠️: This is used for anti-lost sceanrio. When mynt disconnected with your device, your mynt will alarm x (the value you set) times.

```
mynt.writeAlarmCount(3)
```

### - (void)writeAlarmDelay:(NSInteger)seconds;
> Used to set the alarmdelay of the mynt(unit: second)
> 
> ⚠️: This is used for anti-lost sceanrio. When mynt disconnected with your device, how the alarm will be dealyed. This is used to avoid false alarm. For iOS devices, we suggest to set this value to "15" seconds. And for Android device, we would suggest to set this value to "40". Depending on bluetooth performance.

```
mynt.writeAlarmDelay(20)
```

### - (void)writeControlMode:(MYNTControlMode)mode;
> Used to set the controlmode of the mynt. Only when the controlMode is Custom, customClickValue will be effective.

```
mynt?.writeControlMode(.Music)
```

### - (void)writeClickValue:(MYNTClickEvent)clickEvent eventValue:(MYNTClickValue)eventValue;
> Used to set the clickvalue of the mynt.
> 
> ⚠️: If set this, controlmode will switch to custom.
> ⚠️: Only when the Controlmode and eventValue of MYNT are "Custom", when users press the button on MYNT, then you will get notification of what the clickEvent is (click, doubleClick or others) by method ``mynt:didReceiveClickEvent:`` 

```
mynt?.writeClickValue(.Click, eventValue: .MusicNext)
```

### - (void)writeClickValue:(MYNTClickValue)click doubleClick:(MYNTClickValue)doubleClick tripleClick:(MYNTClickValue)tripleClick hold:(MYNTClickValue)hold clickHold:(MYNTClickValue)clickHold;
> Used to set the clickvalue of the mynt.
> 
> ⚠️: If set this, controlmode will switch to custom.
> ⚠️: Only when the Controlmode and eventValue of MYNT are "Custom", when users press the button on MYNT, then you will get notification of what the clickEvent is (click, doubleClick or others) by method ``mynt:didReceiveClickEvent:`` 

```
mynt?.writeClickValue(.MusicPlay, doubleClick: .MusicPlay, tripleClick: .MusicPlay, hold: .MusicPlay, clickHold: .MusicPlay)
```

### - (void)readBattery:(void (^)(NSInteger battery))battery;
> Used to read the battey of the mynt.

```
mynt?.readBattery({ (battery) in
    NSLog("current battery -> \(battery)")
})

```

### - (void)readRSSI;
> Used to read the signal strength of the mynt.
> 
> ⚠️: signal strength will return in ``mynt:didUpdateRSSI:``

```
mynt.readRSSI()
```

### - (void)readMyntInfo:(MYNTInfoType)type handler:(void(^)(NSString * _Nullable))handler;
> Used to read the deviceinfo of the mynt.

```
mynt?.readMyntInfo(.Manufaturer, handler: { (info) in
    NSLog("manufaturer -> \(info)")
})
```

### - (void)readControlMode:(void(^)(MYNTControlMode mode))handler;
> Used to read controlmode of the mynt.

```
mynt?.readControlMode({ (controlMode) in
    NSLog("current controlmode -> \(controlMode)")
})
```

### - (void)readClickValue:(void(^)(MYNTClickValue click, MYNTClickValue doubleClick,  MYNTClickValue tripleClick, MYNTClickValue hold, MYNTClickValue clickHold))handler;
> Used to read clickValue of the mynt

```
mynt?.readClickValue({ (click, doubleClick, tripleClick, hold, clickHold) in
    NSLog("click -> \(click) doubleClick -> \(doubleClick) tripleClick -> \(tripleClick) hold -> \(hold) clickHold -> \(clickHold)")
})
```