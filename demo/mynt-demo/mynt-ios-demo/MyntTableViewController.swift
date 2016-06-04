//
//  MyntTableViewController.swift
//  mynt-ios-demo
//
//  Created by gejw on 16/5/11.
//  Copyright © 2016年 slighech. All rights reserved.
//

import UIKit

class MyntTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var myntBluetooth: STMyntBluetooth?
    var mynts = [STMynt]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Search MYNTs"
        
        tableView.registerNib(UINib(nibName: "MyntTableViewCell", bundle: nil), forCellReuseIdentifier: "MyntTableViewCell")
        tableView.tableFooterView = UIView()
        
        // init bluetooth
        myntBluetooth = STMyntBluetooth.sharedInstance()
        STMyntBluetooth.sharedInstance().delegate = self
        STMyntBluetooth.sharedInstance().startScan()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickResearch(sender: AnyObject) {
        mynts = []
        tableView.reloadData()
        
        myntBluetooth?.startScan()
    }

}

extension MyntTableViewController: STMyntBluetoothDelegate {
    
    func myntBluetooth(myntBluetooth: STMyntBluetooth, didUpdateState state: CBCentralManagerState) {
        
    }
    
    func myntBluetooth(myntBluetooth: STMyntBluetooth, didDiscoverMynt mynt: STMynt) {
//        if !mynt.sn.hasPrefix("98") {
//            return
//        }
        if !mynts.contains(mynt) {
            mynts.append(mynt)
        }
        tableView.reloadData()
    }
    
    func myntBluetooth(myntBluetooth: STMyntBluetooth, didDiscoverTimeoutMynt mynt: STMynt) {
        tableView.reloadData()
    }
    
//    func myntBluetooth(myntBluetooth: STMyntBluetooth, didFilterMyntWithSn sn: String) -> Bool {
//        // 过滤小觅
//        return sn != "B02CE9H9A0" && sn != "KB9F7HR3Q0" && sn != "XG2PF9H9A0"
//        //            && sn != "E5G37HR3Q0"
//    }
    
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
        cell?.snLabel?.text = "\(mynt.sn)"
        cell?.nameLabel?.text = "\(mynt.name)"
        cell?.rssiLabel?.text = "RSSI: \(mynt.RSSI)"
        cell?.discovered = mynt.isDiscovering
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        let mynt = mynts[indexPath.row]
        if mynt.isDiscovering {
            let viewController = MyntViewController()
            
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Done, target: nil, action: nil)
            viewController.mynt = mynt
            viewController.title = mynt.sn
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}