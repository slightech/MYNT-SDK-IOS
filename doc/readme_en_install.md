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

###[Documentation](readme_en.md)