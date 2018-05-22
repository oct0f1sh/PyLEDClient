//
//  ViewController.swift
//  PyLEDClient
//
//  Created by Duncan MacDonald on 5/16/18.
//  Copyright © 2018 Duncan MacDonald. All rights reserved.
//

import UIKit
import SCLAlertView
import CocoaMQTT
import Valet

class DevicesViewController: UIViewController {
    let valet = Valet.valet(with: Identifier(nonEmpty: "MQTTInfo")!, accessibility: .whenUnlocked)
    var mqtt: CocoaMQTT!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DeviceDetailViewController {
            vc.title = "Device \(tableView.indexPathForSelectedRow!.row)"
        }
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let alertView = SCLAlertView()
        
        let url = alertView.addTextField("MQTT URL")
        url.keyboardType = .URL
        url.autocapitalizationType = .none
        url.autocorrectionType = .no
        if let storedUrl = self.valet.string(forKey: "url") {
            url.text = storedUrl
        }
        
        let port = alertView.addTextField("MQTT port")
        port.keyboardType = .numberPad
        if let storedPort = self.valet.string(forKey: "port") {
            port.text = storedPort
        }
        
        let username = alertView.addTextField("MQTT username")
        username.autocapitalizationType = .none
        username.autocorrectionType = .no
        if let storedUsername = self.valet.string(forKey: "username") {
            username.text = storedUsername
        }
        
        let password = alertView.addTextField("MQTT password")
        password.autocapitalizationType = .none
        password.autocorrectionType = .no
        if let storedPassword = self.valet.string(forKey: "password") {
            password.text = storedPassword
        }
        
        // TODO: Add input validation to MQTT server input
        alertView.addButton("Save") {
            let msg = "url: \(url.text!)\nport: \(port.text!)\nusername: \(username.text!)\npassword: \(password.text!)"
            
            print(String.dividedMessage(title: "Input MQTT Values", content: msg))
            
            self.valet.set(string: url.text!, forKey: "url")
            self.valet.set(string: port.text!, forKey: "port")
            self.valet.set(string: username.text!, forKey: "username")
            self.valet.set(string: password.text!, forKey: "password")
            
            if let _ = self.mqtt {
                self.mqtt.disconnect()
            }
        }
        
        alertView.showEdit("MQTT Settings",
                           subTitle: "Edit settings for your MQTT server.",
                           closeButtonTitle: "Cancel",
                           animationStyle: .topToBottom)
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        if let url = self.valet.string(forKey: "url") {
            if let port = self.valet.string(forKey: "port") {
                if let username = self.valet.string(forKey: "username") {
                    if let password = self.valet.string(forKey: "password") {
                        guard self.mqtt != nil else {
                            print(String.dividedMessage(title: "CONNECTING TO MQTT", content: nil))
                            let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
                            self.mqtt = CocoaMQTT(clientID: clientID, host: url, port: UInt16.init(port)!)
                            self.mqtt.username = username
                            self.mqtt.password = password
                            self.mqtt.willMessage = CocoaMQTTWill(topic: "test", message: "{\"message\": \"ios dieout\"}")
                            self.mqtt.keepAlive = 60
                            self.mqtt.delegate = self
                            self.mqtt.connect()
                            
                            return
                        }
                        print(String.dividedMessage(title: "ALREADY CONNECTED TO MQTT", content: nil))
                        
                        let alertView = SCLAlertView()
                        alertView.addButton("Clear") {
                            let args = "{\"r\": 0, \"g\": 0, \"b\": 0}"
                            let message = JSONFormatter.formatToJson(message: "solid_color", args: args)
                            
                            self.mqtt.publish("test", withString: message)
                        }
                        
                        alertView.addButton("Test strip") {
                            self.mqtt.publish("test", withString: "{\"message\": \"test strip\"}")
                        }
                        
                        alertView.addButton("Blue") {
                            self.mqtt.publish("test", withString: "{\"message\": \"blue\"}")
                        }
                        
                        alertView.addButton("RGB PICKER") {
                            let alrtView = SCLAlertView()
                            
                            let subview = RGBColorPicker(frame: CGRect(x: alrtView.view.bounds.minX, y: alrtView.view.bounds.minY, width: 216, height: 35 * 4))
                            
                            alrtView.customSubview = subview
                            
                            let args: String = "{\"r\": 255, \"g\": 25, \"b\": 25, \"duration\": 5}"
                            
                            let message = JSONFormatter.formatToJson(message: "solid_color", args: args)
                            
                            self.mqtt.publish("test", withString: message)
                            
                            alrtView.showInfo("RGB PICKER", subTitle: "nice")
                        }
                        
                        alertView.addButton("Disconnect") {
                            self.mqtt.disconnect()
                        }
                        
                        alertView.showNotice("LED COMMANDS", subTitle: "", closeButtonTitle: "Cancel")
                    }
                }
            }
        }
    }
}

extension DevicesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DeviceCellView = tableView.dequeueReusableCell(withIdentifier: "DeviceCell") as! DeviceCellView
        
        cell.deviceStatusView.backgroundColor = (indexPath.row % 2 == 0) ? .red : .green
        cell.deviceNameLabel.text = "Duncan's LED Strip \(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension DevicesViewController: UITableViewDelegate {
    
}


