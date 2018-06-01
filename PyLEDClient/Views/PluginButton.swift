//
//  PluginButton.swift
//  PyLEDClient
//
//  Created by Duncan MacDonald on 6/1/18.
//  Copyright © 2018 Duncan MacDonald. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class PluginButton: UIButton {
    @IBInspectable var cornerRadius: Double = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.gray {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            setNeedsLayout()
        }
    }
    
    override func draw(_ rect: CGRect) {
        self.roundedBorders(color: borderColor, width: borderWidth, cornerRadius: cornerRadius)
    }
}
