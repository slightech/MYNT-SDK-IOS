![](https://raw.githubusercontent.com/slightech/MYNT-SDK-Android/master/static/slide_mynt.png)


[MYNT]: https://mynt.slightech.com/

# MYNT SDK

The SDK to help developers to search and control MYNTs conveniently. 

* Listen the MYNTs connect state, do scan, connect, disconnect etc.
* Set the MYNTs click events with HID or custom actions to control music, camera, PPT etc.

## What is [MYNT][]

MYNT is a thinnest smart tracker, only 1/8 inch. Easy to fit in a wallet, attach to a keychain, or affix to a laptop or a TV remote.

MYNT is a most exquisite smart tracker, processed with PVD technology on stainless steel with frosting or polishing. Four colors are optional: Silver, Black, Gold, and Blue.

![](https://raw.githubusercontent.com/slightech/MYNT-SDK-Android/master/static/colorful.png)

MYNT is not just a smart tracker, can also become your everyday smart companion. In addition to anti-loss and finder capability, MYNT can also act the following really cool utilities:

* Remote shutter: Free your hand, release your passion.
* Music remoter: Control freely, enjoy your music.
* Slide remoter: Control freely, facilitate efficiency.

![](https://raw.githubusercontent.com/slightech/MYNT-SDK-Android/master/static/slide-ctr-photo.png)

MYNT - No lost, all found, control everything.

- Website: https://mynt.slightech.com
- Purchase: https://www.amazon.com/dp/B017QML97W

## Installation

### CocoaPods
	
1. Add `pod 'MYNT-SDK-IOS'` to your Podfile.
2. Run `pod install` or `pod update`.
3. import \<STMyntBluetooth.h\>.

### Manually

1. Download all the files in the `MYNT-SDK-IOS` subdirectory.
2. Add the source files to your Xcode project.
3. add frameworks:

	> ios 
	
	* CoreBluetooth
	* sqlite3

	> osx
	
	* IOBluetooth
	* sqlite3
4. import `STMyntBluetooth.h`.

## Requirements
This library requires `iOS 7.0+` and `OSX 10.9+`.

###[Documentation](doc/readme_en.md)

---

## 安装

### CocoaPods

1. 在 Podfile 中添加 `pod 'MYNT-SDK-IOS'`。
2. 执行 `pod install` 或 `pod update`.
3. 导入 \<STMyntBluetooth.h\>.


### 手动安装

1. 下载 `MYNT-SDK-IOS` 文件夹内的所有内容。
2. 将 `MYNT-SDK-IOS` 内的源文件添加(拖放)到你的工程。
3. 加入frameworks:

	> ios 
	
	* CoreBluetooth
	* sqlite3

	> osx
	
	* IOBluetooth
	* sqlite3
4. 导入 `STMyntBluetooth.h`.

## 系统要求
该项目最低支持 `iOS 7.0` 和 `OSX 10.9`。

###[文档](doc/readme_cn.md)