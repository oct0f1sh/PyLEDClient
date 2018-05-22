//
//  RGBColorPickerView.swift
//  PyLEDClient
//
//  Created by Duncan MacDonald on 5/21/18.
//  Copyright © 2018 Duncan MacDonald. All rights reserved.
//

import Foundation
import UIKit

protocol RGBColorPickerDelegate: class {
    func colorPicker(sender: RGBColorPicker, updatedValue slider: (r: CGFloat, g: CGFloat, b: CGFloat))
}

@IBDesignable
class RGBColorPicker:UIView {
    var redSlider: UISlider!
    var greenSlider: UISlider!
    var blueSlider: UISlider!
    var previewView: UIView!
    
    weak var delegate: RGBColorPickerDelegate?
    
    override func draw(_ rect: CGRect) {
        layoutControls()
    }
    
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: CGFloat(250), height: CGFloat(140))
//    }
    
    func layoutControls() {
        let previewViewSize = CGFloat(35)
        
        previewView = UIView(frame: CGRect(x: bounds.midX - (previewViewSize / 2), y: bounds.minY, width: previewViewSize, height: previewViewSize))
        previewView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        previewView.roundedCorners(radius: Double(previewView.bounds.width / 2))
        
        redSlider = UISlider(frame: CGRect(x: bounds.minX, y: previewView.frame.maxY, width: bounds.width, height: 35))
        redSlider.tintColor = .red
        redSlider.tag = 0
        redSlider.setValue(0.5, animated: false)
        redSlider.addTarget(self, action: #selector(RGBColorPicker.sliderDidChange(_:)), for: .valueChanged)
        
        greenSlider = UISlider(frame: CGRect(x: bounds.minX, y: redSlider.frame.maxY, width: bounds.width, height: 35))
        greenSlider.tintColor = .green
        greenSlider.tag = 1
        greenSlider.setValue(0.5, animated: false)
        greenSlider.addTarget(self, action: #selector(RGBColorPicker.sliderDidChange(_:)), for: .valueChanged)
        
        blueSlider = UISlider(frame: CGRect(x: bounds.minX, y: greenSlider.frame.maxY, width: bounds.width, height: 35))
        blueSlider.tintColor = .blue
        blueSlider.tag = 2
        blueSlider.setValue(0.5, animated: false)
        blueSlider.addTarget(self, action: #selector(RGBColorPicker.sliderDidChange(_:)), for: .valueChanged)
        
        addSubview(previewView)
        addSubview(redSlider)
        addSubview(greenSlider)
        addSubview(blueSlider)
        
        layoutSubviews()
        
        setNeedsLayout()
    }
    
    @objc func sliderDidChange(_ sender: UISlider) {
        let r = CGFloat(redSlider.value)
        let g = CGFloat(greenSlider.value)
        let b = CGFloat(blueSlider.value)
        
        delegate?.colorPicker(sender: self, updatedValue: (r, g, b))
        
        self.previewView.backgroundColor = UIColor.init(red: r, green: g, blue: b, alpha: 1)
        
        layoutSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = .clear
    }
}
