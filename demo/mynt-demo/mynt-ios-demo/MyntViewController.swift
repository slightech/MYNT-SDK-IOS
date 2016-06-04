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
        default:
            return ""
        }
    }
}

extension MYNTClickEvent {
    
    var name: String {
        switch self {
        case .Click:
            return "Click"
        case .DoubleClick:
            return "DoubleClick"
        case .TripleClick:
            return "TripleClick"
        case .Hold:
            return "Hold"
        case .ClickHold:
            return "ClickHold"
        default:
            return ""
        }
    }
}

extension MYNTClickValue {
    
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
        case .CustomClick:
            return "CustomClick"
        case .None:
            return "None"
        default:
            return ""
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
    let WriteClickEventTag = 10002
    let WriteClickValueTag = 10003
    
    let ControlModes: [MYNTControlMode] = [.Music, .Camera, .PPT, .Custom]
    let ClickEvents: [MYNTClickEvent] = [.Click, .DoubleClick, .TripleClick, .Hold, .ClickHold]
    let EventValues: [MYNTClickValue] = [.MusicPlay, .MusicNext, .MusicPrevious, .MusicVolumeUp, .MusicVolumeDown,
                                         .CameraShutter, .CameraBurst, .PPTExit, .PPTNextPage, .PPTPreviousPage, .CustomClick, .None]
    
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
        mynt?.connect()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    deinit {
        mynt?.delegate = nil
        mynt?.disconnect()
    }
    
    override func removeFromParentViewController() {
        super.removeFromParentViewController()
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
        let menuAlert = UIAlertView(title: "select action", message: nil, delegate: self, cancelButtonTitle: "Cancel")
        menuAlert.tag = MenuAlertTag
        menuAlert.addButtonWithTitle("Toggle alarm")
        menuAlert.addButtonWithTitle("Read battery")
        menuAlert.addButtonWithTitle("Read deviceInfo")
        menuAlert.addButtonWithTitle("Read control mode")
        menuAlert.addButtonWithTitle("Send control mode")
        menuAlert.addButtonWithTitle("Read click event")
        menuAlert.addButtonWithTitle("Send click event")
        menuAlert.addButtonWithTitle("Clean log")
        menuAlert.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0 {
            return
        }
        switch alertView.tag {
        case MenuAlertTag:
            switch buttonIndex {
            case 1:
                mynt?.toggleAlarm(true)
            case 2:
                addLogInfo(mynt: mynt, msg: "")
                mynt?.readBattery({ [weak self](battery) in
                    self?.addLogInfo(mynt: self?.mynt, msg: "battery -> \(battery)")
                    })
            case 3:
                self.addLogInfo(mynt: mynt, msg: "")
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
                showAlart("write control mode", tag: WriteControlModeTag, items: ControlModes.map({"\($0.name)"}))
            case 6:
                addLogInfo(mynt: mynt, msg: "")
                mynt?.readClickValue({ [weak self](click, doubleClick, tripleClick, hold, clickHold) in
                    self?.addLogInfo(mynt: self?.mynt, msg: "click -> \(click.name)")
                    self?.addLogInfo(mynt: self?.mynt, msg: "doubleClick -> \(doubleClick.name)")
                    self?.addLogInfo(mynt: self?.mynt, msg: "tripleClick -> \(tripleClick.name)")
                    self?.addLogInfo(mynt: self?.mynt, msg: "hold -> \(hold.name)")
                    self?.addLogInfo(mynt: self?.mynt, msg: "clickHold -> \(clickHold.name)")
                })
            case 7:
                showAlart("select click event", tag: WriteClickEventTag, items: ClickEvents.map({"\($0.name)"}))
            case 8:
                logView.text = ""
            default:
                break
            }
        case WriteControlModeTag:
            mynt?.writeControlMode(ControlModes[buttonIndex - 1])
            addLogInfo(mynt: mynt, msg: "write control mode -> \(ControlModes[buttonIndex - 1].name)")
            
        case WriteClickEventTag:
            currentClickEvent = ClickEvents[buttonIndex - 1]
            showAlart("write click value", tag: WriteClickValueTag, items: EventValues.map({"\($0.name)"}))
            
        case WriteClickValueTag:
            mynt?.writeClickValue(currentClickEvent, eventValue: EventValues[buttonIndex - 1])
            addLogInfo(mynt: mynt, msg: "write click value  \(currentClickEvent.name)-> \(EventValues[buttonIndex - 1].name)")
        default:
            break
        }
    }
    
    var currentClickEvent = MYNTClickEvent.Click
    func showAlart(title: String, tag: Int, items: [String]) {
        let alertView = UIAlertView(title: title, message: nil, delegate: self, cancelButtonTitle: "Cancel")
        alertView.tag = tag
        for item in items {
            alertView.addButtonWithTitle(item)
        }
        alertView.show()
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
    
    func mynt(mynt: STMynt, didReceiveClickEvent clickEvent: MYNTClickEvent) {
        addLogInfo(mynt: mynt, msg: "didReceiveClickEvent \(clickEvent.name)")
    }
    
    func didRequestAutoconnect(mynt: STMynt) -> Bool {
        // 是否需要自动重连
        return true
    }
    
    func didNeedRestartBluetooth(mynt: STMynt) {
        // 连接异常时  回调此方法 通知需要重启蓝牙
    }
    
}
