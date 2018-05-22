//
//  DeviceDetailViewController.swift
//  PyLEDClient
//
//  Created by Duncan MacDonald on 5/16/18.
//  Copyright © 2018 Duncan MacDonald. All rights reserved.
//

import Foundation
import UIKit

class DeviceDetailViewController: UIViewController {
    @IBOutlet weak var colorPickerView: RGBColorPicker!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    var r: CGFloat = 0.5
    var g: CGFloat = 0.5
    var b: CGFloat = 0.5
    
    override func viewDidLoad() {
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        colorPickerView.delegate = self
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        let payload = "solid_color"
        let args = "{\"r\": \(Int(self.r * 255)), \"g\": \(Int(self.g * 255)), \"b\": \(Int(self.b * 255)), \"duration\": \(Int(stepper.value))}"
        
        let message = JSONFormatter.formatToJson(message: payload, args: args)
        
        MQTTManager.sharedInstance.mqtt.publish("test", withString: message)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        durationLabel.text = String(Int(sender.value))
    }
}

extension DeviceDetailViewController: RGBColorPickerDelegate {
    func colorPicker(sender: RGBColorPicker, updatedValue slider: (r: CGFloat, g: CGFloat, b: CGFloat)) {
        self.r = slider.r
        self.g = slider.g
        self.b = slider.b
    }
}
