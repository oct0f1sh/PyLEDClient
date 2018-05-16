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
        
        super.awakeFromNib()
    }
}
