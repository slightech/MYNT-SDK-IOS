# Enum

## MYNTClickValue 
> The value of the Event.

```
typedef NS_ENUM(NSInteger, MYNTClickValue) {
	// No Value
    MYNTClickValueNone = 0x00,
    // Play / Pause
    MYNTClickValueMusicPlay = 0x01,
    // Next
    MYNTClickValueMusicNext = 0x02,
    // Pervious
    MYNTClickValueMusicPrevious = 0x03,
    // VolumeUp
    MYNTClickValueMusicVolumeUp = 0x04,
    // VolumeDown
    MYNTClickValueMusicVolumeDown = 0x05,
    // Shutter
    MYNTClickValueCameraShutter = 0x09,
    // Burst
    MYNTClickValueCameraBurst = 0x0A,
    // Next Page
    MYNTClickValuePPTNextPage = 0x06,
    // Previous Page
    MYNTClickValuePPTPreviousPage = 0x07,
    // Exit PPT
    MYNTClickValuePPTExit = 0x08,
	// CustomClick
    MYNTClickValueCustomClick = 0xB0
};
```

## MYNTControlMode
> The value of the ControlMode.

|     |  Click  |   DoubleClick   |  TripleClick  |  Hold  | ClickHold |
|:---:|:------:|:-------:|:-----:|:-----:|:-------:|
| Music |  Play / Pause  |  Next  | Previous | VolumeUp  | VolumeDown |
| Camera |  Shutter  |    /    |   /   |   Burst  |   /    |
| PPT | Next Page  |  Previous Page  |   /   |  Exit PPT   |   /    |
| Default |  Play / Pause  |  Next  | Previous |   /    | VolumeDown  |
> Custom: the custom click value

```
typedef NS_ENUM(NSInteger, MYNTControlMode) {
	// Music
    MYNTControlModeMusic = 0x01,
    // Camera
    MYNTControlModeCamera = 0x02,
    // PPT
    MYNTControlModePPT = 0x03,
    // Custom
    MYNTControlModeCustom = 0x04,
    // Default
    MYNTControlModeDefault = 0x05,
};
```

## MYNTClickEvent
> The value of the clickEvent

```
typedef NS_ENUM(NSInteger, MYNTClickEvent) {
	// Click
    MYNTClickEventClick = 0x01,
    // DoubleClick
    MYNTClickEventDoubleClick = 0x02,
    // TripleClick
    MYNTClickEventTripleClick = 0x03,
    // Hold
    MYNTClickEventHold = 0x09,
    // Click+Hold
    MYNTClickEventClickHold
};
```

## MYNTInfoType
> The value of the infoType

```
typedef NS_ENUM(NSInteger, MYNTInfoType) {
	// manufaturer
    MYNTInfoTypeManufaturer = 0x00,
    // model
    MYNTInfoTypeModel,
    // sn
    MYNTInfoTypeSn,
    // firmware
    MYNTInfoTypeFirmware,
    // hardware
    MYNTInfoTypeHardware,
    // software
    MYNTInfoTypeSoftware,
};
```

## MYNTState
> The connect state of the mynt

```
typedef NS_ENUM(NSInteger, MYNTState) {
	// disconnect
    MYNTStateDisconnected = 0x00,
    // connecting
    MYNTStateConnecting,
    // connected
    MYNTStateConnected,
};
```