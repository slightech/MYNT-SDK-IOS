//
//  MyntListViewController.swift
//  STMyntBluetooth
//
//  Created by gejw on 2017/7/21.
//  Copyright © 2017年 robinge. All rights reserved.
//

import UIKit

class MyntListViewController: UIViewController {

    var mynts = [STMynt]()

    var myntBluetooth: STMyntBluetooth?

    weak var viewController: MyntMainViewController?

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "MYNT SDK TEST"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sort", style: .done, target: self, action: #selector(didClickSortButton))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Scan", style: .done, target: self, action: #selector(didClickSearchButton))

        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "MyntTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyntTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self

        myntBluetooth = STMyntBluetooth.sharedInstance()
        myntBluetooth?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func didClickSortButton() {
        mynts = mynts.sorted(by: {$0.rssi > $1.rssi})
        tableView.reloadData()
    }

    func didClickSearchButton() {
        if myntBluetooth?.centralState == .poweredOff {
            Toast.show(message: "Bluetooth closed！")
            return
        }
        if myntBluetooth?.centralState == .unknown {
            Toast.show(message: "Bluetooth state unknown！")
            return
        }
        if myntBluetooth?.isScanning == true {
            myntBluetooth?.stopScan()
            self.navigationItem.rightBarButtonItem?.title = "Scan"
        } else {
            myntBluetooth?.startScan()
            self.navigationItem.rightBarButtonItem?.title = "Stop Scan"
        }
        tableView.reloadData()
    }

}

extension MyntListViewController: UITableViewDataSource, UITableViewDelegate {

    @objc open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mynts.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    @objc func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyntTableViewCell", for: indexPath) as! MyntTableViewCell
        cell.mynt = mynts[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mynt = mynts[indexPath.row]
        if mynt.isDiscovering {
            // 进入下一页
            let viewController = MyntMainViewController()
            viewController.mynt = mynt
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
            self.navigationController?.pushViewController(viewController, animated: true)
            self.viewController = viewController
        } else {
            
        }
    }
    
}

extension MyntListViewController: STMyntBluetoothDelegate {

    func myntBluetooth(_ myntBluetooth: STMyntBluetooth, didUpdate state: CBCentralManagerState) {
        if state != .poweredOn {
            mynts = []
            tableView.reloadData()
        }
    }

    func myntBluetooth(_ myntBluetooth: STMyntBluetooth, didDiscover mynt: STMynt) {
        if !mynts.contains(mynt) {
            mynts.append(mynt)
        }
        tableView.reloadData()
    }

    func myntBluetooth(_ myntBluetooth: STMyntBluetooth, didDiscoverTimeoutMynt mynt: STMynt) {
        tableView.reloadData()
    }

    func myntBluetooth(_ myntBluetooth: STMyntBluetooth, didPrintLog log: String) {
        viewController?.addLogInfo(mynt: viewController?.mynt, msg: log)
    }
}

