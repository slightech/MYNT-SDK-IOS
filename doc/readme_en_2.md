# STMyntDelegate

    func myntDidStartConnect(mynt: STMynt) {
		// 开始连接
    }
    
    func myntDidConnected(mynt: STMynt) {
		// 连接成功
    }
    
    func mynt(mynt: STMynt, didConnectFailed error: NSError?) {
		// 连接失败
    }
    
    func mynt(mynt: STMynt, didDisconnected error: NSError?) {
		// 断开连接
    }
    
    func mynt(mynt: STMynt, didUpdateRSSI RSSI: Int) {
		// 更新RSSI
    }
    
    func mynt(mynt: STMynt, didUpdateBattery battery: Int) {
		// 电池更新
    }
    
    func mynt(mynt: STMynt, didUpdateAlarmState alarmState: Bool) {
		// 更新报警状态
    }
    
    func mynt(mynt: STMynt, didReceiveClickEvent clickEvent: MYNTClickEvent) {
    	// ⚠️: 如果controlMode为Custom
    	// ⚠️: 并且clickValue为CustomClick
		// 当点击了小觅的按钮，这个方法会回调
    }
    
    func didRequestAutoconnect(mynt: STMynt) -> Bool {
    	// 如果你需要小觅自动重连，则需要返回true，反之，返回false 手动调用disconnect时 不会自动重连
        return true
    }
    
    func didNeedRestartBluetooth(mynt: STMynt) {
        // 遇到连接异常的时候，会回调这个方法，你可以在这里通知用户重启蓝牙或者重启手机来保持蓝牙的稳定性
    }