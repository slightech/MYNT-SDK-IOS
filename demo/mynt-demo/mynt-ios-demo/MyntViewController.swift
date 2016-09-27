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
        case .music:
            return "Music"
        case .camera:
            return "Camera"
        case .PPT:
            return "PPT"
        case .custom:
            return "Custom"
        case .default:
            return "Default"
        default:
            return ""
        }
    }
}

extension MYNTClickEvent {
    
    var name: String {
        switch self {
        case .click:
            return "Click"
        case .doubleClick:
            return "DoubleClick"
        case .tripleClick:
            return "TripleClick"
        case .hold:
            return "Hold"
        case .clickHold:
            return "ClickHold"
        default:
            return ""
        }
    }
}

extension MYNTClickValue {
    
    var name: String {
        switch self {
        case .musicPlay:
            return "MusicPlay"
        case .musicNext:
            return "MusicNext"
        case .musicPrevious:
            return "MusicPrevious"
        case .musicVolumeUp:
            return "MusicVolumeUp"
        case .musicVolumeDown:
            return "MusicVolumeDown"
        case .cameraShutter:
            return "CameraShutter"
        case .cameraBurst:
            return "CameraBurst"
        case .pptExit:
            return "PPTExit"
        case .pptNextPage:
            return "PPTNextPage"
        case .pptPreviousPage:
            return "PPTPreviousPage"
        case .customClick:
            return "CustomClick"
        case .none:
            return "None"
        default:
            return ""
        }
    }
    
}

extension Date {
    
    static func currentTimeString() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss:sss"
        return formatter.string(from: date)
    }
    
}

class MyntViewController: UIViewController, UIAlertViewDelegate {
    
    let MenuAlertTag        = 10000
    let WriteControlModeTag = 10001
    let WriteClickEventTag = 10002
    let WriteClickValueTag = 10003
    
    let ControlModes: [MYNTControlMode] = [.music, .camera, .PPT, .custom]
    let ClickEvents: [MYNTClickEvent] = [.click, .doubleClick, .tripleClick, .hold, .clickHold]
    let EventValues: [MYNTClickValue] = [.musicPlay, .musicNext, .musicPrevious, .musicVolumeUp, .musicVolumeDown,
                                         .cameraShutter, .cameraBurst, .pptExit, .pptNextPage, .pptPreviousPage, .customClick, .none]
    
    weak var mynt: STMynt?
    
    @IBOutlet weak var logView: UITextView!
    var rightBarButtonItem: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logView.layoutManager.allowsNonContiguousLayout = false
        
        rightBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.done, target: self, action: #selector(MyntViewController._clickMenu(_:)))
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
    
    func addLogInfo(mynt: STMynt?, msg: String) {
        if self.mynt != mynt {
            return
        }
        logView.text = logView.text + "\(Date.currentTimeString()) \t\(msg)\n"
        logView.scrollRangeToVisible(NSRange(location: logView.text.characters.count - 1, length: 1))
    }
    
    @objc fileprivate func _clickMenu(_ sender: AnyObject) {
        let menuAlert = UIAlertView(title: "select action", message: nil, delegate: self, cancelButtonTitle: "Cancel")
        menuAlert.tag = MenuAlertTag
        menuAlert.addButton(withTitle: "Toggle alarm")
        menuAlert.addButton(withTitle: "Read battery")
        menuAlert.addButton(withTitle: "Read deviceInfo")
        menuAlert.addButton(withTitle: "Read control mode")
        menuAlert.addButton(withTitle: "Send control mode")
        menuAlert.addButton(withTitle: "Read click event")
        menuAlert.addButton(withTitle: "Send click event")
        menuAlert.addButton(withTitle: "Clean log")
        menuAlert.show()
    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
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
                mynt?.read(MYNTInfoType.firmware, handler: { [weak self](info) in
                    self?.addLogInfo(mynt: self?.mynt, msg: "firmware -> \(info)")
                    })
                mynt?.read(MYNTInfoType.hardware, handler: { [weak self](info) in
                    self?.addLogInfo(mynt: self?.mynt, msg: "hardware -> \(info)")
                    })
                mynt?.read(MYNTInfoType.software, handler: { [weak self](info) in
                    self?.addLogInfo(mynt: self?.mynt, msg: "software -> \(info)")
                    })
                mynt?.read(MYNTInfoType.model, handler: { [weak self](info) in
                    self?.addLogInfo(mynt: self?.mynt, msg: "model -> \(info)")
                    })
                mynt?.read(MYNTInfoType.sn, handler: { [weak self](info) in
                    self?.addLogInfo(mynt: self?.mynt, msg: "sn -> \(info)")
                    })
                mynt?.read(MYNTInfoType.manufaturer, handler: { [weak self](info) in
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
    
    var currentClickEvent = MYNTClickEvent.click
    func showAlart(_ title: String, tag: Int, items: [String]) {
        let alertView = UIAlertView(title: title, message: nil, delegate: self, cancelButtonTitle: "Cancel")
        alertView.tag = tag
        for item in items {
            alertView.addButton(withTitle: item)
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
    
    func myntDidStartConnect(_ mynt: STMynt) {
        addLogInfo(mynt: mynt, msg: "|--- myntDidStartConnect ---|")
    }
    
    func myntDidConnected(_ mynt: STMynt) {
        addLogInfo(mynt: mynt, msg: "|--- myntDidConnected ---|")
        connectSuccessHandler()
    }
    
    func mynt(_ mynt: STMynt, didConnectFailed error: NSError?) {
        addLogInfo(mynt: mynt, msg: "didConnectFailed \(error)")
    }
    
    func mynt(_ mynt: STMynt, didDisconnected error: NSError?) {
        addLogInfo(mynt: mynt, msg: "didDisconnected \(error)")
    }
    
    func mynt(_ mynt: STMynt, didUpdateRSSI RSSI: Int) {
        if let sn = self.mynt?.sn , self.mynt == mynt {
            self.title = "\(sn)[\(RSSI)]"
        }
    }
    
    func mynt(_ mynt: STMynt, didUpdateBattery battery: Int) {
        addLogInfo(mynt: mynt, msg: "didUpdateBattery \(battery)")
    }
    
    func mynt(_ mynt: STMynt, didUpdateAlarmState alarmState: Bool) {
        addLogInfo(mynt: mynt, msg: "alarmState \(alarmState)")
    }
    
    func mynt(_ mynt: STMynt, didReceive clickEvent: MYNTClickEvent) {
        addLogInfo(mynt: mynt, msg: "didReceiveClickEvent \(clickEvent.name)")
    }
    
    func didRequestAutoconnect(_ mynt: STMynt) -> Bool {
        // 是否需要自动重连
        return true
    }
    
    func didNeedRestartBluetooth(_ mynt: STMynt) {
        // 连接异常时  回调此方法 通知需要重启蓝牙
    }
    
}
