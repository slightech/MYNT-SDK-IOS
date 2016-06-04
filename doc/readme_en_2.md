# STMyntDelegate

    func myntDidStartConnect(mynt: STMynt) {
		// Start connecting
    }
    
    func myntDidConnected(mynt: STMynt) {
		// Connection established
    }
    
    func mynt(mynt: STMynt, didConnectFailed error: NSError?) {
		// Failed to connect
    }
    
    func mynt(mynt: STMynt, didDisconnected error: NSError?) {
		// Disconnected
    }
    
    func mynt(mynt: STMynt, didUpdateRSSI RSSI: Int) {
		// RSSI updated
    }
    
    func mynt(mynt: STMynt, didUpdateBattery battery: Int) {
		// Battery quantity information updated
    }
    
    func mynt(mynt: STMynt, didUpdateAlarmState alarmState: Bool) {
		// Alarm status updated
    }
    
    func mynt(mynt: STMynt, didReceiveClickEvent clickEvent: MYNTClickEvent) {
    	// ⚠️: If controlMode is Custom
    	// ⚠️: And clickValue is CustomClick
		// When pressed the button in the center of MYNT, the this Func will return a value (clickEvent)
    }
    
    func didRequestAutoconnect(mynt: STMynt) -> Bool {
    	// If you want the MYNT re-connect automatically, you should set the reutrn value to "True", else "False". When you manually invoke Func "Disconnect", you App will not connect MYNT automatically.
        return true
    }
    
    func didNeedRestartBluetooth(mynt: STMynt) {
        // When iOS can not connect to / scan the MYNT device, and log return error, meanwhile the system connect or scan abnormally. System will return this Func (didNeedRestartBluetooth(mynt: STMynt)). You can use it to notify users restart Bluetooth or Phone. When firmware updated and some Bluetooth broadcast values changed, this situation may occur.
    }