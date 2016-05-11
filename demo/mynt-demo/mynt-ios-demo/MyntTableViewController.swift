//
//  MyntTableViewController.swift
//  mynt-ios-demo
//
//  Created by gejw on 16/5/11.
//  Copyright © 2016年 slighech. All rights reserved.
//

import UIKit

extension STMynt {
    private struct AssociatedKeys {
        static var DiscoveredName = "mt_DiscoveredName"
    }
    
    var discovered: Bool {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.DiscoveredName, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let discovered = objc_getAssociatedObject(self, &AssociatedKeys.DiscoveredName) as? Bool {
                return discovered
            }
            return false
        }
    }
}

class MyntTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var myntBluetooth: STMyntBluetooth?
    var mynts = [STMynt]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "mynt list"
        
        tableView.registerNib(UINib(nibName: "MyntTableViewCell", bundle: nil), forCellReuseIdentifier: "MyntTableViewCell")
        tableView.tableFooterView = UIView()
        
        // init bluetooth
        myntBluetooth = STMyntBluetooth.sharedInstance()
        myntBluetooth?.delegate = self
        myntBluetooth?.startScan()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickResearch(sender: AnyObject) {
        mynts = []
        tableView.reloadData()
    }

}

extension MyntTableViewController: STMyntBluetoothDelegate {
    
    func myntBluetooth(myntBluetooth: STMyntBluetooth, didUpdateState state: CBCentralManagerState) {
    }
    
    func myntBluetooth(myntBluetooth: STMyntBluetooth, didDiscoverMynt mynt: STMynt) {
        if !mynts.contains(mynt) {
            mynts.append(mynt)
        }
        mynt.discovered = true
        tableView.reloadData()
    }
    
    func myntBluetooth(myntBluetooth: STMyntBluetooth, didDiscoverTimeoutMynt mynt: STMynt) {
        mynt.discovered = false
        tableView.reloadData()
    }
    
}

extension MyntTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mynts.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyntTableViewCell", forIndexPath: indexPath) as? MyntTableViewCell
        
        let mynt = mynts[indexPath.row]
        cell?.snLabel?.text = "SN: \(mynt.sn)"
        cell?.rssiLabel?.text = "RSSI: \(mynt.RSSI)"
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
    }
    
}