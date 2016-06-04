# STMyntBluetoothDelegate

```
    func myntBluetooth(myntBluetooth: STMyntBluetooth, didUpdateState state: CBCentralManagerState) {
        // Bluetooth status update (Bluetooth including but not limited to: Bluetooth is off, Buletooth is on etc.)
    }
    
    func myntBluetooth(myntBluetooth: STMyntBluetooth, didDiscoverMynt mynt: STMynt) {
		// Found MYNT
    }
    
    func myntBluetooth(myntBluetooth: STMyntBluetooth, didDiscoverTimeoutMynt mynt: STMynt) {
    	// The found MYNT is time out
    }
    
    func myntBluetooth(myntBluetooth: STMyntBluetooth, didFilterMyntWithSn sn: String) -> Bool {
		// If you want to filter out some MYNT devices as your requirement, use this Func.
    }
```
