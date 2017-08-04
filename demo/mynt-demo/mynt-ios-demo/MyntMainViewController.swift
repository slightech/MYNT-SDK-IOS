//
//  MyntMainViewController.swift
//  STMyntBluetooth
//
//  Created by gejw on 2017/7/21.
//  Copyright © 2017年 robinge. All rights reserved.
//

import UIKit

extension Date {

    static var time: String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss:sss"
        return formatter.string(from: date)
    }

}

func showAlert(message: String) {
    let alert = UIAlertView(title: "Message", message: message, delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "OK")
    alert.show()
}

enum Event: String {

    case oad                = "Update firmware"
    case readBattery        = "Read value of battery quantity"
    case writeRingtone      = "Write values of ringtone"
    case readRingtone       = "Read the ringtone values"
    case writeEvent         = "Write control event (Click, etc.)"
    case readEvent          = "Read control event (Click, etc.)"
    case writeAlarmCount    = "Write values of alarm times"
    case writeAlarmDelay    = "Write values of alarm delay"
    case switchBLE          = "Switch to BLE mode"

    case sync                   = "Sync Date"
    case shutdown               = "Shutdown"
    case writeLocationInterval  = "Write the interval value of prositioning"
    case readLocationInterval   = "Read the interval values of prositioning"
    case readICCID              = "Read ICCID values"
    case checkNetwork           = "Check Network"

}

class MyntMainViewController: UIViewController {

    weak var mynt: STMynt?
    var password: String?

    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var logTextView: UITextView!
    @IBOutlet weak var alarmButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    var items: [Event] = [.oad, .readBattery, .writeRingtone, .readRingtone, .writeEvent, .readEvent, .writeAlarmCount, .writeAlarmDelay, .switchBLE]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initializing components

        self.title = mynt?.sn
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Disconnect", style: .done, target: self, action: #selector(didClickConnectButton))

        self.tableView.delegate = self
        self.tableView.dataSource = self

        mynt?.delegate = self
        if mynt?.state != MYNTState.connected {
            mynt?.isAutoConnecting = true
            mynt?.connect()
        }
        updateState()

