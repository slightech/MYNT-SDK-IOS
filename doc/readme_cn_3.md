# Enum

## MYNTClickValue 
> 点击事件对应的值

```
typedef NS_ENUM(NSInteger, MYNTClickValue) {
	// 无内容
    MYNTClickValueNone = 0x00,
    // 音乐播放
    MYNTClickValueMusicPlay = 0x01,
    // 下一曲
    MYNTClickValueMusicNext = 0x02,
    // 上一曲
    MYNTClickValueMusicPrevious = 0x03,
    // 音量增大
    MYNTClickValueMusicVolumeUp = 0x04,
    // 音量减小
    MYNTClickValueMusicVolumeDown = 0x05,
    // 拍照
    MYNTClickValueCameraShutter = 0x09,
    // 连拍
    MYNTClickValueCameraBurst = 0x0A,
    // PPT 下一页
    MYNTClickValuePPTNextPage = 0x06,
    // PPT 上一页
    MYNTClickValuePPTPreviousPage = 0x07,
    // 退出PPT
    MYNTClickValuePPTExit = 0x08,
	// 自定义按键
    MYNTClickValueCustomClick = 0xB0
};
```

## MYNTControlMode
> 控制模式 

|     |  单击  |   双击   |  三击  |  长按  | 单击长按 |
|:---:|:------:|:-------:|:-----:|:-----:|:-------:|
| 音乐 |  播放  |  下一曲  | 上一曲 | 音量加  | 音量减  |
| 相机 |  快门  |    /    |   /   |   连拍  |   /    |
| PPT |  下一页 |  上一页  |   /   |  退出   |   /    |
| 默认 |  播放  |  下一曲  | 上一曲 |   /    | 音量减  |
> 自定义: 自己设置的ClickValue

```
typedef NS_ENUM(NSInteger, MYNTControlMode) {
	// 音乐控制 
    MYNTControlModeMusic = 0x01,
    // 控制相机
    MYNTControlModeCamera = 0x02,
    // 控制PPT
    MYNTControlModePPT = 0x03,
    // 自定义
    MYNTControlModeCustom = 0x04,
    // 默认
    MYNTControlModeDefault = 0x05,
};
```

## MYNTClickEvent
> 点击事件

```
typedef NS_ENUM(NSInteger, MYNTClickEvent) {
	// 单击
    MYNTClickEventClick = 0x01,
    // 双击
    MYNTClickEventDoubleClick = 0x02,
    // 三击
    MYNTClickEventTripleClick = 0x03,
    // 长按
    MYNTClickEventHold = 0x09,
    // 单击长按
    MYNTClickEventClickHold
};
```

## MYNTInfoType
> 设备信息类型

```
typedef NS_ENUM(NSInteger, MYNTInfoType) {
	// 厂商信息
    MYNTInfoTypeManufaturer = 0x00,
    // 设备型号
    MYNTInfoTypeModel,
    // 设备序列号
    MYNTInfoTypeSn,
    // 固件信息
    MYNTInfoTypeFirmware,
    // 硬件信息
    MYNTInfoTypeHardware,
    // 软件信息
    MYNTInfoTypeSoftware,
};
```

## MYNTState
> 小觅的连接状态

```
typedef NS_ENUM(NSInteger, MYNTState) {
	// 断开连接
    MYNTStateDisconnected = 0x00,
    // 连接中
    MYNTStateConnecting,
    // 连接成功
    MYNTStateConnected,
};
```