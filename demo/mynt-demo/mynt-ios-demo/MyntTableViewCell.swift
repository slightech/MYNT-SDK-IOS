//
//  MyntTableViewCell.swift
//  mynt-ios-demo
//
//  Created by gejw on 16/5/11.
//  Copyright © 2016年 slighech. All rights reserved.
//

import UIKit

class MyntTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var snLabel: UILabel!
    @IBOutlet weak var rssiLabel: UILabel!
    
    var discovered: Bool = true {
        didSet {
            if discovered != oldValue {
                snLabel.textColor = discovered ? UIColor.black : UIColor.lightGray
                rssiLabel.textColor = discovered ? UIColor.black : UIColor.lightGray
                nameLabel.textColor = discovered ? UIColor.black : UIColor.lightGray
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
