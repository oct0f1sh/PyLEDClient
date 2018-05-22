//
//  SettingsViewController.swift
//  PyLEDClient
//
//  Created by Duncan MacDonald on 5/22/18.
//  Copyright © 2018 Duncan MacDonald. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MQTTSettingsViewController {
            vc.title = "MQTT Settings"
        }
    }
}

extension SettingsViewController: UITableViewDelegate {
    
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SettingsCellView = tableView.dequeueReusableCell(withIdentifier: "SettingsCell") as! SettingsCellView
        
        cell.settingsLabel.text = "MQTT Server Settings"
        
        return cell
    }
}
