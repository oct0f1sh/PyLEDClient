//
//  UIView+RoundedCorners.swift
//  PyLEDClient
//
//  Created by Duncan MacDonald on 5/16/18.
//  Copyright © 2018 Duncan MacDonald. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func roundedCorners(radius: Double) {
        let corners: UIRectCorner = ([.topLeft, .topRight, .bottomLeft, .bottomRight])
        let maskPath1 = UIBezierPath(roundedRect: self.bounds,
                                     byRoundingCorners: corners,
                                     cornerRadii:CGSize(width:radius, height:radius))
        
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = self.bounds
        maskLayer1.path = maskPath1.cgPath
        self.layer.mask = maskLayer1
    }
    
    func roundedBorders(color: UIColor, width: CGFloat, cornerRadius: Double) {
        let corners: UIRectCorner = ([.topLeft, .topRight, .bottomLeft, .bottomRight])
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.path = path.cgPath
        self.layer.addSublayer(shapeLayer)
    }
}
