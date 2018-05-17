//
//  Device.swift
//  PyLEDClient
//
//  Created by Duncan MacDonald on 5/16/18.
//  Copyright © 2018 Duncan MacDonald. All rights reserved.
//

import Foundation

class Device {
    var topic: String
    var name: String
    
    init(topic: String, name: String) {
        self.topic = topic
        self.name = name
    }
}
