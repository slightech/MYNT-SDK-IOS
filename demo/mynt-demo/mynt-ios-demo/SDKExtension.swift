//
//  SDKExtension.swift
//  STMyntBluetooth
//
//  Created by gejw on 2017/6/8.
//  Copyright © 2017年 robinge. All rights reserved.
//

import Foundation

fileprivate var isAutoConnectingKey = 1
extension STMynt {

    var isAutoConnecting: Bool {
        set {
            objc_setAssociatedObject(self, &isAutoConnectingKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            let result = objc_getAssociatedObject(self, &isAutoConnectingKey) as? Bool
            return result == nil ? false : result!
        }
    }
}

extension MYNTState {

    var name: String {
        switch self {
        case .connected:
            return "Connected"
        case .disconnected:
            return "Disconnected"
        case .connecting:
            return "Connecting..."
        case .startConnecting:
            return "Start connecting..."
        }
    }

    var buttonText: String {
        switch self {
        case .disconnected:
            return "Connect"
        default:
            return "Disconnect"
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
        case .phoneAlarm:
            return "phoneAlarm"
        case .phoneAlarmOff:
            return "phoneAlarmOff"
        case .phoneFlash:
            return "phoneFlash"
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
        case .askHelp:
            return "askHelp"
        case .phoneAlarm:
            return "phoneAlarm"
        case .phoneFlash:
            return "phoneFlash"
        }
    }
    
}
