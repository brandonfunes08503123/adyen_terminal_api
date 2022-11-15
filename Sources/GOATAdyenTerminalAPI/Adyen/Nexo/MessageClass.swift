//
//  MessageClass.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

enum MessageClass: String, Codable {
    case service = "Service"
    case device = "Device"
    case event = "Event"
}
