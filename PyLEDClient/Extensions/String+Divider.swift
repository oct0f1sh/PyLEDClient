//
//  String+Divider.swift
//  PyLEDClient
//
//  Created by Duncan MacDonald on 5/17/18.
//  Copyright © 2018 Duncan MacDonald. All rights reserved.
//

import Foundation

extension String {
    static func dividedMessage(title: String, content: String?, char: Character = "-") -> String {
        let dividerLength = 45
        var topDivider = "(\(title))"
        var bottomDivider = ""
        let titleLength = title.count + 2
        
        for _ in 0..<((dividerLength - titleLength) / 2) {
            topDivider.insert(char, at: topDivider.startIndex)
            topDivider.append(char)
        }
        
        if topDivider.count % 2 == 0 {
            topDivider.append(char)
        }
        
        for _ in topDivider {
            bottomDivider.append(char)
        }
        
        if let content = content {
            return (topDivider + "\n" + content + "\n" + bottomDivider)
        } else {
            return topDivider
        }
    }
}
