//
//  MQTTSettingsViewController.swift
//  PyLEDClient
//
//  Created by Duncan MacDonald on 5/22/18.
//  Copyright © 2018 Duncan MacDonald. All rights reserved.
//

import Foundation
import UIKit

class MQTTSettingsViewController: UIViewController {
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var portTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        if let url = MQTTManager.sharedInstance.valet.string(forKey: "url") {
            if let port = MQTTManager.sharedInstance.valet.string(forKey: "port") {
                if let username = MQTTManager.sharedInstance.valet.string(forKey: "username") {
                    if let password = MQTTManager.sharedInstance.valet.string(forKey: "password") {
                        self.urlTextField.text = url
                        self.portTextField.text = port
                        self.usernameTextField.text = username
                        self.passwordTextField.text = password
                    }
                }
            }
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let urlText = urlTextField.text {
            if let portText = portTextField.text {
                if let usernameText = usernameTextField.text {
                    if let passwordText = passwordTextField.text {
                        MQTTManager.sharedInstance.valet.set(string: urlText, forKey: "url")
                        MQTTManager.sharedInstance.valet.set(string: portText, forKey: "port")
                        MQTTManager.sharedInstance.valet.set(string: usernameText, forKey: "username")
                        MQTTManager.sharedInstance.valet.set(string: passwordText, forKey: "password")
                        
                        if let _ = MQTTManager.sharedInstance.mqtt {
                            MQTTManager.sharedInstance.mqtt.disconnect()
                        }
                        
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
}
