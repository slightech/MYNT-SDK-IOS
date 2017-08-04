//
//  Toast.swift
//  STMyntBluetooth
//
//  Created by gejw on 2017/6/8.
//  Copyright © 2017年 robinge. All rights reserved.
//

import Foundation

class Toast {

    class func show(message: String) {
        CRToastManager.showNotification(options: [kCRToastTextKey: message,
                                                  kCRToastBackgroundColorKey: UIColor.red], completionBlock: nil)
    }

}
