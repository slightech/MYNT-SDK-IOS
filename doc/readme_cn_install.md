
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

###[文档](readme_cn.md)