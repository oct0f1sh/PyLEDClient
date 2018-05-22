//
//  DevicesViewController+CocoaMQTT.swift
//  PyLEDClient
//
//  Created by Duncan MacDonald on 5/22/18.
//  Copyright © 2018 Duncan MacDonald. All rights reserved.
//

import Foundation
import CocoaMQTT
import UIKit
import SCLAlertView

extension DevicesViewController: CocoaMQTTDelegate {
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        print(String.dividedMessage(title: "CONNECTION ACKNOWLEDGED", content: nil))
        
        self.toggleConnectedStatus()
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print(String.dividedMessage(title: "PUBLISHED MESSAGE", content: message.string))
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        print(String.dividedMessage(title: "PUBLISH ACKNOWLEDGED", content: nil))
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        print(String.dividedMessage(title: "MESSAGE RECEIVED", content: message.string))
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topic: String) {
        print(String.dividedMessage(title: "SUBSCRIBED TO TOPIC", content: "topic: \(topic)"))
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
        print(String.dividedMessage(title: "UNSUBSCRIBED FROM TOPIC", content: "topic: \(topic)"))
    }
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        print(String.dividedMessage(title: "PINGED SERVER", content: nil))
    }
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        print(String.dividedMessage(title: "RECEIVED PING", content: nil))
    }
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        print(String.dividedMessage(title: "DISCONNECTED FROM SERVER", content: (err != nil ? err?.localizedDescription : nil)))
        
        if let _ = err {
            let alertView = SCLAlertView()
            
            alertView.showNotice("ERROR CONNECTING", subTitle: "Invalid MQTT Server info, please correct it in settings.")
        } else {
            self.toggleConnectedStatus()
        }
        
        MQTTManager.sharedInstance.mqtt = nil
    }
}
