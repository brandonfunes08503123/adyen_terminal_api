//
//  MessageType.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

enum MessageType: String, Codable {
    case request = "Request"
    case response = "Response"
}
