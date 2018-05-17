//
//  ViewController.swift
//  PyLEDClient
//
//  Created by Duncan MacDonald on 5/16/18.
//  Copyright © 2018 Duncan MacDonald. All rights reserved.
//

import UIKit

class DevicesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DeviceDetailViewController {
            vc.title = "Device \(tableView.indexPathForSelectedRow!.row)"
        }
    }
}

extension DevicesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DeviceCellView = tableView.dequeueReusableCell(withIdentifier: "DeviceCell") as! DeviceCellView
        
        cell.deviceStatusView.backgroundColor = (indexPath.row % 2 == 0) ? .red : .green
        //cell.deviceNameLabel.text = "Device \(indexPath.row)"
        cell.deviceNameLabel.text = "Duncan's LED Strip"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension DevicesViewController: UITableViewDelegate {
    
}
