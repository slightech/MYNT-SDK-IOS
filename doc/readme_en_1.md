# STMyntBluetoothDelegate

```
    func myntBluetooth(myntBluetooth: STMyntBluetooth, didUpdateState state: CBCentralManagerState) {
        // 蓝牙状态更新 (蓝牙关闭，蓝牙打开等等)
    }
    
    func myntBluetooth(myntBluetooth: STMyntBluetooth, didDiscoverMynt mynt: STMynt) {
		// 发现设备
    }
    
    func myntBluetooth(myntBluetooth: STMyntBluetooth, didDiscoverTimeoutMynt mynt: STMynt) {
    	// 设备发现超时
    }
    
    func myntBluetooth(myntBluetooth: STMyntBluetooth, didFilterMyntWithSn sn: String) -> Bool {
		// 如果需要过滤mynt  实现这个方法
    }
```
