//
//  MyntTableViewCell.swift
//  mynt-ios-demo
//
//  Created by gejw on 16/5/11.
//  Copyright © 2016年 slighech. All rights reserved.
//

import UIKit

class MyntTableViewCell: UITableViewCell {

    @IBOutlet weak var snLabel: UILabel!
    @IBOutlet weak var rssiLabel: UILabel!
    
    var discovered: Bool = true {
        didSet {
            if discovered != oldValue {
                snLabel.textColor = discovered ? UIColor.whiteColor() : UIColor.lightGrayColor()
                rssiLabel.textColor = discovered ? UIColor.whiteColor() : UIColor.lightGrayColor()
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