        if mynt?.hardwareType == .MYNTGPS {
            let gpsItems: [Event] = [.sync, .shutdown, .writeLocationInterval, .readLocationInterval, .readICCID, .checkNetwork]
            items += gpsItems
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func didClickConnectButton() {
        if mynt?.state == .disconnected {
            self.navigationItem.rightBarButtonItem?.title = "Disconnect"
            mynt?.isAutoConnecting = true
            mynt?.connect()
        } else {
            self.navigationItem.rightBarButtonItem?.title = "Connect"
            mynt?.isAutoConnecting = false
            mynt?.disconnect()
        }
    }

    // MARK: ---- Click event ----

    @IBAction func didClickCleanLogButton(_ button: UIButton) {
        logTextView.text = ""
    }

    @IBAction func didClickAlarmButton(_ button: UIButton) {
        mynt?.toggleAlarm(mynt?.isAlarm != true, handler: { error in

        })
    }

    // MARK: ---- TableView Click event ----

    func didClickFirmwareButton() {
        mynt?.updateFirmware({ () -> Data? in
            return nil
        }, progress: { progress in

        }, success: {

        }, failure: { error in

        })
    }

    func didClickReadBatteryButton() {
        mynt?.readBattery({ batteries in
            showAlert(message: "Read battery quantity value \(batteries)")
        }, failure: { error in
            showAlert(message: "Failed to read battery quantity \(String(describing: error))")
        })
    }

    func didClickSetRingButton() {
        //        let musicHigh = [1: 1047,
        //                         2: 1175,
        //                         3: 1319,
        //                         4: 1397,
        //                         5: 1568,
        //                         6: 1760,
        //                         7: 1967]
        // Internal
        let music1 = [[1047, 100],
                      [0, 50],
                      [1175, 100],
                      [0, 50],
                      [1319, 100],
                      [0, 50],
                      [1047, 100],
                      [0, 50],
                      [1175, 100],
                      [0, 50],
                      [1319, 100],
                      [0, 50],

                      [2731, 200],
                      [0, 50],
                      [2731, 200],
                      [0, 50],
                      [ 2731, 200],
                      [0, 50],

                      [1397, 100],
                      [0, 50],
                      [1568, 100],
                      [0, 50],
                      [1760, 100],
                      [0, 50],
                      [1397, 100],
                      [0, 50],
                      [1568, 100],
                      [0, 50],
                      [1760, 100],
                      [0, 50],

                      [2731, 200],
                      [0, 50],
                      [2731, 200],
                      [0, 50],
                      [2731, 200],
                      [0, 50]]

        // Two tigers
        let music2 = [[1046, 410],
                      [1175, 398],
                      [1318, 387],
                      [1046, 410],

                      [1046, 410],
                      [1175, 398],
                      [1318, 387],
                      [1046, 410],

                      [1318, 387],
                      [1397, 382],
                      [1568, 600],

                      [1318, 387],
                      [1397, 382],
                      [1568, 600]]


        let data = NSMutableData()
        ((Int(arc4random() % 9) % 2 == 0) ? music1 : music2).forEach { (result) in
            result.forEach({ (int) in
                var value: Int = int
                data.append(NSData(bytes: &value, length: 2) as Data)
            })
        }
        NSLog("\ndata\t%@\nlength\t%i", data, data.length)
        mynt?.writeRingtone(data as Data, version: 0xff) { error in

        }
    }

    func didClickReadRingButton() {
        mynt?.readRingtoneVersion { varsion, error in
            showAlert(message: "Read ringtone version \(varsion)")
        }
    }

    func didClickSetControlButton() {
        let click = MYNTClickValue(rawValue: Int(arc4random() % 9))!
        let doubleClick = MYNTClickValue(rawValue: Int(arc4random() % 9))!
        let tripleClick = MYNTClickValue(rawValue: Int(arc4random() % 9))!
        let hold = MYNTClickValue(rawValue: Int(arc4random() % 9))!
        let clickHold = MYNTClickValue(rawValue: Int(arc4random() % 9))!
        mynt?.writeClickValue(true,
                              click: click,
                              doubleClick: doubleClick,
                              tripleClick: tripleClick,
                              hold: hold,
                              clickHold: clickHold,
                              handler: { error in
                                showAlert(message: "Write control mode \(error == nil ? "Succeeded\n\(click.name)\n\(doubleClick.name)\n\(tripleClick.name)\n\(hold.name)\n\(clickHold.name)" : "Failed")")
        })
    }

    func didClickReadControlButton() {
        mynt?.readClickValue({ (click, doubleClick, tripleClick, hold, clickHold) in
            showAlert(message: "Succeeded to read control event\n\(click.name)\n\(doubleClick.name)\n\(tripleClick.name)\n\(hold.name)\n\(clickHold.name)")
        }, failure: { error in
            showAlert(message: "Fialed to read control event \(String(describing: error))")
        })
    }

    func didClickSetAlarmCountButton() {
        let count = Int(arc4random() % 9)
        mynt?.writeAlarmCount(count, handler: { error in
            showAlert(message: "Write the value of alarm times \(error == nil ? "Succeeded \(count)" : "Failed")")
        })
    }

    func didClickSetAlarmDelayButton() {
        let delay = Int(arc4random() % 9)
        mynt?.writeAlarmDelay(delay, handler: { error in
            showAlert(message: "Read / write how long the alarm will be delayed \(error == nil ? "Succeeded \(delay)" : "Failed")")
        })
    }

    func didClickBLEButton() {
        mynt?.writeClickValue(false,
                              click: .none,
                              doubleClick: .none,
                              tripleClick: .none,
                              hold: .none,
                              clickHold: .none,
                              handler: { error in
                                showAlert(message: "Succeeded to write")
        })
    }


    // MARK: ---- Dedicated to MYNT GPS product ----

    func didClickSyncDateButton() {
        mynt?.syncTime { error in

        }
    }

    func didClickShutdownButton() {
        mynt?.shutdown { error in

        }
    }

    func didClickSetLocatioIntervalnButton() {
        mynt?.writeLocateInterval(Int(arc4random() % 20) + 1) { error in

        }
    }

    func didClickReadLocationIntervalButton() {
        mynt?.readLocateInterval { interval, error in
            showAlert(message: "Read  \(interval)")
        }
    }

    func didClickReadICCIDButton() {
        mynt?.readICCID { iccid, error in
            let message = error != nil ? error?.localizedDescription : iccid
            showAlert(message: "Read ICCID \(String(describing: message))")
        }
    }

    @IBAction func didClickCheckNetButton() {
        mynt?.checkNetwork { error in

        }
    }

    @IBAction func didClickWriteAPNButton() {
        let alert = UIAlertView(title: "Please input apn", message: "", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "OK")
        alert.alertViewStyle = .plainTextInput
        alert.tag = 10000
        alert.show()
    }

}

extension MyntMainViewController: UIAlertViewDelegate {

    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        switch alertView.tag {
        case 10000:
            if buttonIndex == 1 {
                guard let apn = alertView.textField(at: 0)?.text else {
                    return
                }
                mynt?.writeAPN(apn) { error in

                }
            }
        default:
            break
        }
    }

}

