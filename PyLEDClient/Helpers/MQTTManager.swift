//
//  MQTTManager.swift
//  PyLEDClient
//
//  Created by Duncan MacDonald on 5/22/18.
//  Copyright © 2018 Duncan MacDonald. All rights reserved.
//

import Foundation
import CocoaMQTT
import Valet

class MQTTManager {
    static let sharedInstance = MQTTManager()
    var mqtt: CocoaMQTT!
    var valet = Valet.valet(with: Identifier(nonEmpty: "MQTTInfo")!, accessibility: .whenUnlocked)
    
    private init() {
        
    }
    
    func connectWithValet() {
        if let url = self.valet.string(forKey: "url") {
            if let port = self.valet.string(forKey: "port") {
                if let username = self.valet.string(forKey: "username") {
                    if let password = self.valet.string(forKey: "password") {
                        guard self.mqtt != nil else {
                            let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
                            self.mqtt = CocoaMQTT(clientID: clientID, host: url, port: UInt16.init(port)!)
                            self.mqtt.username = username
                            self.mqtt.password = password
                            self.mqtt.willMessage = CocoaMQTTWill(topic: "test", message: "{\"message\": \"ios dieout\"}")
                            self.mqtt.keepAlive = 60
                            self.mqtt.connect()
                            
                            return
                        }
                        print("ALREADY CONNECTED TO MQTT")
                    }
                }
            }
        }
    }
}


/*
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
 */
