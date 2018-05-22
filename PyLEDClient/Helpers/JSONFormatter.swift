//
//  JSONFormatter.swift
//  PyLEDClient
//
//  Created by Duncan MacDonald on 5/22/18.
//  Copyright © 2018 Duncan MacDonald. All rights reserved.
//

import Foundation

class JSONFormatter {
    static func formatToJson(message: String, args: String) -> String {
        return "{\"message\": \"\(message)\", \"args\": \(args)}"
    }
}