// MARK: ---- STMyntDelegate ----
extension MyntMainViewController: STMyntDelegate {

    func updateState() {
        guard let mynt = mynt else { return }
        stateLabel.text = "State: \(mynt.state.name)"
    }

    func addLogInfo(mynt: STMynt?, msg: String) {
        if self.mynt != mynt { return }
        logTextView.text = logTextView.text + "\(Date.time) \t\(msg)\n"
        UIView.setAnimationsEnabled(false)
        logTextView.scrollRangeToVisible(NSRange(location: logTextView.text.characters.count - 1, length: 1))
        UIView.setAnimationsEnabled(true)
    }

    func connectSuccessHandler() {
        if let mynt = mynt {
            addLogInfo(mynt: mynt, msg: "manufaturer -> \(String(describing: mynt.manufaturer))")
            addLogInfo(mynt: mynt, msg: "model -> \(String(describing: mynt.model))")
            addLogInfo(mynt: mynt, msg: "sn -> \(mynt.sn)")
            addLogInfo(mynt: mynt, msg: "firmware -> \(String(describing: mynt.firmware))")
            addLogInfo(mynt: mynt, msg: "software -> \(String(describing: mynt.software))")
            addLogInfo(mynt: mynt, msg: "hardware -> \(String(describing: mynt.hardware))")
            addLogInfo(mynt: mynt, msg: "macAddress -> \(String(describing: mynt.mac))")
        }
    }

    func myntDidStartConnect(_ mynt: STMynt) {
        self.navigationItem.rightBarButtonItem?.title = "disconnect"
        updateState()
    }

    func myntDidConnected(_ mynt: STMynt) {
        connectSuccessHandler()
        updateState()
    }

    func mynt(_ mynt: STMynt, didDisconnected error: Error?) {
        updateState()
        self.navigationItem.rightBarButtonItem?.title = "connect"
    }

    func mynt(_ mynt: STMynt, didUpdateRSSI RSSI: Int) {
        if let sn = self.mynt?.sn , self.mynt == mynt {
            self.title = "\(sn)[\(RSSI)]"
        }
    }

    func mynt(_ mynt: STMynt, didUpdateBattery batteries: [NSNumber]) {
        addLogInfo(mynt: mynt, msg: "delegate - didUpdateBattery \(batteries)")
    }

    func mynt(_ mynt: STMynt, didUpdateAlarmState alarmState: Bool) {
        addLogInfo(mynt: mynt, msg: "alarmState \(alarmState)")
        alarmButton.setTitle(alarmState ? "Stop alarm" : "Alarm", for: .normal)
    }

    func mynt(_ mynt: STMynt, didReceive clickEvent: MYNTClickEvent) {
        addLogInfo(mynt: mynt, msg: "didReceiveClickEvent \(clickEvent.name)")
    }
    
    func didRequestAutoconnect(_ mynt: STMynt) -> Bool {
        // Whether need to reconnect automatically
        return mynt.isAutoConnecting
    }
    
    func didNeedRestartBluetooth(_ mynt: STMynt) {
        stateLabel.text = "please restart the bluetooth"
    }
    
    func didRequestPassword(_ mynt: STMynt) -> String? {
        return password
    }
    
    func mynt(_ mynt: STMynt, didUpdatePassword password: String?) {
        self.password = password
    }
    
}

extension MyntMainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = items[indexPath.row].rawValue
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch items[indexPath.row] {
        case .oad:
            didClickFirmwareButton()
        case .readBattery:
            didClickReadBatteryButton()
        case .writeRingtone:
            didClickSetRingButton()
        case .readRingtone:
            didClickReadRingButton()
        case .writeEvent:
            didClickSetControlButton()
        case .readEvent:
            didClickReadControlButton()
        case .writeAlarmCount:
            didClickSetAlarmCountButton()
        case .writeAlarmDelay:
            didClickSetAlarmDelayButton()
        case .switchBLE:
            didClickBLEButton()

        case .sync:
            didClickSyncDateButton()
        case .shutdown:
            didClickShutdownButton()
        case .writeLocationInterval:
            didClickSetLocatioIntervalnButton()
        case .readLocationInterval:
            didClickReadLocationIntervalButton()
        case .readICCID:
            didClickReadICCIDButton()
        case .checkNetwork:
            didClickCheckNetButton()
        }
    }

}
