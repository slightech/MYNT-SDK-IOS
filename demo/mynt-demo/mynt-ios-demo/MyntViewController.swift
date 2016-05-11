//
//  MyntViewController.swift
//  mynt-ios-demo
//
//  Created by gejw on 16/5/11.
//  Copyright © 2016年 slighech. All rights reserved.
//

import UIKit

extension NSDate {
    
    class func currentTimeString() -> String {
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss:sss"
        return formatter.stringFromDate(date)
    }
    
}

class MyntViewController: UIViewController {
    
    weak var mynt: STMynt?
    
    @IBOutlet weak var logView: UITextView!
    var rightBarButtonItem: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        logTableView.tableFooterView = UIView()
//        logTableView.separatorStyle = .None
//        logTableView.rowHeight = 15
        logView.layoutManager.allowsNonContiguousLayout = false
        
        rightBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Done, target: self, action: #selector(MyntViewController._clickMenu(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem

        mynt?.delegate = self
        self.addLogInfo(mynt: mynt, msg: "|--- start connect ---|")
        mynt?.connect({ [weak self](mynt, needPair) in
            self?.addLogInfo(mynt: mynt, msg: "|--- need click mynt to pair ---|")
            }, success: { [weak self](mynt) in
                self?.addLogInfo(mynt: mynt, msg: "|--- connect success ---|")
            }, failure: { [weak self](mynt, error) in
                self?.addLogInfo(mynt: mynt, msg: "connect failure \(error)")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MyntViewController: STMyntDelegate {
    
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
