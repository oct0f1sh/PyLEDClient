//
//  DeviceCellView.swift
//  PyLEDClient
//
//  Created by Duncan MacDonald on 5/16/18.
//  Copyright © 2018 Duncan MacDonald. All rights reserved.
//

import Foundation
import UIKit

class DeviceCellView: UITableViewCell {
    @IBOutlet weak var backgroundRoundedView: UIView!
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var deviceStatusView: UIView!
    
    override func awakeFromNib() {
        let borderGray = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1)
        
        backgroundRoundedView.roundedCorners(radius: 15)
        backgroundRoundedView.roundedBorders(color: borderGray, width: 1, cornerRadius: 15)
        
        deviceStatusView.roundedCorners(radius: Double(deviceStatusView.frame.size.width / 2))
        deviceStatusView.roundedBorders(color: borderGray, width: 1, cornerRadius: Double(deviceStatusView.frame.size.width / 2))
        
        super.awakeFromNib()
    }
}
