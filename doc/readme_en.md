# How to use the SDK

## Enum
> [see](readme_en_3.md)

## STMyntBluetooth
> The STMyntBluetooth is a singleton

```
STMyntBluetooth.sharedInstance()
```
### - (void)startScan;
> Use to start scan mynt (if mynt is paired in system, always return).

```
STMyntBluetooth.sharedInstance().startScan()
```

### - (void)stopScan;
> Use to stop scan mynt.

```
STMyntBluetooth.sharedInstance().stopScan()
```

### @property (nonatomic, assign) BOOL isScanning;
> You can get the state of Scan with ``isScanning``
> 
> ⚠️: If bluetooth is closed, but you did not stopScan, the state of ``isScanning `` always true.

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
> You can get the mynt with the sn

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
> The connect state of the mynt. 

```
mynt.state
```

### @property (nonatomic, assign, readonly) NSInteger battery;
> The battery of the mynt.

```
mynt.battery
```

### @property (nonatomic, assign, readonly) MYNTControlMode controlMode;
> The controlmode of the mynt.

```
mynt.controlMode
```

### @property (nonatomic, assign, readonly) MYNTClickValue click;
> The value of the click.

```
mynt.click
```

### @property (nonatomic, assign, readonly) MYNTClickValue doubleClick;
> The value of the doubleclick.

```
mynt.doubleClick
```

### @property (nonatomic, assign, readonly) MYNTClickValue tripleClick;
> The value of the tripleclick.

```
mynt.tripleClick
```

### @property (nonatomic, assign, readonly) MYNTClickValue hold;
> The value of the hold.

```
mynt.hold
```

### @property (nonatomic, assign, readonly) MYNTClickValue clickHold;
> The value of the click + hold.

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
> The firmware of the mynt.

```
mynt.firmware
```

### @property (nonatomic, strong, readonly, nullable) NSString *hardware;
> The hardware of the mynt.

```
mynt.hardware
```

### @property (nonatomic, strong, readonly, nullable) NSString *software;
> The software of the mynt.

```
mynt.software
```

### @property (nonatomic, assign) BOOL isDiscovering;
> The flag will true if the mynt is discoverd.

```
mynt.isDiscovering
```

### @property (nonatomic, weak, nullable) id\<STMyntDelegate> delegate;
> [STMyntDelegate](readme_en_2.md)

### - (void)connect;
> Used to start connect.

```
mynt.connect()
```

### - (void)disconnect;
> Used to cancel connect.

```
mynt.disconnect()
```

### - (void)toggleAlarm:(BOOL)alarm;
> Uesd to set mynt alarm or not.
> 
> ⚠️: Mynt will alarm 40 Sec, You can click mynt to stop alarm.

```
mynt.toggleAlarm(true)
```

### - (void)writeAlarmCount:(NSInteger)count;
> Used to set the alarm times of the mynt wnen mynt is disconnect
> 
> ⚠️: if mynt disconnect, mynt will alarm

```
mynt.writeAlarmCount(3)
```

### - (void)writeAlarmDelay:(NSInteger)seconds;
> Used to set the alarmdelay of the mynt(unit: second)
> 
> ⚠️: if mynt disconnect, mynt will alarm

```
mynt.writeAlarmDelay(20)
```

### - (void)writeControlMode:(MYNTControlMode)mode;
> Userd to set the controlmode of the mynt. If the controlMode is Custom, customClickValue will go into effect

```
mynt?.writeControlMode(.Music)
```

### - (void)writeClickValue:(MYNTClickEvent)clickEvent eventValue:(MYNTClickValue)eventValue;
> Userd to set the clickvalue of the mynt.
> 
> ⚠️: If set this, controlmode will switch to custom.

```
mynt?.writeClickValue(.Click, eventValue: .MusicNext)
```

### - (void)writeClickValue:(MYNTClickValue)click doubleClick:(MYNTClickValue)doubleClick tripleClick:(MYNTClickValue)tripleClick hold:(MYNTClickValue)hold clickHold:(MYNTClickValue)clickHold;
> Userd to set the clickvalue of the mynt.
> 
> ⚠️: If set this, controlmode will switch to custom.

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