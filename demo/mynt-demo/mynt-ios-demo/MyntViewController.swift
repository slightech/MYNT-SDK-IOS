//
//  MyntViewController.swift
//  mynt-ios-demo
//
//  Created by gejw on 16/5/11.
//  Copyright © 2016年 slighech. All rights reserved.
//

import UIKit

extension MYNTControlMode {
    
    var name: String {
        switch self {
        case .BLE:
            return "BLE"
        case .Music:
            return "Music"
        case .Camera:
            return "Camera"
        case .PPT:
            return "PPT"
        case .Custom:
            return "Custom"
        case .Default:
            return "Default"
        }
    }
}

extension MYNTClickType {
    
    var name: String {
        switch self {
        case .MusicPlay:
            return "MusicPlay"
        case .MusicNext:
            return "MusicNext"
        case .MusicPrevious:
            return "MusicPrevious"
        case .MusicVolumeUp:
            return "MusicVolumeUp"
        case .MusicVolumeDown:
            return "MusicVolumeDown"
        case .CameraShutter:
            return "CameraShutter"
        case .CameraBurst:
            return "CameraBurst"
        case .PPTExit:
            return "PPTExit"
        case .PPTNextPage:
            return "PPTNextPage"
        case .PPTPreviousPage:
            return "PPTPreviousPage"
        case .PhoneAlarm:
            return "PhoneAlarm"
        case .PhoneFlash:
            return "PhoneFlash"
        case .None:
            return "None"
        }
    }
    
}

extension NSDate {
    
    class func currentTimeString() -> String {
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss:sss"
        return formatter.stringFromDate(date)
    }
    
}

class MyntViewController: UIViewController, UIAlertViewDelegate {
    
    let MenuAlertTag        = 10000
    let WriteControlModeTag = 10001
    
    weak var mynt: STMynt?
    
    @IBOutlet weak var logView: UITextView!
    var rightBarButtonItem: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logView.layoutManager.allowsNonContiguousLayout = false
        
        rightBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Done, target: self, action: #selector(MyntViewController._clickMenu(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem

