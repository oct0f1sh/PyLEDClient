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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var connectionBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DeviceDetailViewController {
            vc.title = "Device \(tableView.indexPathForSelectedRow!.row)"
        } else if let vc = segue.destination as? SettingsViewController {
            vc.title = "Settings"
        }
    }
    
    func toggleConnectedStatus() {
        connectionBarButton.title = connectionBarButton.title == "Connect" ? "Disconnect" : "Connect"
        
        let cell: DeviceCellView = tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as! DeviceCellView
        
        cell.isUserInteractionEnabled = !cell.isUserInteractionEnabled
        
        cell.deviceStatusView.backgroundColor = cell.deviceStatusView.backgroundColor == .red ? .green : .red
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
//        if let url = self.valet.string(forKey: "url") {
//            if let port = self.valet.string(forKey: "port") {
//                if let username = self.valet.string(forKey: "username") {
//                    if let password = self.valet.string(forKey: "password") {
//                        guard self.mqtt != nil else {
//                            print(String.dividedMessage(title: "CONNECTING TO MQTT", content: nil))
//                            let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
//                            self.mqtt = CocoaMQTT(clientID: clientID, host: url, port: UInt16.init(port)!)
//                            self.mqtt.username = username
//                            self.mqtt.password = password
//                            self.mqtt.willMessage = CocoaMQTTWill(topic: "test", message: "{\"message\": \"ios dieout\"}")
//                            self.mqtt.keepAlive = 60
//                            self.mqtt.delegate = self
//                            self.mqtt.connect()
//
//                            return
//                        }
//                        print(String.dividedMessage(title: "ALREADY CONNECTED TO MQTT", content: nil))
//
//                        let alertView = SCLAlertView()
//                        alertView.addButton("Clear") {
//                            let args = "{\"r\": 0, \"g\": 0, \"b\": 0}"
//                            let message = JSONFormatter.formatToJson(message: "solid_color", args: args)
//
//                            self.mqtt.publish("test", withString: message)
//                        }
//
//                        alertView.addButton("Test strip") {
//                            self.mqtt.publish("test", withString: "{\"message\": \"test strip\"}")
//                        }
//
//                        alertView.addButton("Blue") {
//                            self.mqtt.publish("test", withString: "{\"message\": \"blue\"}")
//                        }
//
//                        alertView.addButton("RGB PICKER") {
//                            let alrtView = SCLAlertView()
//
//                            let subview = RGBColorPicker(frame: CGRect(x: alrtView.view.bounds.minX, y: alrtView.view.bounds.minY, width: 216, height: 35 * 4))
//
//                            alrtView.customSubview = subview
//
//                            let args: String = "{\"r\": 255, \"g\": 25, \"b\": 25, \"duration\": 5}"
//
//                            let message = JSONFormatter.formatToJson(message: "solid_color", args: args)
//
//                            self.mqtt.publish("test", withString: message)
//
//                            alrtView.showInfo("RGB PICKER", subTitle: "nice")
//                        }
//
//                        alertView.addButton("Disconnect") {
//                            self.mqtt.disconnect()
//                        }
//
//                        alertView.showNotice("LED COMMANDS", subTitle: "", closeButtonTitle: "Cancel")
//                    }
//                }
//            }
//        }
//    }
        if let _ = MQTTManager.sharedInstance.mqtt {
            // ALREADY CONNECTED - DISCONNECT
            MQTTManager.sharedInstance.mqtt.disconnect()
        } else {
            MQTTManager.sharedInstance.createClient() {
                MQTTManager.sharedInstance.mqtt.delegate = self
                MQTTManager.sharedInstance.mqtt.connect()
            }
        }
    }
}

extension DevicesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DeviceCellView = tableView.dequeueReusableCell(withIdentifier: "DeviceCell") as! DeviceCellView
        
        cell.deviceStatusView.backgroundColor = .red
        cell.deviceNameLabel.text = "Duncan's LED Strip \(indexPath.row)"
        
        cell.isUserInteractionEnabled = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension DevicesViewController: UITableViewDelegate {
    
}


