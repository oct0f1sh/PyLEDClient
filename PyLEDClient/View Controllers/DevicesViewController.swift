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
        cell.deviceStatusView.backgroundColor = cell.deviceStatusView.backgroundColor == .red ? .green : .red
        
        if let mqtt = MQTTManager.sharedInstance.mqtt {
            let status = mqtt.connState
            
            if status == .connected {
                cell.deviceStatusView.backgroundColor = .green
                cell.isUserInteractionEnabled = true
            } else {
                cell.deviceStatusView.backgroundColor = .red
                cell.isUserInteractionEnabled = false
            }
        } else {
            cell.deviceStatusView.backgroundColor = .red
            cell.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
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
        
        if let mqtt = MQTTManager.sharedInstance.mqtt {
            let status = mqtt.connState
            
            if status == .connected {
                cell.deviceStatusView.backgroundColor = .green
                cell.isUserInteractionEnabled = true
            }
        } else {
            cell.deviceStatusView.backgroundColor = .red
            cell.isUserInteractionEnabled = false
        }
        
        cell.deviceNameLabel.text = "Duncan's LED Strip \(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension DevicesViewController: UITableViewDelegate {
    
}


