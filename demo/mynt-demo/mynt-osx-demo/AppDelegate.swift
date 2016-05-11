//
//  AppDelegate.swift
//  mynt-osx-demo
//
//  Created by gejw on 16/4/24.
//  Copyright © 2016年 slighech. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var tableView: NSTableView!
    var mynts = [STMynt]()

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        let bluetooth = STMyntBluetooth.sharedInstance()
        bluetooth.delegate = self
        bluetooth.startScan()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

}

extension AppDelegate: NSTableViewDelegate, NSTableViewDataSource {
    
}

extension AppDelegate: STMyntBluetoothDelegate {
    
    func myntBluetooth(myntBluetooth: STMyntBluetooth, didUpdateState state: CBCentralManagerState) {
        
    }
    
    func myntBluetooth(myntBluetooth: STMyntBluetooth, didDiscoverTimeoutMynt mynt: STMynt) {
        
    }
    
    func myntBluetooth(myntBluetooth: STMyntBluetooth, didDiscoverMynt mynt: STMynt) {
        if !mynts.contains(mynt) {
            mynts.append(mynt)
        }
    }
    
}