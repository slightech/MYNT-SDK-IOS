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
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Search MYNTs"
        
        tableView.register(UINib(nibName: "MyntTableViewCell", bundle: nil), forCellReuseIdentifier: "MyntTableViewCell")
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
    
    @IBAction func clickResearch(_ sender: AnyObject) {
        mynts = []
        tableView.reloadData()
        label.text = "size: \(mynts.count)"
        
        myntBluetooth?.startScan()
    }

}

extension MyntTableViewController: STMyntBluetoothDelegate {
    
    func myntBluetooth(_ myntBluetooth: STMyntBluetooth, didUpdate state: CBCentralManagerState) {
        
    }
    
    func myntBluetooth(_ myntBluetooth: STMyntBluetooth, didDiscover mynt: STMynt) {
//        if !mynt.sn.hasPrefix("98") {
//            return
//        }
        if !mynts.contains(mynt) {
            mynts.append(mynt)
        }
        tableView.reloadData()
        label.text = "size: \(mynts.count)"
    }
    
    func myntBluetooth(_ myntBluetooth: STMyntBluetooth, didDiscoverTimeoutMynt mynt: STMynt) {
        tableView.reloadData()
        label.text = "size: \(mynts.count)"
    }
    
//    func myntBluetooth(myntBluetooth: STMyntBluetooth, didFilterMyntWithSn sn: String) -> Bool {
//        // 过滤小觅
//        return sn != "B02CE9H9A0" && sn != "KB9F7HR3Q0" && sn != "XG2PF9H9A0"
//        //            && sn != "E5G37HR3Q0"
//    }
    
}

extension MyntTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mynts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyntTableViewCell", for: indexPath) as? MyntTableViewCell
        
        let mynt = mynts[(indexPath as NSIndexPath).row]
        cell?.snLabel?.text = "\(mynt.sn)"
        cell?.nameLabel?.text = "\(mynt.name)"
        cell?.rssiLabel?.text = "RSSI: \(mynt.rssi)"
        cell?.discovered = mynt.isDiscovering
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let mynt = mynts[(indexPath as NSIndexPath).row]
        if mynt.isDiscovering {
            let viewController = MyntViewController()
            
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.done, target: nil, action: nil)
            viewController.mynt = mynt
            viewController.title = mynt.sn
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}
