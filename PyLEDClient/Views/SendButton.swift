//
//  SendButton.swift
//  PyLEDClient
//
//  Created by Duncan MacDonald on 5/22/18.
//  Copyright © 2018 Duncan MacDonald. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class SendButton: UIButton {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
                                      radius: CGFloat(bounds.width / 2),
                                      startAngle: CGFloat(0),
                                      endAngle: CGFloat(Double.pi * 2),
                                      clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 1
        
        layer.addSublayer(shapeLayer)
    }
}
