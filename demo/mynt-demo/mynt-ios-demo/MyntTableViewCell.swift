//
//  MyntTableViewCell.swift
//  STMyntBluetooth
//
//  Created by gejw on 2017/6/8.
//  Copyright © 2017年 robinge. All rights reserved.
//

import UIKit

fileprivate extension MYNTHardwareType {

    var name: String {
        switch self {
        case .MYNTV1:
            return "MYNT-BLE"
        case .MYNTV2:
            return "MYNT"
        case .MYNTGPS:
            return "MYNT-GPS"
        case .none:
            return ""
        }
    }
}

fileprivate extension STMynt {

    var icon: UIImage? {
        switch self.hardwareType {
        case .MYNTGPS:
            return UIImage(named: "mynt_gps_icon")?.withRenderingMode(.alwaysTemplate)
        default:
            return UIImage(named: "mynt_icon")?.withRenderingMode(.alwaysTemplate)
        }
    }

}

class MyntTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var snLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var signalLabel: UILabel!
    @IBOutlet weak var cornerRadiusView: UIView!
    @IBOutlet weak var stateLabel: UILabel!

    @IBOutlet weak var shadeView: UIView!

    var mynt: STMynt? {
        didSet {
            guard let mynt = mynt else { return }
            iconImageView.image = mynt.icon
            nameLabel.text = "\(mynt.name)"
            snLabel.text = "\(mynt.sn)"
            signalLabel.text = "\(mynt.rssi) dBm"
            infoLabel.text = "MYNT Type: \(mynt.hardwareType.name)"
            stateLabel.text = "\(mynt.state.name)"

            shadeView.isHidden = mynt.isDiscovering
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        shadeView.layer.cornerRadius = 4
        cornerRadiusView.layer.cornerRadius = 4
        cornerRadiusView.layer.shadowColor = UIColor.black.cgColor
        cornerRadiusView.layer.shadowOffset = .zero
        cornerRadiusView.layer.shadowOpacity = 0.15
        cornerRadiusView.layer.shadowRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
