//
//  MessageHeader.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public struct MessageHeader: Codable {
    public let protocolVersion: String?
    public let messageClass: MessageClass
    public let messageCategory: MessageCategory
    public let messageType: MessageType
    public let serviceID: String?
    public let deviceID: String?
    public let saleID: String
    public let pOIID: String
}
