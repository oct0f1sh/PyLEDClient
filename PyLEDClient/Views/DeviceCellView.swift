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
    
    override func awakeFromNib() {
        backgroundRoundedView.roundedCorners(radius: 15)
        backgroundRoundedView.roundedBorders(color: UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1), width: 1, cornerRadius: 15)
        
        super.awakeFromNib()
    }
}
