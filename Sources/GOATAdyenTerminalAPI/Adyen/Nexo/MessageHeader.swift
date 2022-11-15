//
//  MessageHeader.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

struct MessageHeader: Codable {
    let protocolVersion: String?
    let messageClass: MessageClass
    let messageCategory: MessageCategory
    let messageType: MessageType
    let serviceID: String?
    let deviceID: String?
    let saleID: String
    let pOIID: String
}