        mynt?.delegate = self
        self.addLogInfo(mynt: mynt, msg: "|--- start connect ---|")
        mynt?.connect({ [weak self](mynt, needPair) in
            self?.addLogInfo(mynt: mynt, msg: "|--- need click mynt to pair ---|")
            }, success: { [weak self](mynt) in
                self?.addLogInfo(mynt: mynt, msg: "|--- connect success ---|")
                self?.connectSuccessHandler()
            }, failure: { [weak self](mynt, error) in
                self?.addLogInfo(mynt: mynt, msg: "connect failure \(error)")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    deinit {
        mynt?.delegate = nil
        mynt?.disconnect()
    }
    
    func addLogInfo(mynt mynt: STMynt?, msg: String) {
        if self.mynt != mynt {
            return
        }
        logView.text = logView.text + "\(NSDate.currentTimeString()) \t\(msg)\n"
        logView.scrollRangeToVisible(NSRange(location: logView.text.characters.count - 1, length: 1))
    }
    
    @objc private func _clickMenu(sender: AnyObject) {
        let menuAlert = UIAlertView(title: nil, message: nil, delegate: self, cancelButtonTitle: "Cancel")
        menuAlert.tag = MenuAlertTag
        menuAlert.addButtonWithTitle("Toggle alarm")
        menuAlert.addButtonWithTitle("Read battery")
        menuAlert.addButtonWithTitle("Read deviceInfo")
        menuAlert.addButtonWithTitle("Read control mode")
        menuAlert.addButtonWithTitle("Send control mode")
        menuAlert.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        switch alertView.tag {
        case MenuAlertTag:
            switch buttonIndex {
            case 1:
                mynt?.findMynt(true)
            case 2:
                mynt?.readBattery({ [weak self](battery) in
                    self?.addLogInfo(mynt: self?.mynt, msg: "battery -> \(battery)")
                    })
            case 3:
                mynt?.readMyntInfo(MYNTInfoType.Firmware, handler: { [weak self](info) in
                    self?.addLogInfo(mynt: self?.mynt, msg: "firmware -> \(info)")
                    })
                mynt?.readMyntInfo(MYNTInfoType.Hardware, handler: { [weak self](info) in
                    self?.addLogInfo(mynt: self?.mynt, msg: "hardware -> \(info)")
                    })
                mynt?.readMyntInfo(MYNTInfoType.Software, handler: { [weak self](info) in
                    self?.addLogInfo(mynt: self?.mynt, msg: "software -> \(info)")
                    })
                mynt?.readMyntInfo(MYNTInfoType.Model, handler: { [weak self](info) in
                    self?.addLogInfo(mynt: self?.mynt, msg: "model -> \(info)")
                    })
                mynt?.readMyntInfo(MYNTInfoType.Sn, handler: { [weak self](info) in
                    self?.addLogInfo(mynt: self?.mynt, msg: "sn -> \(info)")
                    })
                mynt?.readMyntInfo(MYNTInfoType.Manufaturer, handler: { [weak self](info) in
                    self?.addLogInfo(mynt: self?.mynt, msg: "manufaturer -> \(info)")
                    })
            case 4:
                mynt?.readControlMode({ [weak self](controlMode) in
                    self?.addLogInfo(mynt: self?.mynt, msg: "read control mode -> \(controlMode.name)")
                    })
            case 5:
                let alertView = UIAlertView(title: "write control mode", message: nil, delegate: self, cancelButtonTitle: "Cancel")
                alertView.tag = WriteControlModeTag
                alertView.addButtonWithTitle("Music")
                alertView.addButtonWithTitle("Camera")
                alertView.addButtonWithTitle("PPT")
                alertView.addButtonWithTitle("Custom")
                alertView.show()
            default:
                break
            }
        case WriteControlModeTag:
            switch buttonIndex {
            case 1:
                mynt?.writeControlMode(MYNTControlMode.Music)
                addLogInfo(mynt: mynt, msg: "write control mode -> Music")
            case 2:
                mynt?.writeControlMode(MYNTControlMode.Camera)
                addLogInfo(mynt: mynt, msg: "write control mode -> Camera")
            case 3:
                mynt?.writeControlMode(MYNTControlMode.PPT)
                addLogInfo(mynt: mynt, msg: "write control mode -> PPT")
            case 4:
                mynt?.writeControlMode(MYNTControlMode.Custom)
                addLogInfo(mynt: mynt, msg: "write control mode -> Custom")
            default:
                break
            }
        default:
            break
        }
    }
}

extension MyntViewController: STMyntDelegate {
    
    func connectSuccessHandler() {
        if let mynt = mynt {
            addLogInfo(mynt: mynt, msg: "manufaturer -> \(mynt.manufaturer)")
            addLogInfo(mynt: mynt, msg: "model -> \(mynt.model)")
            addLogInfo(mynt: mynt, msg: "sn -> \(mynt.sn)")
            addLogInfo(mynt: mynt, msg: "firmware -> \(mynt.firmware)")
            addLogInfo(mynt: mynt, msg: "software -> \(mynt.software)")
            addLogInfo(mynt: mynt, msg: "hardware -> \(mynt.hardware)")
            
            addLogInfo(mynt: mynt, msg: "control mode -> \(mynt.controlMode.name)")
            
            addLogInfo(mynt: mynt, msg: "click event -> \(mynt.click.name)")
            addLogInfo(mynt: mynt, msg: "doubleClick event -> \(mynt.doubleClick.name)")
            addLogInfo(mynt: mynt, msg: "tripleClick event -> \(mynt.tripleClick.name)")
            addLogInfo(mynt: mynt, msg: "hold event -> \(mynt.hold.name)")
            addLogInfo(mynt: mynt, msg: "clickHold event -> \(mynt.clickHold.name)")
        }
    }
    
    func myntDidDiscovered(mynt: STMynt) {
//        addLogInfo(mynt: mynt, msg: "myntDidDiscovered")
    }
    
    func myntDidDiscoveredTimeout(mynt: STMynt) {
//        addLogInfo(mynt: mynt, msg: "myntDidDiscoveredTimeout")
    }
    
    func myntDidStartConnect(mynt: STMynt) {
        addLogInfo(mynt: mynt, msg: "|--- myntDidStartConnect ---|")
    }
    
    func myntDidConnected(mynt: STMynt) {
        addLogInfo(mynt: mynt, msg: "|--- myntDidConnected ---|")
        connectSuccessHandler()
    }
    
    func mynt(mynt: STMynt, didConnectFailed error: NSError?) {
        addLogInfo(mynt: mynt, msg: "didConnectFailed \(error)")
    }
    
    func mynt(mynt: STMynt, didDisconnected error: NSError?) {
        addLogInfo(mynt: mynt, msg: "didDisconnected \(error)")
    }
    
    func mynt(mynt: STMynt, didUpdateRSSI RSSI: Int) {
        if let sn = self.mynt?.sn where self.mynt == mynt {
            self.title = "\(sn)[\(RSSI)]"
        }
    }
    
    func mynt(mynt: STMynt, didUpdateBattery battery: Int) {
        addLogInfo(mynt: mynt, msg: "didUpdateBattery \(battery)")
    }
    
    func mynt(mynt: STMynt, didUpdateAlarmState alarmState: Bool) {
        addLogInfo(mynt: mynt, msg: "alarmState \(alarmState)")
    }
    
    func mynt(mynt: STMynt, didUpdatePassword password: String?) {
        addLogInfo(mynt: mynt, msg: "didUpdatePassword \(password)")
    }
    
    func mynt(mynt: STMynt, didReceiveClickEvent clickEvent: MYNTClickEvent) {
        addLogInfo(mynt: mynt, msg: "didReceiveClickEvent \(clickEvent)")
    }
    
    func didRequestPassword(mynt: STMynt) -> String? {
        // 请求密钥
        return nil
    }
    
    func didRequestAutoconnect(mynt: STMynt) -> Bool {
        // 是否需要自动重连
        return false
    }
    
    func didNeedRestartBluetooth(mynt: STMynt) {
        // 连接异常时  回调此方法 通知需要重启蓝牙
    }
    
}
